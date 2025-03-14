//Importar bibliotecas

const express = require("express");
const cors = require("cors");
const mysql = require("mysql2/promise");

//Configuración del servidor
const app = express();

app.use(cors());
app.use(express.json());

//Arrancamos el servidor

const port = 3000;
app.listen(port, () => {
  console.log(`Example app listening on port <http://localhost:${port}>`);
});

//Endpoints
