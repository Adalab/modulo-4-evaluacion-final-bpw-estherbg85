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
  console.log(req.body);
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
