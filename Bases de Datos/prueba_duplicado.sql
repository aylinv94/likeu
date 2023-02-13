-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: localhost    Database: prueba
-- ------------------------------------------------------
-- Server version	8.0.32-0ubuntu0.22.04.2

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
-- Table structure for table `duplicado`
--

DROP TABLE IF EXISTS `duplicado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `duplicado` (
  `id_cliente` varchar(15) DEFAULT NULL,
  `documento` bigint NOT NULL,
  `tipo_documento` varchar(40) DEFAULT NULL,
  `nombre` varchar(60) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `duplicado`
--

LOCK TABLES `duplicado` WRITE;
/*!40000 ALTER TABLE `duplicado` DISABLE KEYS */;
INSERT INTO `duplicado` VALUES ('TI3184064466',3184064466,'Tarjeta De Identidad','Cristiam De Jesus Obredor Pe?Aranda','5178891','calle 20#28-38 barrio el recreo'),('CC3184064466',3184064466,'Cedula De Ciudadania','Claudia Patricia Ibarra Granobles','5907653','calle 190bis #6b-20 casa buenavista 1 sector bogot?'),('CC4067521167',4067521167,'Cedula De Ciudadania','Ana Gabriela Licet Figueroa','1965356','av 31 # 66 -29 niquia urb cerro azul apto 1311'),('CC4067521167',4067521167,'Cedula De Ciudadania','Geraldine Alvarez Henao','6446535','calle 57 num 68c - 163 apto 608 torre 2'),('CC5669575605',5669575605,'Cedula De Ciudadania','Katerine Andrea Rodriguez Leyva','73364528','carrera 39b # 40a 06, barrio el salvador'),('CC5669575605',5669575605,'Cedula De Ciudadania','Ricardo Andre? Rojas Loaiza','6372812','colombia'),('CC9112240869',9112240869,'Cedula De Ciudadania','Solis Galvis','8721357','cr 119d 128b-49 barrio aures ii'),('CE9112240869',9112240869,'Cedula De Extranjeria','Stefanny Jaramillo Salcedo','4633992','cr 121 cl 48b-17'),('CC24453181431',24453181431,'Cedula De Ciudadania','Andres Felipe Lopez Gonzalez','6929559','barrio ortiz, cra. 101 #98-11.'),('CC24453181431',24453181431,'Cedula De Ciudadania','Jorge Gomez Triana','8842978','carrera 100a #141- 10'),('CC35221032842',35221032842,'Cedula De Ciudadania','Andersson Manuel Lira Ramirez','6254082','av calle 145#85-80'),('P35221032842',35221032842,'Pasaporte','Deisy Tatiana Redondo Aristizabal','2278173','calle 32 b no. 50 - 14'),('CC35221032842',35221032842,'Cedula De Ciudadania','Erika Marcela Vanegas Hincap?E','6620278','calle 48 #46 d-111'),('CC47823160152',47823160152,'Cedula De Ciudadania','Maria Estefania Montoya Cardona','9310478','cl 41 c sur cr 61b-20 segundo piso barrio pradito en san antonio de prado'),('CE47823160152',47823160152,'Cedula De Extranjeria','Wendy Juliana Agudelo Posada','46859184','cr 52 # 1- 33'),('CC98818614032',98818614032,'Cedula De Ciudadania','Claudia Jazmin Urrego Garcia','7064636','calle 185 c # 4-30'),('CC98818614032',98818614032,'Cedula De Ciudadania','Jhon Alexander Montoya Iriarte','2873843','calle 95 a #40 -59 interior 402'),('CC98941698265',98941698265,'Cedula De Ciudadania','Valentina Qui?Onez Velasquez','1257930','cr 42 # 63-31'),('CC98941698265',98941698265,'Cedula De Ciudadania','Carlos Augusto Marin Cifuentes','9057870','calle 14 no.22-130 b/parque recreacional, salida a dosquebradas');
/*!40000 ALTER TABLE `duplicado` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-12 21:41:05
