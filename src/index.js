//Importar bibliotecas

const express = require("express");
const cors = require("cors");
require("dotenv").config();
const mysql = require("mysql2/promise");

//Autenticación
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const saltRounds = 10;

//Configuración Express

const app = express();

app.use(cors());
app.use(express.json());

//Arrancamos el servidor

const port = process.env["PORT"] || 3000;

app.listen(port, () => {
  console.log(`App listening at <http://localhost:${port}>`);
});

async function getConnection() {
  const connectionData = {
    host: process.env["MYSQL_HOST"],
    port: process.env["MYSQL_PORT"],
    user: process.env["MYSQL_USER"],
    password: process.env["MYSQL_PASS"],
    database: process.env["MYSQL_SCHEMA"],
  };
  console.log(connectionData);
  const connection = await mysql.createConnection(connectionData);
  await connection.connect();

  return connection;
}

//Endpoints

app.get("/api/books", async (req, res) => {
  const conn = await getConnection();

  //const [results] = await conn.query(`SELECT * FROM books;`);

  const [results] = await conn.query(`
    SELECT id_book, name, description, id_age, age_range,
    id_publishter, publishter, 
    id_rating, rating, 
    id_book_signing, place,date,community

    FROM books

    JOIN ages ON books.ages_id_age = ages.id_age
    JOIN publishters ON books.publishters_id_publishter = publishters.id_publishter
    JOIN ratings ON books.ratings_id_rating = ratings.id_rating
    JOIN book_signing ON books.book_signing_id_book_signing = book_signing.id_book_signing;
    ;`);

  await conn.end();

  const numOfElements = results.length;

  res.json({
    info: { count: numOfElements },
    results: results,
  });
});

app.post("/api/books", async (req, res) => {
  if (!req.body.name || req.body.name === "") {
    return res.status(400).json({
      success: false,
      error: "the name is incorrect",
    });
  }

  const conn = await getConnection();

  const [result] = await conn.execute(
    `INSERT INTO books
    (name, description, ages_id_age, publishters_id_publishter, ratings_id_rating, book_signing_id_book_signing)
    VALUES (?,?,?,?,?,?);`,
    [
      req.body.name,
      req.body.description,
      req.body.ages_id_age,
      req.body.publishters_id_publishter,
      req.body.ratings_id_rating,
      req.body.book_signing_id_book_signing,
    ]
  );

  await conn.end();

  res.json({
    success: true,
    id: result.insertId,
    bookObj: {
      ...req.body,
      id: result.insertId,
    },
  });
});

app.put("/api/books/:id", async (req, res) => {
  try {
    const conn = await getConnection();

    const [result] = await conn.execute(
      `
    UPDATE books
    SET name=?, description=?, ages_id_age=?, publishters_id_publishter=?, ratings_id_rating=?, book_signing_id_book_signing=?
    WHERE id_book=?;`,
      [
        req.body.name,
        req.body.description,
        req.body.ages_id_age,
        req.body.publishters_id_publishter,
        req.body.ratings_id_rating,
        req.body.book_signing_id_book_signing,
        req.params.id,
      ]
    );

    await conn.end();

    if (result.affectedRows > 0) {
      res.json({ success: true, message: "book update" });
    } else {
      res.status(404).json({
        success: false,
        message: "Not update.",
      });
    }
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.toString(),
    });
  }
});

app.delete("/api/books/:id", async (req, res) => {
  try {
    const conn = await getConnection();

    const [result] = await conn.execute(
      `
    DELETE FROM books
    WHERE id_book=?;`,
      [req.params.id]
    );

    await conn.end();

    if (result.affectedRows > 0) {
      res.json({ success: true, message: "book removed" });
    } else {
      res.status(404).json({
        success: false,
        message: "No book found with that ID.",
      });
    }
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.toString(),
    });
  }
});

app.get("/api/books/:id", async (req, res) => {
  try {
    const conn = await getConnection();

    const [result] = await conn.execute(
      ` SELECT id_book, name, description, id_age, age_range,
    id_publishter, publishter, 
    id_rating, rating, 
    id_book_signing, place,date,community

    FROM books

    JOIN ages ON books.ages_id_age = ages.id_age
    JOIN publishters ON books.publishters_id_publishter = publishters.id_publishter
    JOIN ratings ON books.ratings_id_rating = ratings.id_rating
    JOIN book_signing ON books.book_signing_id_book_signing = book_signing.id_book_signing
    
    WHERE id_book=?;`,
      [req.params.id]
    );

    await conn.end();

    res.json(result);
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.toString(),
    });
  }
});

// Registro y Login

app.post("/api/register", async (req, res) => {
  try {
    if (!req.body.name || req.body.name === "") {
      return res.status(400).json({
        success: false,
        error: "the name is incorrect",
      });
    }

    const conn = await getConnection();

    const [resultCheck] = await conn.query(
      `
    SELECT *
    FROM users
    WHERE email = ?;`,
      [req.body.email]
    );

    if (resultCheck.length > 0) {
      return res.status(409).json({
        success: false,
        error: "the email already exists",
      });
    }

    //Ciframos la contraseña

    const hiddenPassword = await bcrypt.hash(req.body.password, saltRounds);

    const [resultInsert] = await conn.execute(
      `INSERT INTO users
     (email, name, password)
    VALUES (?,?,?);`,
      [req.body.email, req.body.name, hiddenPassword]
    );

    const payload = {
      name: req.body.name,
      email: req.body.email,
    };

    const token = jwt.sign(payload, process.env.JWT_PASS, {
      expiresIn: "2h",
    });

    await conn.end();

    res.json({
      success: true,
      token: token,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      error: err,
    });
  }
});

app.post("api/login", async (req, res) => {
  if (!req.body.email) {
    return res.status(400).json({
      status: false,
      error: "Email not specified",
    });
  }
  if (!req.body.password) {
    return res.status(400).json({
      status: false,
      error: "Password not specified",
    });
  }

  const conn = await getConnection();

  const [resultCheck] = await conn.query(
    `SELECT *
    FROM users
    WHERE email = ?;`,
    [req.body.email]
  );

  await conn.end();

  if (resultCheck.length === 0) {
    return res.status(404).json({
      status: false,
      error: "Las credenciales no son válidas",
    });
  }

  const [userData] = resultCheck;

  if (await bcrypt.compare(req.body.password, userData.password)) {
    // Generar el JWT.

    const payload = {
      id_user: userData.id_user,
      name: userData.name,
      email: userData.email,
    };

    console.log(payload);
    const token = jwt.sign(payload, process.env.JWT_PASS, {
      expiresIn: "2h",
    });

    res.json({
      success: true,
      token: token,
    });
  } else {
    res.status(400).json({
      success: false,
      error: "Login incorrecto",
    });
  }
});
