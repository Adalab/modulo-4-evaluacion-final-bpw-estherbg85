# API Libros Infantiles

Esta es una API REST para gestionar libros. Permite realizar operaciones CRUD (Crear, Leer, Actualizar, Eliminar) sobre una base de datos de libros y sus relaciones con otras tablas, como edades, editoriales, valoraciones y firmas de libros.

## Requisitos previos

- Node.js
- MySQL
- Studio Visual Code
- Postman (para probar los endpoints)

## Instalación

### 1. Clonar el repositorio

- git clone https://github.com/Adalab/modulo-4-evaluacion-final-bpw-estherbg85. git

### 2. Instalamos las dependencias

- Express: npm i express
- Cors: npm i cors
- Mysql: npm i mysql2
- Dotenv: npm i dotenv

### 3. Configuramos el archivo .env

- MYSQL_HOST=localhost
- MYSQL_PORT=3306
- MYSQL_USER=root
- MYSQL_PASS=tu_contraseña_mysql
- MYSQL_SCHEMA=tu_base_de_datos
- PORT=3000 ( puerto por defecto )

## Endpoints que he realizado

### [GET] /api/books. Nos devuelve todos los libros con su información

Ejemplo:

{
"info": {
"count": 15
},
"results": [
{
"id_book": 17,
"name": "luna",
"description": "Poema visual recitable, a base de dibujos rimados y ritmados. La luna y el sol, tan lejanos y próximos, tejen versos y estribillos desde el cielo hasta estas páginas de cartón.",
"ages_id_age": 1,
"publishters_id_publishter": 1,
"ratings_id_rating": 3,
"book_signing_id_book_signing": 6
}

### [POST] /api/books. Nos permite crear un nuevo libro. Debe incluir todos los campos. Ademas va añadido un condicional, si no se rellena el campo name o se queda vacío nos devuelve un error.

Ejemplo:

{
"description": "Lorem ipsum",
"ages_id_age": 1,
"publishters_id_publishter": 5,
"ratings_id_rating": 3,
"book_signing_id_book_signing": 6
}

Respuesta:

{
"success": false,
"error": "the name is incorrect"
}

### [PUT] /api/libros/:id. Nos permite actualizar la información de un libro existente, utilizando su id_book.

Ejemplo:

{
"id_book": 25,
"name": "cucu tras de animales del polo",
"description": "Descripcion nueva incluida",
"ages_id_age": 2,
"publishters_id_publishter": 2,
"ratings_id_rating": 3,
"book_signing_id_book_signing": 10
}

Respuesta:

{
"success": true,
"message": "book update"
}

### [DELETE] /api/libros/:id. Nos permite eliminar un libro existente utilizando su id_book.

Ejemplo:

{
"id_book": 17,
"name": "luna",
"description": "Poema visual recitable, a base de dibujos rimados y ritmados. La luna y el sol, tan lejanos y próximos, tejen versos y estribillos desde el cielo hasta estas páginas de cartón.",
"ages_id_age": 1,
"publishters_id_publishter": 1,
"ratings_id_rating": 3,
"book_signing_id_book_signing": 6
}

Respuesta:

{
"success": true,
"message": "book removed"
}

### [GET] /api/libros/:id. Nos devuelve la informacion de un libro específico utilizando su id_book. Usando Url params.

Este `README.md` proporciona instrucciones claras sobre cómo instalar, configurar y ejecutar el proyecto, así como detalles sobre los endpoints disponibles para interactuar con la API.

Así mismo tiene en el repositorio un archivo adjunto:

### Api Books.postman_collection.json

Donde tiene una collection de Books en Postman.
