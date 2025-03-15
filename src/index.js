//Importar bibliotecas

const express = require("express");
const cors = require("cors");
require("dotenv").config();
const mysql = require("mysql2/promise");

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

//Configuración del servidor
const app = express();

app.use(cors());
app.use(express.json());

//Arrancamos el servidor

const port = process.env["PORT"] || 3000;

app.listen(port, () => {
  console.log(`App listening at <http://localhost:${port}>`);
});

//Endpoints

app.get("/api/books", async (req, res) => {
  const conn = await getConnection();

  const [results] = await conn.query(`SELECT * FROM books;`);

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
    (name, description, ages_id_age, publishters_id_publishter)
    VALUES (?,?,?,?);`,
    [
      req.body.name,
      req.body.description,
      req.body.ages_id_age,
      req.body.publishters_id_publishter,
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

    res.json({
      success: true,
    });
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.toString(),
    });
  }
});

app.delete("/api/authors/:id", async (req, res) => {
  try {
    const conn = await getConnection();

    const [result] = await conn.execute(
      `
    DELETE FROM authors
    WHERE id_author=?;`,
      [req.params.id]
    );

    await conn.end();
    if (result.affectedRows > 0) {
      res.json({ success: true, message: "author removed" });
    } else {
      res.status(404).json({
        success: false,
        message: "No author found with that ID.",
      });
    }
  } catch (err) {
    res.status(500).json({
      success: false,
      message: err.toString(),
    });
  }
});
