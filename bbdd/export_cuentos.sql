CREATE DATABASE  IF NOT EXISTS `cuentos` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cuentos`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cuentos
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ages`
--

DROP TABLE IF EXISTS `ages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ages` (
  `id_age` int NOT NULL AUTO_INCREMENT,
  `age_range` varchar(45) NOT NULL,
  PRIMARY KEY (`id_age`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ages`
--

LOCK TABLES `ages` WRITE;
/*!40000 ALTER TABLE `ages` DISABLE KEYS */;
INSERT INTO `ages` VALUES (1,'0-1'),(2,'1-2'),(3,'2-3');
/*!40000 ALTER TABLE `ages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors` (
  `id_author` int NOT NULL AUTO_INCREMENT,
  `author` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_author`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (1,'Antonio Rubio Y Oscar Villán'),(2,'Ingela P Arrhenius'),(3,'Nick Denchfield'),(4,'Marion Billet'),(5,'Yayo Kawamura'),(6,'AA. VSMV'),(7,'Francesca Ferri'),(8,'Julia Donaldson'),(9,'Eric Carle'),(10,'Mon Daporta'),(11,'Herve Tullet'),(12,'Jean-Marc Derqueen y Luare de Faya');
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authors_create_books`
--

DROP TABLE IF EXISTS `authors_create_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors_create_books` (
  `books_id_cuento` int NOT NULL,
  `authors_id_author` int NOT NULL,
  PRIMARY KEY (`books_id_cuento`,`authors_id_author`),
  KEY `fk_books_has_authors_authors1_idx` (`authors_id_author`),
  KEY `fk_books_has_authors_books_idx` (`books_id_cuento`),
  CONSTRAINT `fk_books_has_authors_authors1` FOREIGN KEY (`authors_id_author`) REFERENCES `authors` (`id_author`),
  CONSTRAINT `fk_books_has_authors_books` FOREIGN KEY (`books_id_cuento`) REFERENCES `books` (`id_cuento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors_create_books`
--

LOCK TABLES `authors_create_books` WRITE;
/*!40000 ALTER TABLE `authors_create_books` DISABLE KEYS */;
INSERT INTO `authors_create_books` VALUES (17,1),(18,1),(19,2),(20,3),(22,3),(21,4),(23,5),(24,6),(25,7),(26,7),(27,8),(28,9),(29,10),(30,11),(31,12);
/*!40000 ALTER TABLE `authors_create_books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `books`
--

DROP TABLE IF EXISTS `books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `books` (
  `id_cuento` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` text NOT NULL,
  `ages_id_age` int NOT NULL,
  `publishters_id_publishter` int NOT NULL,
  PRIMARY KEY (`id_cuento`),
  KEY `fk_books_ages1_idx` (`ages_id_age`),
  KEY `fk_books_publishters1_idx` (`publishters_id_publishter`),
  CONSTRAINT `fk_books_ages1` FOREIGN KEY (`ages_id_age`) REFERENCES `ages` (`id_age`),
  CONSTRAINT `fk_books_publishters1` FOREIGN KEY (`publishters_id_publishter`) REFERENCES `publishters` (`id_publishter`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `books`
--

LOCK TABLES `books` WRITE;
/*!40000 ALTER TABLE `books` DISABLE KEYS */;
INSERT INTO `books` VALUES (17,'luna','Poema visual recitable, a base de dibujos rimados y ritmados. La luna y el sol, tan lejanos y próximos, tejen versos y estribillos desde el cielo hasta estas páginas de cartón.',1,1),(18,'cocodrilo','La colección De la cuna a la luna está dirigida a niños y niñas de 0 a 3 años de edad, para quienes se han diseñado especialmente estos pictogramas poéticos o poegramas; un término acuñado para designar una nueva modalidad de poesía pictográfica basada en la búsqueda de un ritmo de lectura que ayude a educar el ojo y endulzar el oído, del pequeño lector, como explica Antonio Rubio. Por su parte, Óscar Villán -Premio Nacional de Ilustración 1999- elabora la propuesta estética de estos cinco libros. Su trabajo es totalmente artesanal, con pinceladas y tonalidades de color fácilmente apreciables, hasta el punto de que las texturas pueden casi palparse. La imagen resalta sobre un fondo claro; el dibujo es sencillo y reconocible, con el toque personal de Villán.',1,1),(19,'cucu tras luna','Este libro incluye las rutinas de antes de ir a dormir: cepillarnos los dientes, apagar la luz y muchas otras sorpresas. Contiene 10 mecanismos hiperfáciles de usar para que las pequeñas manos puedan deslizar, girar y mover las solapas y lengüetas y hacer aparecer divertidos personajes. Además, los mecanismos se encuentran en todas las páginas, de manera que permiten desarrollar ambas lateralidades. Al final del libro encontrarán un espejo para mirarse y sorprenderse. Los acabados son de altísima calidad y el formato en cartón resistente permite que los bebés lo manipulen a su antojo y disfruten de sus primeras experiencias con el formato libro.',1,5),(20,'el pollo pepe se da un baño','Un divertido libro de baño para que el bebé descubra al pollo Pepe y sus amigos. ¿Quién chapotea en la bañera? ¿Es el perro López o la rana Ramona?',1,2),(21,'los animalitos, primer libro de sonidos','Un libro con 6 sonidos y 6 imágenes de las siguientes crías de animales: Los corderitos El gatito El burrito El perrito El cerdito Los pollitos',1,5),(22,'el pollo pepe','El pollo Pepe está creciendo mucho porque come muy bien pero su mamá es mucho más grande que él. El pollo Pepe es un cuento POP UP y un éxito de ventas que hace furor entre los niños de 1 y 2 años.',2,2),(23,'pepe y mila pasan el dia en la granja','Es otoño y Pepe y Mila pasan el día en la granja de su amigo Coco. Riegan el huerto, recogen las manzanas y cosechan las calabazas, ordeñan a la vaca, van al gallinero y ven muchos animales. Un pack que contiene un libro de cartón con solapas y lengüetas para que el niño descubra la vida en la granja y un muñeco del perro Pepe.',2,2),(24,'cucu tras','Este libro invita al niño a jugar al que quizás sea el primer juego que aprende: el Cucú-tras.Le gustará observar las grandes ilustraciones de alegres colores y se divertirá levantando las solapas tras las que se esconden diferentes animales de granja.',2,2),(25,'cucu tras de animales del polo','Este libro invita al niño a jugar al que quizás sea el primer juego que aprende: el Cucú-tras. Le gustará observar las grandes ilustraciones de alegres colores y se divertirá levantando las solapas tras las que se esconden diferentes animales que viven en el Polo.',2,2),(26,'cucu tras de la selva','Este libro invita al niño a jugar al que quizás sea el primer juego que aprende: el Cucú-tras. Le gustará observar las grandes ilustraciones de alegres colores y se divertirá levantando las solapas tras las que se esconden diferentes animales que viven en la selva y la sabana.',2,2),(27,'busca al grufalo','¡Levanta las solapas para encontrar al grúfalo! El pequeño ratón lo está buscando, ¿le ayudas a encontrarlo? Asómate a las rocas, mueve los arbustos, observa con atención la copa de los árboles ¡y descubre todos los secretos que esconde el bosque!',3,4),(28,'la pequeña oruga glotona','La oruga era muy pequeña, pero tenía un hambre enorme. Así que se pasó todo este cuento comiendo, atravesando página tras página. Hasta que finalmente se convirtió, como todas las orugas, en mariposa. Un libro agujereado de verdad por la muy glotona',3,3),(29,'un bicho extraño','Rima y ritmo, para descubrir la función lúdica de la lectura. Un bicho extraño es un pequeño libro de cartón para primeros lectores, de los llamados cuentos sin fin, porque pasando las páginas y dándole la vuelta al cuento..',3,1),(30,'un libro ','Al abrir este libro solo se ve un círculo amarillo sobre la página en blanco. Entonces, se invita al lector a pulsar ese círculo con el dedo y averiguar qué ocurre. ¿Qué niño curioso podría resistirse a semejante desafío? Para saber la respuesta simplemente hay que dar la vuelta a la página ¡Y así empieza la magia! Círculos rojos, amarillos y azules se desdoblan, cambian de lugar, se colocan en fila, crecen Incluso están a punto de caerse por el borde del libro o volar hasta desaparecer. Todo depende de lo que el niño haga, si los aprieta, los frota, sopla sobre ellos o los agita.',3,3),(31,'voy a comedte','Un lobo malo, hambriento y que habla de una forma rarísima espera en el bosque a que aparezca un delicioso bocado. Con tan mala suerte que se topa con un par de conejitos listos que le quitarán un pelo que tiene en la lengua y, sobre todo ¡las ganas de comer carne! El primer conejo descubre que el lobo habla raro porque tiene un pelo en la lengua. Le promete extraérselo y, con esa artimaña, escapa. Otro conejo lo engaña enseñándole a cazar bien. El lobo finalmente se equivoca, ataca a un oso y en su huída se da un trastazo y pierde los dientes. ¡Y se hace vegetariano! ',3,3);
/*!40000 ALTER TABLE `books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publishters`
--

DROP TABLE IF EXISTS `publishters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publishters` (
  `id_publishter` int NOT NULL AUTO_INCREMENT,
  `publishter` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_publishter`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publishters`
--

LOCK TABLES `publishters` WRITE;
/*!40000 ALTER TABLE `publishters` DISABLE KEYS */;
INSERT INTO `publishters` VALUES (1,'kalandraka'),(2,'sm'),(3,'kokinos'),(4,'bruño'),(5,'timun mas');
/*!40000 ALTER TABLE `publishters` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-14 11:51:37
