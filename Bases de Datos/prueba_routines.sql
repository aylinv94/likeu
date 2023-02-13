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
-- Temporary view structure for view `vista_totales3`
--

DROP TABLE IF EXISTS `vista_totales3`;
/*!50001 DROP VIEW IF EXISTS `vista_totales3`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_totales3` AS SELECT 
 1 AS `id_cliente`,
 1 AS `cantidad_ventas`,
 1 AS `valor_total`,
 1 AS `cantidad_gestiones`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vista_totales_DESC`
--

DROP TABLE IF EXISTS `vista_totales_DESC`;
/*!50001 DROP VIEW IF EXISTS `vista_totales_DESC`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vista_totales_DESC` AS SELECT 
 1 AS `id_cliente`,
 1 AS `cantidad_ventas`,
 1 AS `valor_total`,
 1 AS `cantidad_gestiones`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vista_totales3`
--

/*!50001 DROP VIEW IF EXISTS `vista_totales3`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_totales3` AS select `v`.`id_cliente` AS `id_cliente`,count(`v`.`id_venta`) AS `cantidad_ventas`,sum(`v`.`valor`) AS `valor_total`,count(`g`.`id_gestion`) AS `cantidad_gestiones` from (`venta` `v` join `gestion` `g` on((`v`.`id_cliente` = `g`.`id_cliente`))) group by `v`.`id_cliente` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vista_totales_DESC`
--

/*!50001 DROP VIEW IF EXISTS `vista_totales_DESC`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vista_totales_DESC` AS select `v`.`id_cliente` AS `id_cliente`,count(`v`.`id_venta`) AS `cantidad_ventas`,sum(`v`.`valor`) AS `valor_total`,count(`g`.`id_gestion`) AS `cantidad_gestiones` from (`venta` `v` join `gestion` `g` on((`v`.`id_cliente` = `g`.`id_cliente`))) group by `v`.`id_cliente` order by sum(`v`.`valor`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-12 21:41:05
