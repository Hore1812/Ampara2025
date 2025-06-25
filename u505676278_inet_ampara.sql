-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 25-06-2025 a las 05:53:59
-- Versión del servidor: 10.11.10-MariaDB-log
-- Versión de PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `u505676278_inet_ampara`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `adendacliente`
--

CREATE TABLE `adendacliente` (
  `idadendacli` int(11) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `fechainicio` date NOT NULL,
  `fechafin` date NOT NULL,
  `horasfijasmes` int(11) NOT NULL,
  `horasmaxbolsa` int(11) NOT NULL,
  `planhorasfijas` int(11) NOT NULL,
  `comentarios` varchar(500) NOT NULL,
  `idcontratocli` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `adendacliente`
--

INSERT INTO `adendacliente` (`idadendacli`, `descripcion`, `fechainicio`, `fechafin`, `horasfijasmes`, `horasmaxbolsa`, `planhorasfijas`, `comentarios`, `idcontratocli`) VALUES
(1, 'Adenda 1 CALA', '2023-09-01', '2024-02-29', 8, 2, 10, '', 1),
(2, 'Adenda 2 CALA', '2024-03-01', '2025-02-28', 10, 2, 12, '', 1),
(3, 'Adenda 1 DOLPHIN', '2024-09-01', '2025-08-31', 10, 0, 10, '', 2),
(4, 'Adenda 1 IPT', '2021-08-18', '2022-08-17', 8, 2, 10, '', 3),
(5, 'Adenda 2 IPT', '2022-08-18', '2023-08-17', 8, 2, 10, '', 3),
(6, 'Adenda 3 IPT', '2023-08-18', '2024-08-31', 10, 2, 12, '', 3),
(7, 'Adenda 4 IPT', '2024-09-01', '2025-08-31', 15, 2, 18, '', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `adendaempleado`
--

CREATE TABLE `adendaempleado` (
  `idadendaemp` int(11) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `fechainicio` date NOT NULL,
  `fechafin` date NOT NULL,
  `salariobruto` decimal(7,2) NOT NULL,
  `costohoraextra` decimal(7,2) NOT NULL,
  `comentarios` varchar(500) NOT NULL,
  `activo` int(11) NOT NULL,
  `idcontratoemp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `adendaempleado`
--

INSERT INTO `adendaempleado` (`idadendaemp`, `descripcion`, `fechainicio`, `fechafin`, `salariobruto`, `costohoraextra`, `comentarios`, `activo`, `idcontratoemp`) VALUES
(1, 'Adenda 1', '2024-05-07', '2025-04-30', 2000.00, 0.00, '', 0, 2),
(2, 'Adenda 2', '2025-05-01', '2025-10-31', 2200.00, 0.00, '', 0, 2),
(3, 'Adenda 1', '2024-10-01', '2025-09-30', 3000.00, 0.00, '', 0, 3),
(4, 'Adenda 1', '2025-01-03', '2025-07-03', 2500.00, 0.00, '', 0, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `anuncio`
--

CREATE TABLE `anuncio` (
  `idanuncio` int(11) NOT NULL,
  `fechainicio` date NOT NULL,
  `fechafin` date NOT NULL,
  `rutaarchivo` varchar(500) NOT NULL,
  `comentario` varchar(500) NOT NULL,
  `acargode` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calendario`
--

CREATE TABLE `calendario` (
  `idcalendario` int(11) NOT NULL,
  `asunto` varchar(150) NOT NULL,
  `fecha` date NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `colorfondo` varchar(25) NOT NULL,
  `colortexto` varchar(25) NOT NULL,
  `lider` int(11) NOT NULL,
  `acargode` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `idcliente` int(11) NOT NULL,
  `razonsocial` varchar(50) NOT NULL,
  `nombrecomercial` varchar(50) NOT NULL,
  `ruc` varchar(15) NOT NULL,
  `direccion` varchar(150) NOT NULL,
  `telefono` varchar(15) NOT NULL,
  `sitioweb` varchar(150) NOT NULL,
  `representante` varchar(100) NOT NULL,
  `telrepresentante` varchar(15) NOT NULL,
  `correorepre` varchar(150) NOT NULL,
  `gerente` varchar(150) NOT NULL,
  `telgerente` varchar(15) NOT NULL,
  `correogerente` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`idcliente`, `razonsocial`, `nombrecomercial`, `ruc`, `direccion`, `telefono`, `sitioweb`, `representante`, `telrepresentante`, `correorepre`, `gerente`, `telgerente`, `correogerente`) VALUES
(1, 'CALA SERVICIOS INTEGRALES E.I.R.L.', 'CALA', '20606544937', 'Jirón San Diego N° 282, Departamento N° 203 - Surquillo', '923418300', 'https://www.mifibra.pe/', 'Alfredo Araujo', '995887204', 'alfredo.araujo@mifibra.pe', 'Israel Tokashiki Yakibu', '995736334', 'israeltoka@gmail.com'),
(2, 'DOLPHIN TELECOM DEL PERU S.A.C.', 'DOLPHIN', '20467305931', 'Jirón Preciados N° 149, en el distrito de Santiago de Surco', '951680819', 'https://dolphin.pe/', 'Javier Sánchez', '945119964', 'javier.sanchez@dolphin.pe', 'Fernando Javier Sánchez Benalcazar', '945119964', 'javier.sanchez@dolphin.pe'),
(3, 'INTERNET PARA TODOS S.A.C.', 'IPT', '20602982174', 'Av. Manuel Olguín N° 325, distrito de Santiago de Surco', '953627291', 'https://www.ipt.pe/', 'Sheyla Rojas', '942495272', 'sheyla.reyes@ipt.pe', 'Teresa Gomes De Almeida', '', 'teresa.gomes@ipt.pe'),
(4, 'FIBERMAX TELECOM S.A.C.', 'FIBERMAX', '20432857183', 'n Calle Ernesto Diez Canseco N°\r\n236, Oficina N° 403 - Miraflores', '958155646', 'https://www.fibermax.com.pe/', 'Kattya Vega', '934310215', 'kattya.vega@intermax.pe', 'Pedro Luis Esponda Villavicencio', '996591315', 'pedro.esponda@intermax.pe'),
(5, 'INTERMAX S.A.C.', 'INTERMAX', '20600609239', 'Av. Ricardo Palma 341, Oficina 701, Miraflores, Lima', '(01) 7401000', 'https://intermax.pe/#/', 'Kattya Vega', '934310215', 'kattya.vega@intermax.pe', 'Rafael Ángel Yguey Oshiro', '954848710', 'rafael.yguey@intermax.pe'),
(6, 'PANGEACO S.A.C.', 'PANGEACO', '20606188511', 'Javier Prado Este N° 444, piso 14, oficinas\r\n1401 - 1402, distrito de San Isidro', '', 'https://pe.linkedin.com/company/pangea-peru', 'Julio Cieza', '952934110', 'julio.cieza@pangeaco.pe', 'Luz Giovanna Piskulich Nevado', '', 'giovanna.piskulich@pangeaco.pe'),
(7, 'PRISONTEC S.A.C.', 'PRISONTEC', '20563709601', 'n Av. Del Pinar N° 180, Oficina 1004 – Santiago de Surco, Lima', '(01) 2566868', 'https://www.prisontec.com/portalweb/', 'Raiza Hernandez', '959717996', 'raiza.hernandez@prisontec.com', 'Augusto Eduardo Fernández Márquez', '', ''),
(8, 'URBI PROYECTOS SOCIEDAD ANONIMA CERRADA', 'PUNTO DE ACCESO', '20600796438', 'Calle Carlos Villarán Nro. 140, Urb. Santa Catalina, La Victoria, Lima', '(01) 219 2000', 'https://urbiproyectos.pe/', 'Kazhia Fernandez', '939301984', 'kafernandez@intercorp.com.pe', 'Úrsula Consuelo Sánchez Gamarra', '', 'usanchezg@intercorp.com.pe');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contratocliente`
--

CREATE TABLE `contratocliente` (
  `idcontratocli` int(11) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `fechainicio` date NOT NULL,
  `fechafin` date NOT NULL,
  `horasfijasmes` int(11) NOT NULL,
  `costohorafija` decimal(7,2) NOT NULL,
  `mesescontrato` int(11) NOT NULL,
  `totalhorasfijas` int(11) NOT NULL,
  `tipobolsa` varchar(50) NOT NULL,
  `costohoraextra` decimal(7,2) NOT NULL,
  `montofijomes` decimal(7,2) NOT NULL,
  `planmontomes` decimal(7,2) NOT NULL,
  `planhoraextrames` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `tipohora` varchar(500) NOT NULL,
  `activo` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `lider` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contratocliente`
--

INSERT INTO `contratocliente` (`idcontratocli`, `descripcion`, `fechainicio`, `fechafin`, `horasfijasmes`, `costohorafija`, `mesescontrato`, `totalhorasfijas`, `tipobolsa`, `costohoraextra`, `montofijomes`, `planmontomes`, `planhoraextrames`, `status`, `tipohora`, `activo`, `idcliente`, `lider`) VALUES
(1, 'Contrato Principal CALA', '2022-09-01', '2023-08-31', 8, 425.00, 12, 96, 'Mensual', 440.00, 3400.00, 4280.00, 2, 'Vigente', 'Soporte', 0, 1, 4),
(2, 'Contrato Principal DOLPHIN', '2023-09-01', '2024-08-31', 10, 500.00, 12, 120, 'Anual', 550.00, 10.00, 5000.00, 0, 'Vigente', 'Soporte', 0, 2, 6),
(3, 'Contrato Principal IPT', '2020-08-14', '2021-08-17', 3, 350.00, 12, 36, 'Mensual', 420.00, 3.00, 1890.00, 2, 'Vigente', 'Soporte', 0, 3, 6),
(4, 'Contrato Principal Fibermax', '2022-01-01', '2023-12-31', 8, 430.00, 24, 192, 'Mensual', 460.00, 3440.00, 4360.00, 2, 'Vigente', 'Soporte', 1, 4, 6),
(5, 'Contrato Principal Intermax', '2022-02-01', '2024-01-31', 20, 306.00, 24, 480, 'Mensual', 460.00, 6120.00, 7040.00, 2, 'Vigente', 'Soporte', 1, 5, 3),
(6, 'Contrato Principal PangeaCo', '2022-07-01', '2022-12-30', 8, 435.00, 6, 48, 'Mensual', 460.00, 3480.00, 4400.00, 2, 'Vigente', 'Soporte', 1, 6, 4),
(8, 'Contrato Principal Prisontec', '2021-02-01', '2022-01-31', 10, 435.00, 12, 120, 'Mensual', 460.00, 4350.00, 5270.00, 2, 'Vigente', 'Soporte', 1, 7, 4),
(9, 'Contrato Principal Punto de Acceso', '2024-08-29', '2024-12-02', 3, 500.00, 3, 9, 'Mensual', 530.00, 1500.00, 3090.00, 3, 'Vigente', 'Soporte', 1, 8, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contratoempleado`
--

CREATE TABLE `contratoempleado` (
  `idcontratoemp` int(11) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `fechainicio` date NOT NULL,
  `fechafin` date NOT NULL,
  `modalidad` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `salariobruto` decimal(7,2) NOT NULL,
  `entidadbancaria` varchar(50) NOT NULL,
  `tipocuenta` varchar(50) NOT NULL,
  `numcuenta1` varchar(50) NOT NULL,
  `numcuenta2` varchar(50) NOT NULL,
  `comentario` varchar(500) NOT NULL,
  `direccion` varchar(50) NOT NULL,
  `area` varchar(50) NOT NULL,
  `puesto` varchar(50) NOT NULL,
  `activo` int(11) NOT NULL,
  `idemp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `contratoempleado`
--

INSERT INTO `contratoempleado` (`idcontratoemp`, `descripcion`, `fechainicio`, `fechafin`, `modalidad`, `status`, `salariobruto`, `entidadbancaria`, `tipocuenta`, `numcuenta1`, `numcuenta2`, `comentario`, `direccion`, `area`, `puesto`, `activo`, `idemp`) VALUES
(1, 'Contrato', '2023-02-01', '0000-00-00', 'Planilla', 'Vencido', 2500.00, 'BCP', 'Sueldo', '19199750519098', '', '', 'Operaciones', 'Legal Regulatorio', 'Asociado Ejecutivo', 0, 1),
(2, 'Contrato', '2023-11-07', '0000-00-00', 'Planilla', 'Vencido', 1800.00, 'BCP', 'Sueldo', '19300202613059', '', '', 'Administrativo', 'Recursos Humanos', 'Asistente', 0, 2),
(3, 'Contrato', '2024-04-03', '0000-00-00', 'Planilla', 'Vencido', 2500.00, 'BCP', 'Sueldo', '19199848053016', '', '', 'Operaciones', 'Técnico Regulatorio', 'Asociado Ejecutivo', 0, 3),
(4, 'Contrato', '2024-07-04', '0000-00-00', 'Planilla', 'Vencido', 2500.00, 'BCP', 'Sueldo', '19195006197053', '', '', 'Operaciones', 'Legal Regulatorio', 'Asociado Ejecutivo', 0, 4),
(5, 'Contrato', '2025-02-11', '0000-00-00', 'Planilla', 'Vigente', 2500.00, 'IBK', 'Sueldo', '00389801345860304042', '', '', 'Operaciones', 'Legal Regulatorio', 'Asociado Ejecutivo', 0, 5),
(6, 'Contrato', '2025-02-17', '0000-00-00', 'Planilla', 'Vigente', 3000.00, 'BCP', 'Sueldo', '19105393963046', '', '', 'Operaciones', 'Legal Regulatorio', 'Asociado Ejecutivo', 0, 6),
(7, 'Contrato', '2025-02-26', '0000-00-00', 'Planilla', 'Vigente', 2800.00, 'SCTBK', 'Sueldo', '00914220952002488718', '', '', 'Operaciones', 'Técnico Regulatorio', 'Asociado Ejecutivo', 0, 7),
(8, 'Contrato', '2015-04-08', '0000-00-00', 'Recibo por Honorarios', '', 8913.04, 'BCP', 'Ahorros', '19199020334038', '', 'Sueldo neto original 8.2k', 'Socios', 'Legal Regulatorio', 'Socio Fundador', 0, 8),
(9, 'Contrato', '2015-04-08', '0000-00-00', 'Recibo por Honorarios', '', 8913.04, 'IBK', 'Ahorros', '00336801309344242488', '', 'Sueldo neto original 8.2k', 'Socios', 'Técnico Regulatorio', 'Socio Fundador', 0, 9),
(10, 'Contrato', '0000-00-00', '0000-00-00', '', '', 500.00, 'BCP', 'Ahorros', '19431468626089', '', '', 'Administrativo', 'Contabilidad', 'Locador de Servicios', 0, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuotahito`
--

CREATE TABLE `cuotahito` (
  `idcouta` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `hito` varchar(500) NOT NULL,
  `avance` varchar(500) NOT NULL,
  `cuota` decimal(7,2) NOT NULL,
  `idpresupuesto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle`
--

CREATE TABLE `detalle` (
  `idetalle` int(11) NOT NULL,
  `idfacturacion` int(11) NOT NULL,
  `tiposervicio` varchar(50) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(7,2) NOT NULL,
  `importe` decimal(7,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `distribucionhora`
--

CREATE TABLE `distribucionhora` (
  `id` int(11) NOT NULL,
  `participante` int(11) NOT NULL,
  `porcentaje` int(11) NOT NULL,
  `comentario` varchar(500) NOT NULL,
  `idliquidacion` int(11) NOT NULL,
  `fecha` datetime NOT NULL,
  `horas` int(11) NOT NULL,
  `calculo` decimal(10,2) DEFAULT NULL,
  `registrado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `distribucionhora`
--

INSERT INTO `distribucionhora` (`id`, `participante`, `porcentaje`, `comentario`, `idliquidacion`, `fecha`, `horas`, `calculo`, `registrado`, `modificado`) VALUES
(1, 7, 30, 'prueba000', 1, '2025-06-02 00:00:00', 4, 1.20, '2025-06-17 21:23:23', '2025-06-17 21:23:23'),
(2, 4, 30, 'prueba000', 1, '2025-06-02 00:00:00', 4, 1.20, '2025-06-17 21:23:23', '2025-06-17 21:23:23'),
(3, 3, 40, 'prueba000', 1, '2025-06-02 00:00:00', 4, 1.60, '2025-06-17 21:23:23', '2025-06-17 21:23:23'),
(4, 4, 100, '', 4, '2025-05-02 23:55:00', 2, 2.00, '2025-06-18 04:56:07', '2025-06-18 04:56:07'),
(5, 4, 100, '', 5, '2025-05-13 23:56:00', 2, 2.00, '2025-06-18 04:57:14', '2025-06-18 04:57:14'),
(6, 4, 90, '', 6, '2025-05-30 23:58:00', 1, 0.90, '2025-06-18 04:59:56', '2025-06-18 04:59:56'),
(7, 8, 10, '', 6, '2025-05-30 23:58:00', 1, 0.10, '2025-06-18 04:59:56', '2025-06-18 04:59:56'),
(8, 3, 10, '', 7, '2025-05-16 00:00:00', 1, 0.10, '2025-06-18 05:01:13', '2025-06-18 05:01:13'),
(9, 6, 10, '', 7, '2025-05-16 00:00:00', 1, 0.10, '2025-06-18 05:01:13', '2025-06-18 05:01:13'),
(10, 8, 80, '', 7, '2025-05-16 00:00:00', 1, 0.80, '2025-06-18 05:01:13', '2025-06-18 05:01:13'),
(11, 3, 50, '', 8, '2025-05-23 00:01:00', 5, 2.50, '2025-06-18 05:03:00', '2025-06-18 05:03:00'),
(12, 8, 50, '', 8, '2025-05-23 00:01:00', 5, 2.50, '2025-06-18 05:03:00', '2025-06-18 05:03:00'),
(13, 3, 80, '', 9, '2025-05-27 00:03:00', 2, 1.60, '2025-06-18 05:04:20', '2025-06-18 05:04:20'),
(14, 8, 20, '', 9, '2025-05-27 00:03:00', 2, 0.40, '2025-06-18 05:04:20', '2025-06-18 05:04:20'),
(15, 8, 100, '', 10, '2025-05-29 00:05:00', 1, 1.00, '2025-06-18 05:06:32', '2025-06-18 05:06:32'),
(16, 3, 10, '', 11, '2025-05-29 00:06:00', 1, 0.10, '2025-06-18 05:07:41', '2025-06-18 05:07:41'),
(17, 8, 90, '', 11, '2025-05-29 00:06:00', 1, 0.90, '2025-06-18 05:07:41', '2025-06-18 05:07:41'),
(18, 3, 20, '', 12, '2025-05-06 00:08:00', 1, 0.20, '2025-06-18 05:09:08', '2025-06-18 05:09:08'),
(19, 6, 20, '', 12, '2025-05-06 00:08:00', 1, 0.20, '2025-06-18 05:09:08', '2025-06-18 05:09:08'),
(20, 8, 60, '', 12, '2025-05-06 00:08:00', 1, 0.60, '2025-06-18 05:09:08', '2025-06-18 05:09:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `idempleado` int(11) NOT NULL,
  `nombres` varchar(100) NOT NULL,
  `paterno` varchar(50) NOT NULL,
  `materno` varchar(50) NOT NULL,
  `nombrecorto` varchar(50) DEFAULT NULL,
  `dni` varchar(10) NOT NULL,
  `nacimiento` date NOT NULL,
  `lugarnacimiento` varchar(100) NOT NULL,
  `domicilio` varchar(150) NOT NULL,
  `estadocivil` varchar(50) NOT NULL,
  `correopersonal` varchar(100) NOT NULL,
  `correocorporativo` varchar(100) NOT NULL,
  `telcelular` varchar(15) NOT NULL,
  `telfijo` varchar(10) NOT NULL,
  `derechohabiente` varchar(50) NOT NULL,
  `cantidadhijos` int(11) NOT NULL,
  `contactoemergencia` varchar(100) NOT NULL,
  `nivelestudios` varchar(50) NOT NULL,
  `regimenpension` varchar(50) NOT NULL,
  `fondopension` varchar(50) NOT NULL,
  `cussp` varchar(50) NOT NULL,
  `modalidad` varchar(50) NOT NULL,
  `rutafoto` varchar(250) NOT NULL,
  `activo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idempleado`, `nombres`, `paterno`, `materno`, `nombrecorto`, `dni`, `nacimiento`, `lugarnacimiento`, `domicilio`, `estadocivil`, `correopersonal`, `correocorporativo`, `telcelular`, `telfijo`, `derechohabiente`, `cantidadhijos`, `contactoemergencia`, `nivelestudios`, `regimenpension`, `fondopension`, `cussp`, `modalidad`, `rutafoto`, `activo`) VALUES
(1, 'Kelly Yajaira', 'Renquifo', 'Cieza', 'Kelly', '47962973', '1993-09-05', 'Hualgayoc, Cajamarca', 'Jr. Trinidad 295, Dpto 301, Urb. Villa Jardin, San Luis, Lima', 'Soltera', 'k.renquifo@gmail.com', 'kelly.renquifo@ampara.pe', '951600532', 'No Aplica', 'No Aplica', 0, 'Flor Cieza Infante - Madre - 971792154', 'Bachiller en Derecho', 'AFP', 'PRIMA', '342150KRCQZ1', 'Planilla', '', 0),
(2, 'Maria Lucia Margot\r\n', 'Gonzalez', 'Soto', 'Malú', '70774300', '1999-05-24', 'Miraflores, Lima', 'Curazao 385, La Molina', 'Soltera', 'malumags@gmail.com', 'marialucia.gonzalez@ampara.pe', '980362757', 'No Aplica', 'No Aplica', 0, 'Victor Humberto Gonzalez Acuña | Padre | 999106985', 'Bachiller en Psicología', 'AFP', 'INTEGRA', '663020MGSZO8', 'Planilla', '', 1),
(3, 'Jacy Sarahi', 'Rojas', 'Pasapera', 'Jacy', '72667251', '2000-04-30', 'Piura, Piura', 'Av. Benjamin Franklin 576, Ate', 'Soltera', 'jacyrp72667251@gmail.com', 'jacy.rojas@ampara.pe', '963587885', 'No Aplica', 'No Aplica', 0, 'JACINTA PASAPERA PINTADO | MAMÁ | 928153463', 'Bachiller en Ingeniería Electrónica y de Telecomun', 'AFP', 'INTEGRA', '666440JRPAA4', 'Planilla', '', 1),
(4, 'Gustavo Vittorio', 'Ramirez', 'Sanchez', 'Gustavo', '75310964', '1998-07-25', 'Miraflores, Lima', 'Sector 03 - Grupo 15 Mz. B Lote 3, Villa El Salvador								', 'Soltero', 'asdafe25@gmail.com', 'gustavo.ramirez@ampara.pe', '944340916', 'No Aplica', 'No Aplica', 0, 'Victorio Ramirez Sánchez | Padre | 949231482', 'Bachiller en Derecho', 'AFP', 'INTEGRA', '659991GRSIC6', 'Planilla', '', 1),
(5, 'Katy Andrea', 'Nieto', 'Casafranca', 'Katy', '72369959', '1997-12-09', 'Santiago, Cusco', 'Calle Chacabuco Nº 185, Torre Nº 8 y departamento Nº 1207, San Miguel', 'Soltera', 'katy.nieto@pucp.edu.pe', 'katy.nieto@ampara.pe', '982049282', 'No Aplica', 'No Aplica', 0, '', 'Bachiller en Derecho', 'AFP', 'INTEGRA', '657710KNCTA9', 'Planilla', '', 1),
(6, 'Janira Samajuto', 'Torres', 'Cuadros', 'Janira', '48137494', '1994-02-23', 'Huamanga, Ayacucho', 'Duque de la Palata 157, Surco', 'Soltera', 'janira_torres_@outlook.com', 'janira.torres@ampara.pe', '994341934', 'No Aplica', 'No Aplica', 0, 'TORRES CUADROS TONY | HERMANO | 920 877 844	', 'Titulada en Derecho', 'AFP', 'INTEGRA', '643860JTCRD0', 'Planilla', '', 1),
(7, 'David Gustavo', 'Roque', 'Mamani', 'David', '72682491', '1994-11-01', 'Yanahuara, Arequipa', 'Rafael Aedo Guerrero Mz Z1 Lote 6, Surco', 'Soltera', 'davidgroquem@gmail.com', 'david.roque@ampara.pe', '974438885', 'No Aplica', 'No Aplica', 0, 'Flores Turpo Fancy Noemi | Conviviente | 955713507', 'Bachiller en Ingeniería de Telecomunicaciones', 'AFP', 'PRIMA', '646371DRMUA9', 'Planilla', '', 0),
(8, 'Juan Carlos', 'Cornejo', 'Cuzzi', 'Socios', '10286953', '1977-03-07', 'Lima', 'Miraflores, Lima', 'Casado', 'jccornejocuzzi@gmail.com', 'juancarlos.cornejo@ampara.pe', '996291396', 'No Aplica', 'No Aplica', 0, '', 'Abogado Colegiado', 'AFP', 'PRIMA', '581891JCCNZ0', 'Recibo por Honorarios', '', 1),
(9, 'Gino Christian', 'Kou', 'Reyna', 'Socios', '10288581', '1977-05-17', 'Lima', 'Surco, Lima', 'Casado', '', 'gino.kou@ampara.pe', '995731361', 'No Aplica', 'No Aplica', 0, '', 'Ingeniero Colegiado', 'AFP', 'HABITAT', '582601GKRUN1', 'Recibo por Honorarios', '', 0),
(10, 'Maria Laura', 'Yataco', 'Cornejo', 'Maria Laura', '07628964', '0000-00-00', '', 'Calle 28 de Julio 535 Dpto 302, Magdalena del Mar', '', 'marialaura.yataco@gmail.com', '', '975590975', '', '', 0, '', '', 'AFP', 'PRIMA', '566820MYCAN2', 'Recibo por Honorarios', '', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento`
--

CREATE TABLE `evento` (
  `idevento` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `colorfondo` varchar(25) NOT NULL,
  `colortexto` varchar(25) NOT NULL,
  `url` varchar(150) NOT NULL,
  `fechainicio` date NOT NULL,
  `fechafin` date NOT NULL,
  `lider` int(11) NOT NULL,
  `acargode` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturacion`
--

CREATE TABLE `facturacion` (
  `idfacturacion` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `horasgen` varchar(50) NOT NULL,
  `tipocliente` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `moneda` varchar(50) NOT NULL,
  `cambiosunat` decimal(5,2) NOT NULL,
  `tiposervicio` varchar(50) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `subtotal` decimal(7,2) NOT NULL,
  `igv` decimal(7,2) NOT NULL,
  `total` decimal(7,2) NOT NULL,
  `detraccion` decimal(7,2) NOT NULL,
  `netosindetrac` decimal(7,2) NOT NULL,
  `fechaemision` date NOT NULL,
  `fechaenvio` date NOT NULL,
  `fechapago` date NOT NULL,
  `fechapagodetrac` date NOT NULL,
  `comentarios` varchar(500) NOT NULL,
  `mesemision` date NOT NULL,
  `mescobrado` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `liquidacion`
--

CREATE TABLE `liquidacion` (
  `idliquidacion` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `asunto` varchar(1500) NOT NULL,
  `tema` int(11) NOT NULL,
  `motivo` varchar(500) NOT NULL,
  `tipohora` varchar(45) NOT NULL,
  `acargode` int(11) NOT NULL,
  `lider` int(11) NOT NULL,
  `cantidahoras` int(11) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `idcontratocli` int(11) NOT NULL,
  `idpresupuesto` int(11) NOT NULL,
  `activo` int(11) NOT NULL,
  `editor` int(11) NOT NULL DEFAULT 1,
  `registrado` timestamp NOT NULL DEFAULT current_timestamp(),
  `modificado` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `liquidacion`
--

INSERT INTO `liquidacion` (`idliquidacion`, `fecha`, `asunto`, `tema`, `motivo`, `tipohora`, `acargode`, `lider`, `cantidahoras`, `estado`, `idcontratocli`, `idpresupuesto`, `activo`, `editor`, `registrado`, `modificado`) VALUES
(1, '2025-06-02', 'Análisis y revisión', 1, 'The open standard Link Aggregation Control Protocol (LACP) is extremely flexible and offers robust options for maintaining an EtherChannel bundle. By default, LACP allows up to 8 active members and as many as 8\r\nstandby members in a single bundle', 'Soporte', 5, 4, 4, 'Completo', 8, 0, 0, 1, '2025-06-17 14:13:45', '2025-06-17 21:23:23'),
(2, '2025-06-03', 'Reunión', 2, 'The open standard Link Aggregation Control Protocol (LACP) is extremely flexible and offers robust options for maintaining an EtherChannel bundle. By default, LACP allows up to 8 active members and as many as 8\r\nstandby members in a single bundle', 'Soporte', 5, 6, 3, 'En revisión', 2, 0, 0, 1, '2025-06-17 14:38:47', '2025-06-17 14:38:47'),
(3, '2025-06-26', 'Análisis y revisión', 8, 'Prueba', 'Soporte', 4, 4, 3, 'Programado', 1, 0, 0, 1, '2025-06-17 17:30:46', '2025-06-17 17:30:46'),
(4, '2025-05-02', 'Análisis y revisión', 12, 'Elaboración de ficha de registro de nueva tarifa establecida por servicio de internet 1000 Mbps para clientes de MiFibra, indicando sus respectivas condiciones y restricciones. Asimismo, se realizó adecuaciones a la tarifa promocional por el servicio de internet 500 Mbps. Se brindaron recomendaciones y sugerencias ante los dos casos planteados para evaluación del cliente.', 'Soporte', 4, 4, 2, 'Completo', 1, 0, 1, 1, '2025-06-18 04:56:07', '2025-06-18 04:56:07'),
(5, '2025-05-13', 'Análisis y revisión', 6, 'Búsqueda, revisión y análisis de jurisprudencia de OSIPTEL vinculada a casuística de uso indebido, en base a la cual, se enviaron recomendaciones a CALA respecto de la implementación de sus protocolos para la detección y acreditación de casos de uso indebido de los servicios públicos de telecomunicaciones.', 'Soporte', 4, 4, 2, 'Completo', 1, 0, 1, 1, '2025-06-18 04:57:14', '2025-06-18 04:57:14'),
(6, '2025-05-30', 'Horas audio', 1, 'Seguimiento y consulta con OSIPTEL de solicitud de acceso a la información pública sobre detalles financieros de WIN y WOW (15.05.2025) // Llamada de Jorge Araujo con Juan Carlos para absolver consultas sobre plazo forzoso y resolución de contratos (20.05.2025) // Envío a cliente de información remitida por OSIPTEL en respuesta a solicitud de acceso a la información pública (20.05.2025).', 'Soporte', 5, 4, 1, 'Completo', 1, 0, 1, 1, '2025-06-18 04:59:56', '2025-06-18 04:59:56'),
(7, '2025-05-16', 'Reunión', 14, 'Reunión de revisión de pendientes.', 'Soporte', 6, 6, 1, 'Completo', 2, 0, 1, 1, '2025-06-18 05:01:13', '2025-06-18 05:01:13'),
(8, '2025-05-23', 'Análisis y revisión', 14, '- Revisión y análisis de la Carta N° 000184-2025-DPRC/OSIPTEL de OSIPTEL donde nos traslada los comentarios de Telefónica.\r\n- Elaboración de propuesta de respuesta a la carta del OSIPTEL donde se fundamentó legal y jurisprudencialmente la correcta aplicación del artículo 7 de las “NORMAS COMPLEMENTARIAS APLICABLES A LOS OPERADORES MÓVILES VIRTUALES” (RCD Nº 009-2016-CD/OSIPTEL); asimismo, se elaboraron diagramas de topología de red para darle mayor peso a la carta.', 'Soporte', 6, 6, 5, 'Completo', 2, 0, 1, 1, '2025-06-18 05:03:00', '2025-06-18 05:03:00'),
(9, '2025-05-27', 'Análisis y revisión', 23, 'Elaboración de carta para dar respuesta a la solicitud de información respecto a los compromisos establecidos a DOLPHIN en el proceso de\r\nreordenamiento de la banda de frecuencias 2 300 – 2 400 MHz realizada por el MTC.', 'Soporte', 3, 6, 2, 'Completo', 2, 0, 1, 1, '2025-06-18 05:04:20', '2025-06-18 05:04:20'),
(10, '2025-05-29', 'Horas audio', 1, 'Reuniones de coordinación (varias) entre Gino y Juan Carlos con Javier y César.', 'Soporte', 5, 6, 1, 'Completo', 2, 0, 1, 1, '2025-06-18 05:06:32', '2025-06-18 05:06:32'),
(11, '2025-05-29', 'Reunión', 1, 'Reunión respecto a la elaboración de medios probatorios que complementen la carta de respuesta al requerimiento de información del MTC (reordenamiento de bandas).', 'Soporte', 5, 6, 1, 'Completo', 2, 0, 1, 1, '2025-06-18 05:07:41', '2025-06-18 05:07:41'),
(12, '2025-05-06', 'Reunión', 15, 'Reunión para revisar lo precisado por el OSIPTEL en el mandato complementario de acceso entre INTERMAX y BITEL, y las actividades a seguir  para la implementación total del servicio.', 'Soporte', 6, 3, 1, 'Completo', 5, 0, 1, 1, '2025-06-18 05:09:08', '2025-06-18 05:09:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `presupuestocliente`
--

CREATE TABLE `presupuestocliente` (
  `idpresupuesto` int(11) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `fechainicio` date NOT NULL,
  `fechafin` date NOT NULL,
  `monto` decimal(7,2) NOT NULL,
  `activo` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `acargode` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tema`
--

CREATE TABLE `tema` (
  `idtema` int(11) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `encargado` varchar(500) NOT NULL,
  `idencargado` int(11) DEFAULT NULL,
  `comentario` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tema`
--

INSERT INTO `tema` (`idtema`, `descripcion`, `encargado`, `idencargado`, `comentario`) VALUES
(1, 'Asesoría Legal', 'Katy Nieto', 5, ''),
(2, 'Contratación Pública (Licitaciones)', 'Katy Nieto', 5, ''),
(3, 'Protección de Datos Personales', 'Katy Nieto', 5, ''),
(4, 'Publicidad', 'Katy Nieto', 5, ''),
(5, 'Secreto Telecomunicaciones', 'Katy Nieto', 5, ''),
(6, 'Condiciones de Uso | Reclamos', 'Gustavo Ramirez', 4, ''),
(7, 'Compartición de Infraestructura | SEIA', 'Gustavo Ramirez', 4, ''),
(8, 'Página Web | Indicadores de Calidad de Usuario', 'Gustavo Ramirez', 4, ''),
(9, 'Contratación B2C', 'Gustavo Ramirez', 4, ''),
(10, 'Portabilidad', 'Gustavo Ramirez', 4, ''),
(11, 'CIPS | Marco Normativo de Establecimientos Penitenciarios', 'Gustavo Ramirez', 4, ''),
(12, 'Tarifas', 'Gustavo Ramirez', 4, ''),
(13, 'Uso Indebido | Uso Prohibido', 'Gustavo Ramirez', 4, ''),
(14, 'Interconexión', 'Janira Torres', 6, ''),
(15, 'OMV', 'Janira Torres', 6, ''),
(16, 'OIMR', 'Janira Torres', 6, ''),
(17, 'Contratación B2B y Mayorista', 'Janira Torres', 6, ''),
(18, 'Aporte al OSIPTEL, FITEL y TEC', 'Janira Torres', 6, ''),
(19, 'Procedimientos Administrativos', 'Janira Torres', 6, ''),
(20, 'Clasificación de Servicios | Mapa de Obligaciones\r\n', 'Jacy Rojas', 3, ''),
(21, 'Interrupciones y Devoluciones | Indicadores de Calidad', 'Jacy Rojas', 3, ''),
(22, 'RENTESEG', 'Jacy Rojas', 3, ''),
(23, 'Títulos Habilitantes', 'Jacy Rojas', 3, ''),
(24, 'Espectro | RNI | Canon', 'Jacy Rojas', 3, ''),
(25, 'Requerimientos de Información Periódica (OSIPTEL y MTC)', 'Jacy Rojas', 3, ''),
(26, 'Planes Técnicos (Numeración, Señalización, etc.) | PNAF', 'Jacy Rojas', 3, ''),
(27, 'SISMATE | RECSE', 'Jacy Rojas', 3, ''),
(28, 'Ley de Banda Ancha | Neutralidad de Red', 'Jacy Rojas', 3, ''),
(29, 'Homologación e Internamiento de Equipos', 'Jacy Rojas', 3, ''),
(30, 'Proveedor de Capacidad Satelital', 'Jacy Rojas', 3, ''),
(31, 'Revisión Normativa y Regulatoria', 'Katy Nieto', 5, ''),
(32, 'Fiscalización', 'Socios', 8, '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `password` varchar(250) NOT NULL,
  `tipo` int(11) NOT NULL,
  `activo` int(11) NOT NULL,
  `idemp` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nombre`, `password`, `tipo`, `activo`, `idemp`) VALUES
(1, 'jcornejo', '10286953', 1, 1, 8),
(2, 'gkou', '10288581', 1, 1, 9),
(3, 'mgonzalez', '70774300', 1, 1, 2),
(4, 'jrojas', '72667251', 2, 1, 3),
(5, 'gramirez', '75310964', 2, 1, 4),
(6, 'jtorres', '48137494', 2, 1, 6),
(7, 'knieto', '72369959', 2, 1, 5);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `adendacliente`
--
ALTER TABLE `adendacliente`
  ADD PRIMARY KEY (`idadendacli`),
  ADD KEY `idcontratocli` (`idcontratocli`);

--
-- Indices de la tabla `adendaempleado`
--
ALTER TABLE `adendaempleado`
  ADD PRIMARY KEY (`idadendaemp`),
  ADD KEY `idcontratoemp` (`idcontratoemp`);

--
-- Indices de la tabla `anuncio`
--
ALTER TABLE `anuncio`
  ADD PRIMARY KEY (`idanuncio`),
  ADD KEY `acargode` (`acargode`);

--
-- Indices de la tabla `calendario`
--
ALTER TABLE `calendario`
  ADD PRIMARY KEY (`idcalendario`),
  ADD KEY `acargode` (`acargode`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`idcliente`);

--
-- Indices de la tabla `contratocliente`
--
ALTER TABLE `contratocliente`
  ADD PRIMARY KEY (`idcontratocli`),
  ADD KEY `idcliente` (`idcliente`),
  ADD KEY `lider` (`lider`);

--
-- Indices de la tabla `contratoempleado`
--
ALTER TABLE `contratoempleado`
  ADD PRIMARY KEY (`idcontratoemp`),
  ADD KEY `idemp` (`idemp`);

--
-- Indices de la tabla `cuotahito`
--
ALTER TABLE `cuotahito`
  ADD PRIMARY KEY (`idcouta`),
  ADD KEY `idpresupuesto` (`idpresupuesto`);

--
-- Indices de la tabla `detalle`
--
ALTER TABLE `detalle`
  ADD KEY `idfacturacion` (`idfacturacion`);

--
-- Indices de la tabla `distribucionhora`
--
ALTER TABLE `distribucionhora`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idliquidacion` (`idliquidacion`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`idempleado`);

--
-- Indices de la tabla `evento`
--
ALTER TABLE `evento`
  ADD PRIMARY KEY (`idevento`),
  ADD KEY `acargode` (`acargode`);

--
-- Indices de la tabla `facturacion`
--
ALTER TABLE `facturacion`
  ADD PRIMARY KEY (`idfacturacion`),
  ADD KEY `idcliente` (`idcliente`);

--
-- Indices de la tabla `liquidacion`
--
ALTER TABLE `liquidacion`
  ADD PRIMARY KEY (`idliquidacion`),
  ADD KEY `idcontratocli` (`idcontratocli`),
  ADD KEY `tema` (`tema`),
  ADD KEY `acargode` (`acargode`);

--
-- Indices de la tabla `presupuestocliente`
--
ALTER TABLE `presupuestocliente`
  ADD PRIMARY KEY (`idpresupuesto`),
  ADD KEY `idcliente` (`idcliente`),
  ADD KEY `acargode` (`acargode`);

--
-- Indices de la tabla `tema`
--
ALTER TABLE `tema`
  ADD PRIMARY KEY (`idtema`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD KEY `idemp` (`idemp`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `adendacliente`
--
ALTER TABLE `adendacliente`
  MODIFY `idadendacli` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `adendaempleado`
--
ALTER TABLE `adendaempleado`
  MODIFY `idadendaemp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `anuncio`
--
ALTER TABLE `anuncio`
  MODIFY `idanuncio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `calendario`
--
ALTER TABLE `calendario`
  MODIFY `idcalendario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `idcliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `contratocliente`
--
ALTER TABLE `contratocliente`
  MODIFY `idcontratocli` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `contratoempleado`
--
ALTER TABLE `contratoempleado`
  MODIFY `idcontratoemp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `cuotahito`
--
ALTER TABLE `cuotahito`
  MODIFY `idcouta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `distribucionhora`
--
ALTER TABLE `distribucionhora`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `idempleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `evento`
--
ALTER TABLE `evento`
  MODIFY `idevento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `facturacion`
--
ALTER TABLE `facturacion`
  MODIFY `idfacturacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `liquidacion`
--
ALTER TABLE `liquidacion`
  MODIFY `idliquidacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `presupuestocliente`
--
ALTER TABLE `presupuestocliente`
  MODIFY `idpresupuesto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tema`
--
ALTER TABLE `tema`
  MODIFY `idtema` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `adendacliente`
--
ALTER TABLE `adendacliente`
  ADD CONSTRAINT `adendacliente_ibfk_1` FOREIGN KEY (`idcontratocli`) REFERENCES `contratocliente` (`idcontratocli`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `adendaempleado`
--
ALTER TABLE `adendaempleado`
  ADD CONSTRAINT `adendaempleado_ibfk_1` FOREIGN KEY (`idadendaemp`) REFERENCES `contratoempleado` (`idcontratoemp`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `anuncio`
--
ALTER TABLE `anuncio`
  ADD CONSTRAINT `anuncio_ibfk_1` FOREIGN KEY (`acargode`) REFERENCES `empleado` (`idempleado`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `calendario`
--
ALTER TABLE `calendario`
  ADD CONSTRAINT `calendario_ibfk_1` FOREIGN KEY (`acargode`) REFERENCES `empleado` (`idempleado`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `contratocliente`
--
ALTER TABLE `contratocliente`
  ADD CONSTRAINT `contratocliente_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `contratocliente_ibfk_2` FOREIGN KEY (`lider`) REFERENCES `empleado` (`idempleado`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `contratoempleado`
--
ALTER TABLE `contratoempleado`
  ADD CONSTRAINT `contratoempleado_ibfk_1` FOREIGN KEY (`idemp`) REFERENCES `empleado` (`idempleado`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `cuotahito`
--
ALTER TABLE `cuotahito`
  ADD CONSTRAINT `cuotahito_ibfk_1` FOREIGN KEY (`idpresupuesto`) REFERENCES `presupuestocliente` (`idpresupuesto`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle`
--
ALTER TABLE `detalle`
  ADD CONSTRAINT `detalle_ibfk_1` FOREIGN KEY (`idfacturacion`) REFERENCES `facturacion` (`idfacturacion`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `distribucionhora`
--
ALTER TABLE `distribucionhora`
  ADD CONSTRAINT `distribucionhora_ibfk_1` FOREIGN KEY (`idliquidacion`) REFERENCES `liquidacion` (`idliquidacion`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `evento`
--
ALTER TABLE `evento`
  ADD CONSTRAINT `evento_ibfk_1` FOREIGN KEY (`acargode`) REFERENCES `empleado` (`idempleado`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `facturacion`
--
ALTER TABLE `facturacion`
  ADD CONSTRAINT `facturacion_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `liquidacion`
--
ALTER TABLE `liquidacion`
  ADD CONSTRAINT `liquidacion_ibfk_1` FOREIGN KEY (`idcontratocli`) REFERENCES `contratocliente` (`idcontratocli`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `liquidacion_ibfk_2` FOREIGN KEY (`tema`) REFERENCES `tema` (`idtema`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `liquidacion_ibfk_3` FOREIGN KEY (`acargode`) REFERENCES `empleado` (`idempleado`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `presupuestocliente`
--
ALTER TABLE `presupuestocliente`
  ADD CONSTRAINT `presupuestocliente_ibfk_1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `presupuestocliente_ibfk_2` FOREIGN KEY (`acargode`) REFERENCES `empleado` (`idempleado`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`idemp`) REFERENCES `empleado` (`idempleado`) ON DELETE NO ACTION ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
