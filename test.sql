-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Set 07, 2019 alle 16:44
-- Versione del server: 10.4.7-MariaDB
-- Versione PHP: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `test`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `hash`
--

CREATE TABLE `hash` (
  `id` int(11) NOT NULL,
  `hash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `hash`
--

INSERT INTO `hash` (`id`, `hash`) VALUES
(1, '00003c3cfe3e7e5c'),
(2, '4000fbfbfb020300'),
(3, 'f0e0fcf6f6e0c0c0'),
(4, '40007a7b7a020618'),
(5, '4000fbfbf9020300'),
(6, '40407a7f7a060618'),
(7, '000076ff770e0000'),
(8, '001818007e3cffff'),
(9, '40007eff770e0000');

-- --------------------------------------------------------

--
-- Struttura della tabella `ocr`
--

CREATE TABLE `ocr` (
  `id` int(11) NOT NULL,
  `ocr` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dump dei dati per la tabella `ocr`
--

INSERT INTO `ocr` (`id`, `ocr`) VALUES
(39, 'binance'),
(40, 'trading'),
(41, 'crypto'),
(42, 'marketplace'),
(43, 'giveaway');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `hash`
--
ALTER TABLE `hash`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `ocr`
--
ALTER TABLE `ocr`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `hash`
--
ALTER TABLE `hash`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT per la tabella `ocr`
--
ALTER TABLE `ocr`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
