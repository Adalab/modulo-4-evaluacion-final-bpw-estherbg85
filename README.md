# API Libros Infantiles

Esta es una API REST para gestionar libros. Permite realizar operaciones CRUD (Crear, Leer, Actualizar, Eliminar) sobre una base de datos de libros y sus relaciones con otras tablas, como edades, editoriales, valoraciones y firmas de libros.

## Requisitos previos

- Node.js
- MySQL
- Studio Visual Code
- Postman (para probar los endpoints)

## Instalación

### 1. Clonar el repositorio

- git clone https://github.com/Adalab/modulo-4-evaluacion-final-bpw-estherbg85.git

### 2. Instalamos las dependencias

- Express: npm i express
- Cors: npm i cors
- Mysql: npm i mysql2
- Dotenv: npm i dotenv
- Bcrypt: npm i bcrypt
- Jwt: npm i jsonwebtoken

### 3. Configuramos el archivo .env

- MYSQL_HOST=localhost
- MYSQL_PORT=3306
- MYSQL_USER=root
- MYSQL_PASS=tu_contraseña_mysql
- MYSQL_SCHEMA=tu_base_de_datos
- PORT=3000 ( puerto por defecto )

- JWT_PASS="3contraseña inventada"

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

Ejemplo:

http://localhost:3000/api/books/19

Respuesta:

"id_book": 19,
"name": "cucu tras luna",
"description": "Este libro incluye las rutinas de antes de ir a dormir: cepillarnos los dientes, apagar la luz y muchas otras sorpresas. Contiene 10 mecanismos hiperfáciles de usar para que las pequeñas manos puedan deslizar, girar y mover las solapas y lengüetas y hacer aparecer divertidos personajes. Además, los mecanismos se encuentran en todas las páginas, de manera que permiten desarrollar ambas lateralidades. Al final del libro encontrarán un espejo para mirarse y sorprenderse. Los acabados son de altísima calidad y el formato en cartón resistente permite que los bebés lo manipulen a su antojo y disfruten de sus primeras experiencias con el formato libro.",
"id_age": 1,
"age_range": "0-1",
"id_publishter": 5,
"publishter": "timun mas",
"id_rating": 3,
"rating": "excelente",
"id_book_signing": 6,
"place": "ifema",
"date": "2025-03-31T22:00:00.000Z",
"community": "madrid"
}
]

### [POST] /api/register. Nos permite registrar a un nuevo usuario en la base de datos.

Esta ruta recibe una solicitud de registro con los datos del usuario (correo electrónico, nombre y contraseña).
La contraseña sale encriptada.

Si la solicitud es válida, el servidor registra al usuario en la base de datos y genera un token JWT para autenticar futuras solicitudes del usuario.

Si la solicitud es incorrecta (por ejemplo, si falta un campo obligatorio o el correo electrónico ya está en uso), se devuelve un mensaje de error.

### [POST] /api/login. Nos permite a un usuario autenticarse y obtener un token JWT.

Si la solicitud es válida, registra a la usuaria, generando un token.

Si la solicitud no es válida, devuelve un error de login incorrecto.

### FUNCION MiddlewareAuthenticate. Se utiliza para verificar la validez del token JWT. Asegura que las rutas protegidas solo puedan ser accedidas por usuarios con un token válido.

Si no se valida nos devuelve un error de credenciales

Este `README.md` proporciona instrucciones claras sobre cómo instalar, configurar y ejecutar el proyecto, así como detalles sobre los endpoints disponibles para interactuar con la API.

Así mismo tiene en el repositorio un archivo adjunto:

### Api Books.postman_collection.json

Donde tiene una collection de Books en Postman.
