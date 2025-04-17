-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Tempo de geração: 17/04/2025 às 10:04
-- Versão do servidor: 10.6.21-MariaDB-0ubuntu0.22.04.2
-- Versão do PHP: 8.1.2-1ubuntu2.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `otgclean`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `password` char(40) NOT NULL,
  `secret` char(16) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 1,
  `premdays` int(11) NOT NULL DEFAULT 0,
  `coins` int(12) NOT NULL DEFAULT 0,
  `lastday` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `proxy_id` int(11) NOT NULL DEFAULT 0,
  `email` varchar(255) NOT NULL DEFAULT '',
  `creation` bigint(20) NOT NULL DEFAULT 0,
  `vote` int(11) NOT NULL DEFAULT 0,
  `key` varchar(20) NOT NULL DEFAULT '0',
  `email_new` varchar(255) NOT NULL DEFAULT '',
  `email_new_time` int(11) NOT NULL DEFAULT 0,
  `rlname` varchar(255) NOT NULL DEFAULT '',
  `location` varchar(255) NOT NULL DEFAULT '',
  `page_access` int(11) NOT NULL DEFAULT 0,
  `email_code` varchar(255) NOT NULL DEFAULT '',
  `next_email` int(11) NOT NULL DEFAULT 0,
  `premium_points` int(11) NOT NULL DEFAULT 0,
  `create_date` bigint(20) NOT NULL DEFAULT 0,
  `create_ip` bigint(20) NOT NULL DEFAULT 0,
  `last_post` int(11) NOT NULL DEFAULT 0,
  `flag` varchar(80) NOT NULL DEFAULT '',
  `vip_time` int(11) NOT NULL DEFAULT 0,
  `guild_points` int(11) NOT NULL DEFAULT 0,
  `guild_points_stats` int(11) NOT NULL DEFAULT 0,
  `passed` int(11) NOT NULL DEFAULT 0,
  `block` int(11) NOT NULL DEFAULT 0,
  `refresh` int(11) NOT NULL DEFAULT 0,
  `birth_date` varchar(50) NOT NULL DEFAULT '',
  `gender` varchar(20) NOT NULL DEFAULT '',
  `loyalty_points` bigint(20) NOT NULL DEFAULT 0,
  `authToken` varchar(100) NOT NULL DEFAULT '',
  `player_sell_bank` int(11) DEFAULT 0,
  `secret_status` tinyint(1) NOT NULL DEFAULT 0,
  `tournamentBalance` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Despejando dados para a tabela `accounts`
--

INSERT INTO `accounts` (`id`, `name`, `password`, `secret`, `type`, `premdays`, `coins`, `lastday`, `proxy_id`, `email`, `creation`, `vote`, `key`, `email_new`, `email_new_time`, `rlname`, `location`, `page_access`, `email_code`, `next_email`, `premium_points`, `create_date`, `create_ip`, `last_post`, `flag`, `vip_time`, `guild_points`, `guild_points_stats`, `passed`, `block`, `refresh`, `birth_date`, `gender`, `loyalty_points`, `authToken`, `player_sell_bank`, `secret_status`, `tournamentBalance`) VALUES
(1, 'god', '21298df8a3277357ee55b01df9530b535cf08ec1', NULL, 5, 0, 0, 0, 0, 'god@god', 0, 0, '0', '', 0, '', '', 0, '', 0, 0, 0, 0, 0, '', 1745154024, 0, 0, 0, 0, 0, '', '', 0, '', 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `accounts_storage`
--

CREATE TABLE `accounts_storage` (
  `account_id` int(11) NOT NULL DEFAULT 0,
  `key` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `value` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Despejando dados para a tabela `accounts_storage`
--

INSERT INTO `accounts_storage` (`account_id`, `key`, `value`) VALUES
(1, 2, 1744894824);

-- --------------------------------------------------------

--
-- Estrutura para tabela `account_bans`
--

CREATE TABLE `account_bans` (
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `account_ban_history`
--

CREATE TABLE `account_ban_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expired_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `account_character_sale`
--

CREATE TABLE `account_character_sale` (
  `id` int(11) NOT NULL,
  `id_account` int(11) NOT NULL,
  `id_player` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `price_type` tinyint(4) NOT NULL,
  `price_coins` int(11) DEFAULT NULL,
  `price_gold` int(11) DEFAULT NULL,
  `dta_insert` datetime NOT NULL,
  `dta_valid` datetime NOT NULL,
  `dta_sale` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `account_viplist`
--

CREATE TABLE `account_viplist` (
  `account_id` int(11) NOT NULL COMMENT 'id of account whose viplist entry it is',
  `player_id` int(11) NOT NULL COMMENT 'id of target player of viplist entry',
  `description` varchar(128) NOT NULL DEFAULT '',
  `icon` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
  `notify` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `announcements`
--

CREATE TABLE `announcements` (
  `id` int(10) NOT NULL,
  `title` varchar(50) NOT NULL,
  `text` varchar(255) NOT NULL,
  `date` varchar(20) NOT NULL,
  `author` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `auto_loot_list`
--

CREATE TABLE `auto_loot_list` (
  `player_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `blessings_history`
--

CREATE TABLE `blessings_history` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `blessing` tinyint(4) NOT NULL,
  `loss` tinyint(1) NOT NULL,
  `timestamp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `daily_reward_history`
--

CREATE TABLE `daily_reward_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `streak` smallint(2) NOT NULL DEFAULT 0,
  `player_id` int(11) NOT NULL,
  `time` bigint(20) NOT NULL,
  `event` varchar(255) DEFAULT NULL,
  `instant` tinyint(3) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `free_pass`
--

CREATE TABLE `free_pass` (
  `player_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `global_storage`
--

CREATE TABLE `global_storage` (
  `key` varchar(32) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Despejando dados para a tabela `global_storage`
--

INSERT INTO `global_storage` (`key`, `value`) VALUES
('69799', '1594164234');

-- --------------------------------------------------------

--
-- Estrutura para tabela `guilds`
--

CREATE TABLE `guilds` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `creationdata` bigint(20) NOT NULL,
  `motd` varchar(255) NOT NULL DEFAULT '',
  `residence` int(11) NOT NULL,
  `description` text NOT NULL,
  `guild_logo` mediumblob DEFAULT NULL,
  `create_ip` bigint(20) NOT NULL DEFAULT 0,
  `balance` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `last_execute_points` bigint(20) NOT NULL DEFAULT 0,
  `logo_gfx_name` varchar(255) NOT NULL DEFAULT '',
  `level` int(11) DEFAULT 1,
  `points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guildwar_kills`
--

CREATE TABLE `guildwar_kills` (
  `id` int(11) NOT NULL,
  `killer` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  `killerguild` int(11) NOT NULL DEFAULT 0,
  `targetguild` int(11) NOT NULL DEFAULT 0,
  `warid` int(11) NOT NULL DEFAULT 0,
  `time` bigint(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_actions_h`
--

CREATE TABLE `guild_actions_h` (
  `id` int(6) UNSIGNED NOT NULL,
  `guild_id` int(11) DEFAULT NULL,
  `player_id` int(11) NOT NULL,
  `value` int(11) NOT NULL,
  `date` bigint(20) DEFAULT NULL,
  `type` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_invites`
--

CREATE TABLE `guild_invites` (
  `player_id` int(11) NOT NULL DEFAULT 0,
  `guild_id` int(11) NOT NULL DEFAULT 0,
  `date` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_membership`
--

CREATE TABLE `guild_membership` (
  `player_id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `nick` varchar(15) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_ranks`
--

CREATE TABLE `guild_ranks` (
  `id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL COMMENT 'guild',
  `name` varchar(255) NOT NULL COMMENT 'rank name',
  `level` int(11) NOT NULL COMMENT 'rank level - leader, vice, member, maybe something else'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_transfer_h`
--

CREATE TABLE `guild_transfer_h` (
  `id` int(6) UNSIGNED NOT NULL,
  `player_id` int(11) NOT NULL,
  `from_guild_id` int(6) NOT NULL,
  `to_guild_id` int(6) NOT NULL,
  `value` int(11) NOT NULL,
  `date` bigint(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `guild_wars`
--

CREATE TABLE `guild_wars` (
  `id` int(11) NOT NULL,
  `guild1` int(11) NOT NULL DEFAULT 0,
  `guild2` int(11) NOT NULL DEFAULT 0,
  `name1` varchar(255) NOT NULL,
  `name2` varchar(255) NOT NULL,
  `status` tinyint(2) NOT NULL DEFAULT 0,
  `started` bigint(15) NOT NULL DEFAULT 0,
  `ended` bigint(15) NOT NULL DEFAULT 0,
  `frags_limit` int(10) DEFAULT 20
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `houses`
--

CREATE TABLE `houses` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `paid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `warnings` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `rent` int(11) NOT NULL DEFAULT 0,
  `town_id` int(11) NOT NULL DEFAULT 0,
  `bid` int(11) NOT NULL DEFAULT 0,
  `bid_end` int(11) NOT NULL DEFAULT 0,
  `last_bid` int(11) NOT NULL DEFAULT 0,
  `highest_bidder` int(11) NOT NULL DEFAULT 0,
  `size` int(11) NOT NULL DEFAULT 0,
  `guildid` int(11) DEFAULT NULL,
  `beds` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Despejando dados para a tabela `houses`
--

INSERT INTO `houses` (`id`, `owner`, `paid`, `warnings`, `name`, `rent`, `town_id`, `bid`, `bid_end`, `last_bid`, `highest_bidder`, `size`, `guildid`, `beds`) VALUES
(1, 0, 0, 0, 'Central Lane II', 9250, 2, 0, 0, 0, 0, 37, NULL, 2),
(2, 0, 0, 0, 'Central Lane III', 17750, 2, 0, 0, 0, 0, 74, NULL, 2),
(3, 0, 0, 0, 'Central Lane IV', 6250, 2, 0, 0, 0, 0, 25, NULL, 1),
(4, 0, 0, 0, 'Central Lane V', 6250, 2, 0, 0, 0, 0, 25, NULL, 1),
(5, 0, 0, 0, 'Central Lane I', 49750, 2, 0, 0, 0, 0, 203, NULL, 3),
(6, 0, 0, 0, 'Central Shop I', 1750, 2, 0, 0, 0, 0, 11, NULL, 0),
(7, 0, 0, 0, 'Central Shop II', 2250, 2, 0, 0, 0, 0, 14, NULL, 0),
(8, 0, 0, 0, 'Central Shop III', 2250, 2, 0, 0, 0, 0, 14, NULL, 0),
(9, 0, 0, 0, 'Central Shop IV', 2250, 2, 0, 0, 0, 0, 14, NULL, 0),
(10, 0, 0, 0, 'West Side I', 16000, 2, 0, 0, 0, 0, 67, NULL, 2),
(11, 0, 0, 0, 'West Side II', 14500, 2, 0, 0, 0, 0, 64, NULL, 2),
(12, 0, 0, 0, 'Chaos Castle', 129500, 2, 0, 0, 0, 0, 457, NULL, 5),
(13, 0, 0, 0, 'West Side IV', 3250, 2, 0, 0, 0, 0, 13, NULL, 1),
(14, 0, 0, 0, 'West Side V', 2500, 2, 0, 0, 0, 0, 10, NULL, 1),
(15, 0, 0, 0, 'West Side III', 3250, 2, 0, 0, 0, 0, 13, NULL, 1),
(16, 0, 0, 0, 'West Side VI', 2500, 2, 0, 0, 0, 0, 10, NULL, 1),
(17, 0, 0, 0, 'Central Lane Flats I', 1750, 2, 0, 0, 0, 0, 7, NULL, 1),
(18, 0, 0, 0, 'Central Lane Flats II', 2500, 2, 0, 0, 0, 0, 10, NULL, 1),
(19, 0, 0, 0, 'Central Lane Flats III', 2500, 2, 0, 0, 0, 0, 10, NULL, 1),
(20, 0, 0, 0, 'Central Lane Flats IV', 2500, 2, 0, 0, 0, 0, 10, NULL, 1),
(21, 0, 0, 0, 'Central Lane Flats V', 5000, 2, 0, 0, 0, 0, 21, NULL, 1),
(22, 0, 0, 0, 'Central Lane Flats VI', 5000, 2, 0, 0, 0, 0, 21, NULL, 1),
(23, 0, 0, 0, 'Central Lane Park I', 5250, 2, 0, 0, 0, 0, 26, NULL, 2),
(24, 0, 0, 0, 'Central Lane Park IV', 5500, 2, 0, 0, 0, 0, 22, NULL, 2),
(25, 0, 0, 0, 'Central Lane Park III', 5500, 2, 0, 0, 0, 0, 22, NULL, 2),
(26, 0, 0, 0, 'Central Lane Park II', 6500, 2, 0, 0, 0, 0, 26, NULL, 2),
(27, 0, 0, 0, 'Dark Castle', 19750, 2, 0, 0, 0, 0, 83, NULL, 4),
(28, 0, 0, 0, 'North Side VII', 13250, 2, 0, 0, 0, 0, 55, NULL, 3),
(29, 0, 0, 0, 'North Side VI', 17000, 2, 0, 0, 0, 0, 93, NULL, 1),
(30, 0, 0, 0, 'North Side I', 5000, 2, 0, 0, 0, 0, 21, NULL, 1),
(31, 0, 0, 0, 'North Side II', 5000, 2, 0, 0, 0, 0, 21, NULL, 1),
(32, 0, 0, 0, 'North Side III', 3750, 2, 0, 0, 0, 0, 16, NULL, 1),
(33, 0, 0, 0, 'North Side IV', 3750, 2, 0, 0, 0, 0, 16, NULL, 1),
(34, 0, 0, 0, 'North Side V', 4000, 2, 0, 0, 0, 0, 17, NULL, 1),
(35, 0, 0, 0, 'East Side V', 11250, 2, 0, 0, 0, 0, 46, NULL, 1),
(36, 0, 0, 0, 'East Side IV', 9500, 2, 0, 0, 0, 0, 39, NULL, 1),
(37, 0, 0, 0, 'East Side I', 24750, 2, 0, 0, 0, 0, 99, NULL, 1),
(38, 0, 0, 0, 'East Side II', 7750, 2, 0, 0, 0, 0, 32, NULL, 1),
(39, 0, 0, 0, 'East Side III', 8000, 2, 0, 0, 0, 0, 32, NULL, 2),
(40, 0, 0, 0, 'Ship Shop I', 4250, 2, 0, 0, 0, 0, 17, NULL, 1),
(41, 0, 0, 0, 'Ship Shop II', 4250, 2, 0, 0, 0, 0, 17, NULL, 1),
(42, 0, 0, 0, 'Sea Side Barraks I', 2500, 2, 0, 0, 0, 0, 10, NULL, 1),
(43, 0, 0, 0, 'Sea Side Barraks II', 2500, 2, 0, 0, 0, 0, 10, NULL, 1),
(44, 0, 0, 0, 'Sea Side Barraks III', 2500, 2, 0, 0, 0, 0, 10, NULL, 1),
(45, 0, 0, 0, 'Sea Side Barraks IV', 2500, 2, 0, 0, 0, 0, 10, NULL, 1),
(46, 0, 0, 0, 'Sea Side Barraks V', 3250, 2, 0, 0, 0, 0, 13, NULL, 1),
(47, 0, 0, 0, 'Sea Side Barraks VI', 3250, 2, 0, 0, 0, 0, 13, NULL, 1),
(48, 0, 0, 0, 'Sea Side Barraks VII', 2250, 2, 0, 0, 0, 0, 9, NULL, 1),
(49, 0, 0, 0, 'Sea Side Barraks VIII', 2250, 2, 0, 0, 0, 0, 9, NULL, 1),
(50, 0, 0, 0, 'South Side I', 59250, 2, 0, 0, 0, 0, 239, NULL, 2),
(51, 0, 0, 0, 'South Side II', 6250, 2, 0, 0, 0, 0, 26, NULL, 2),
(52, 0, 0, 0, 'South Castle', 9000, 2, 0, 0, 0, 0, 39, NULL, 1),
(53, 0, 0, 0, 'South Sea Side', 35750, 2, 0, 0, 0, 0, 154, NULL, 2),
(54, 0, 0, 0, 'West Rune Side', 14500, 2, 0, 0, 0, 0, 59, NULL, 1),
(55, 0, 0, 0, 'West Side Castle', 71000, 2, 0, 0, 0, 0, 148, NULL, 5),
(56, 0, 0, 0, 'WolfStain Castle', 89500, 2, 0, 0, 0, 0, 184, NULL, 13),
(57, 0, 0, 0, 'Castle Shop 1', 9500, 3, 0, 0, 0, 0, 42, NULL, 0),
(58, 0, 0, 0, 'Castle Shop 2', 9500, 3, 0, 0, 0, 0, 42, NULL, 0),
(59, 0, 0, 0, 'Castle Shop 3', 9500, 3, 0, 0, 0, 0, 42, NULL, 0),
(60, 0, 0, 0, 'Castle Street 5', 9250, 3, 0, 0, 0, 0, 37, NULL, 1),
(61, 0, 0, 0, 'Castle Street 4', 8500, 3, 0, 0, 0, 0, 37, NULL, 1),
(62, 0, 0, 0, 'Castle Street 3', 9250, 3, 0, 0, 0, 0, 37, NULL, 2),
(63, 0, 0, 0, 'Castle Street 2', 7750, 3, 0, 0, 0, 0, 31, NULL, 1),
(64, 0, 0, 0, 'Castle Street 1', 14250, 3, 0, 0, 0, 0, 58, NULL, 2),
(65, 0, 0, 0, 'Edron Flats , Flat 1', 4750, 3, 0, 0, 0, 0, 19, NULL, 0),
(66, 0, 0, 0, 'Edron Flats , Flat 2', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(67, 0, 0, 0, 'Edron Flats , Flat 3', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(68, 0, 0, 0, 'Edron Flats , Flat 4', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(69, 0, 0, 0, 'Edron Flats , Flat 5', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(70, 0, 0, 0, 'Edron Flats , Flat 6', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(71, 0, 0, 0, 'Edron Flats , Flat 7', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(72, 0, 0, 0, 'Edron Flats , Flat 8', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(73, 0, 0, 0, 'Edron Flats , Flat 9', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(74, 0, 0, 0, 'Edron Flats , Flat 10', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(75, 0, 0, 0, 'Edron Flats , Flat 11', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(76, 0, 0, 0, 'Edron Flats , Flat 12', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(77, 0, 0, 0, 'Edron Flats , Flat 13', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(78, 0, 0, 0, 'Edron Flats , Flat 14', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(79, 0, 0, 0, 'Edron Flats , Flat 15', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(80, 0, 0, 0, 'Edron Flats , Flat 16', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(81, 0, 0, 0, 'Edron Flats , Flat 17', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(82, 0, 0, 0, 'Edron Flats , Flat 18', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(83, 0, 0, 0, 'Edron Flats , Flat 19', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(84, 0, 0, 0, 'Edron Flats , Flat 20', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(85, 0, 0, 0, 'Edron Flats , Flat 21', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(86, 0, 0, 0, 'Edron Flats , Flat 22', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(87, 0, 0, 0, 'Edron Flats , Flat 23', 2500, 3, 0, 0, 0, 0, 10, NULL, 0),
(88, 0, 0, 0, 'Edron Flats , Flat 24', 4750, 3, 0, 0, 0, 0, 19, NULL, 0),
(89, 0, 0, 0, 'Edron Flats , Basement 1', 9000, 3, 0, 0, 0, 0, 36, NULL, 2),
(90, 0, 0, 0, 'Edron Flats , Basement 2', 9000, 3, 0, 0, 0, 0, 36, NULL, 2),
(91, 0, 0, 0, 'Central Circle 1', 18000, 3, 0, 0, 0, 0, 72, NULL, 2),
(92, 0, 0, 0, 'Central Circle 2', 19750, 3, 0, 0, 0, 0, 79, NULL, 2),
(93, 0, 0, 0, 'Wood Avenue 5', 9250, 3, 0, 0, 0, 0, 37, NULL, 2),
(94, 0, 0, 0, 'Wood Avenue 1', 9250, 3, 0, 0, 0, 0, 37, NULL, 2),
(95, 0, 0, 0, 'Wood Avenue 2', 7750, 3, 0, 0, 0, 0, 31, NULL, 2),
(96, 0, 0, 0, 'Wood Avenue 3', 9250, 3, 0, 0, 0, 0, 37, NULL, 2),
(97, 0, 0, 0, 'Wood Avenue 4', 7750, 3, 0, 0, 0, 0, 31, NULL, 2),
(98, 0, 0, 0, 'Wood Avenue 4a', 6250, 3, 0, 0, 0, 0, 25, NULL, 1),
(99, 0, 0, 0, 'Wood Avenue 4b', 7750, 3, 0, 0, 0, 0, 31, NULL, 1),
(100, 0, 0, 0, 'Wood Avenue 4c', 7750, 3, 0, 0, 0, 0, 31, NULL, 2),
(101, 0, 0, 0, 'Central Circle 9a', 5250, 3, 0, 0, 0, 0, 21, NULL, 1),
(102, 0, 0, 0, 'Central Circle 9b', 5250, 3, 0, 0, 0, 0, 21, NULL, 1),
(103, 0, 0, 0, 'Central Circle 6 (shop)', 22750, 3, 0, 0, 0, 0, 94, NULL, 4),
(104, 0, 0, 0, 'Central Circle 7 (Shop)', 23000, 3, 0, 0, 0, 0, 95, NULL, 4),
(105, 0, 0, 0, 'Central Circle 8 (Shop)', 19000, 3, 0, 0, 0, 0, 78, NULL, 4),
(106, 0, 0, 0, 'Central Circle 3', 18750, 3, 0, 0, 0, 0, 75, NULL, 4),
(107, 0, 0, 0, 'Central Circle 4', 22750, 3, 0, 0, 0, 0, 91, NULL, 4),
(108, 0, 0, 0, 'Central Circle 5', 22750, 3, 0, 0, 0, 0, 91, NULL, 4),
(109, 0, 0, 0, 'Wood Avenue 6a', 8000, 3, 0, 0, 0, 0, 32, NULL, 1),
(110, 0, 0, 0, 'Wood Avenue 6b', 7500, 3, 0, 0, 0, 0, 30, NULL, 1),
(111, 0, 0, 0, 'Wood Avenue 7', 31250, 3, 0, 0, 0, 0, 98, NULL, 2),
(112, 0, 0, 0, 'Wood Avenue 8', 31250, 3, 0, 0, 0, 0, 98, NULL, 2),
(113, 0, 0, 0, 'Wood Avenue 9a', 8000, 3, 0, 0, 0, 0, 32, NULL, 1),
(114, 0, 0, 0, 'Wood Avenue 9b', 7750, 3, 0, 0, 0, 0, 31, NULL, 1),
(115, 0, 0, 0, 'Wood Avenue 10a', 8000, 3, 0, 0, 0, 0, 32, NULL, 1),
(116, 0, 0, 0, 'Wood Avenue 10b', 7750, 3, 0, 0, 0, 0, 31, NULL, 1),
(117, 0, 0, 0, 'Wood Avenue 11', 35250, 3, 0, 0, 0, 0, 141, NULL, 6),
(118, 0, 0, 0, 'Sky Lane , Guild 1', 73750, 3, 0, 0, 0, 0, 314, NULL, 14),
(119, 0, 0, 0, 'Sky Lane , Guild 2', 70500, 3, 0, 0, 0, 0, 301, NULL, 14),
(120, 0, 0, 0, 'Sky Lane, Sea Tower', 23000, 3, 0, 0, 0, 0, 92, NULL, 4),
(121, 0, 0, 0, 'Sky Lane, Guild 3', 66500, 3, 0, 0, 0, 0, 271, NULL, 14),
(122, 0, 0, 0, 'Center Tirth 5', 16500, 4, 0, 0, 0, 0, 66, NULL, 3),
(123, 0, 0, 0, 'Center Tirth 8', 23500, 4, 0, 0, 0, 0, 94, NULL, 3),
(124, 0, 0, 0, 'Center Tirith 9', 19750, 4, 0, 0, 0, 0, 79, NULL, 3),
(125, 0, 0, 0, 'Center Tirth 6', 17000, 4, 0, 0, 0, 0, 68, NULL, 2),
(126, 0, 0, 0, 'Center Tirth 4', 16500, 4, 0, 0, 0, 0, 66, NULL, 2),
(127, 0, 0, 0, 'Center Tirth 3', 16500, 4, 0, 0, 0, 0, 66, NULL, 2),
(128, 0, 0, 0, 'Center Tirth 1', 15000, 4, 0, 0, 0, 0, 60, NULL, 2),
(129, 0, 0, 0, 'Center Tirth 2', 16750, 4, 0, 0, 0, 0, 67, NULL, 2),
(130, 0, 0, 0, 'Center Tirth 7', 17000, 4, 0, 0, 0, 0, 68, NULL, 2),
(131, 0, 0, 0, 'Guild Hall Tirith 1', 0, 4, 0, 0, 0, 0, 355, NULL, 17),
(132, 0, 0, 0, 'West Tirith 2', 5250, 4, 0, 0, 0, 0, 21, NULL, 1),
(133, 0, 0, 0, 'West Tirith 1', 11750, 4, 0, 0, 0, 0, 47, NULL, 1),
(134, 0, 0, 0, 'East Tirith 1', 13000, 4, 0, 0, 0, 0, 52, NULL, 1),
(135, 0, 0, 0, 'East Tirith 2', 6750, 4, 0, 0, 0, 0, 27, NULL, 1),
(136, 0, 0, 0, 'East Tirith 3', 11500, 4, 0, 0, 0, 0, 46, NULL, 1),
(137, 0, 0, 0, 'East Tirith 4', 8000, 4, 0, 0, 0, 0, 32, NULL, 1),
(138, 0, 0, 0, 'East Tirith 5', 11500, 4, 0, 0, 0, 0, 46, NULL, 2),
(139, 0, 0, 0, 'East Tirith 6', 8500, 4, 0, 0, 0, 0, 34, NULL, 1),
(140, 0, 0, 0, 'East Tirith 7', 9750, 4, 0, 0, 0, 0, 39, NULL, 1),
(141, 0, 0, 0, 'Upside Tirith 3', 8750, 4, 0, 0, 0, 0, 35, NULL, 2),
(142, 0, 0, 0, 'Guild Hall Tirith 3', 31500, 4, 0, 0, 0, 0, 126, NULL, 6),
(143, 0, 0, 0, 'Guild Hall Tirith 2', 3350, 4, 0, 0, 0, 0, 134, NULL, 4),
(144, 0, 0, 0, 'Upside Tirith 2', 8000, 4, 0, 0, 0, 0, 32, NULL, 1),
(145, 0, 0, 0, 'Upside Tirith 1', 8500, 4, 0, 0, 0, 0, 34, NULL, 2),
(146, 0, 0, 0, 'Guild Hall Tirith 5', 79000, 4, 0, 0, 0, 0, 335, NULL, 7),
(147, 0, 0, 0, 'Guild Hall Tirith 6', 52750, 4, 0, 0, 0, 0, 215, NULL, 7),
(148, 0, 0, 0, 'Upside Tirith 4', 12500, 4, 0, 0, 0, 0, 50, NULL, 0),
(149, 0, 0, 0, 'Castle King Carlin', 0, 2, 0, 0, 0, 0, 59, NULL, 0),
(150, 0, 0, 0, 'Raccoon Mansion', 0, 1, 0, 0, 0, 0, 421, NULL, 0),
(151, 0, 0, 0, 'Bree 01', 0, 6, 0, 0, 0, 0, 56, NULL, 0),
(152, 0, 0, 0, 'Groen Vilage 1', 6250, 1, 0, 0, 0, 0, 25, NULL, 1),
(153, 0, 0, 0, 'Groen Vilage 2', 6250, 1, 0, 0, 0, 0, 25, NULL, 1),
(154, 0, 0, 0, 'Groen Vilage 3', 6250, 1, 0, 0, 0, 0, 25, NULL, 1),
(155, 0, 0, 0, 'Groen Vilage 4', 6250, 1, 0, 0, 0, 0, 25, NULL, 1),
(156, 0, 0, 0, 'Groen Vilage 5', 6250, 1, 0, 0, 0, 0, 25, NULL, 1),
(157, 0, 0, 0, 'Groen Vilage Sky 1', 6250, 1, 0, 0, 0, 0, 25, NULL, 1),
(158, 0, 0, 0, 'Groen Vilage Sky 2', 6250, 1, 0, 0, 0, 0, 25, NULL, 1),
(159, 0, 0, 0, 'Groen Vilage Sky 3', 6250, 1, 0, 0, 0, 0, 25, NULL, 1),
(160, 0, 0, 0, 'Groen Vilage Sky 4', 6250, 1, 0, 0, 0, 0, 25, NULL, 1),
(161, 0, 0, 0, 'Groen Vilage Sky 5', 6250, 1, 0, 0, 0, 0, 25, NULL, 1),
(162, 0, 0, 0, 'Groen Vilage Top 1', 6250, 1, 0, 0, 0, 0, 25, NULL, 1),
(163, 0, 0, 0, 'Groen Vilage Top 2', 6250, 1, 0, 0, 0, 0, 25, NULL, 1),
(164, 0, 0, 0, 'Groen Vilage Top 3', 6250, 1, 0, 0, 0, 0, 25, NULL, 1),
(165, 0, 0, 0, 'Groen Vilage Top 4', 6250, 1, 0, 0, 0, 0, 25, NULL, 1),
(166, 0, 0, 0, 'Groen Vilage Top 5', 6250, 1, 0, 0, 0, 0, 25, NULL, 1),
(167, 0, 0, 0, 'Groen Vilage Centre', 3250, 1, 0, 0, 0, 0, 13, NULL, 1),
(168, 0, 0, 0, 'Bree 02', 0, 6, 0, 0, 0, 0, 30, NULL, 0),
(169, 0, 0, 0, 'Bree 03', 0, 6, 0, 0, 0, 0, 48, NULL, 0),
(170, 0, 0, 0, 'Bree 04', 0, 6, 0, 0, 0, 0, 29, NULL, 0),
(171, 0, 0, 0, 'Bree 05', 0, 6, 0, 0, 0, 0, 34, NULL, 0),
(172, 0, 0, 0, 'Bree 06', 0, 6, 0, 0, 0, 0, 32, NULL, 0),
(173, 0, 0, 0, 'Bree 07', 0, 6, 0, 0, 0, 0, 40, NULL, 0),
(174, 0, 0, 0, 'Bree 08', 0, 6, 0, 0, 0, 0, 31, NULL, 0),
(175, 0, 0, 0, 'Bree 09', 0, 6, 0, 0, 0, 0, 28, NULL, 0),
(176, 0, 0, 0, 'Bree 10', 0, 6, 0, 0, 0, 0, 29, NULL, 0),
(177, 0, 0, 0, 'Bree 11', 0, 6, 0, 0, 0, 0, 50, NULL, 0),
(178, 0, 0, 0, 'Bree 12', 0, 6, 0, 0, 0, 0, 31, NULL, 0),
(179, 0, 0, 0, 'Bree 13', 0, 6, 0, 0, 0, 0, 30, NULL, 0),
(180, 0, 0, 0, 'Bree 14', 0, 6, 0, 0, 0, 0, 50, NULL, 0),
(181, 0, 0, 0, 'Bree 15', 0, 6, 0, 0, 0, 0, 30, NULL, 0),
(182, 0, 0, 0, 'Bree 16', 0, 6, 0, 0, 0, 0, 29, NULL, 0),
(194, 0, 0, 0, 'Lucky Lane 1 (Shop)', 6960, 1, 0, 0, 0, 0, 211, NULL, 4),
(208, 0, 0, 0, 'Underwood 1', 1495, 5, 0, 0, 0, 0, 41, NULL, 2),
(209, 0, 0, 0, 'Underwood 2', 1495, 5, 0, 0, 0, 0, 41, NULL, 2),
(210, 0, 0, 0, 'Underwood 5', 1370, 5, 0, 0, 0, 0, 35, NULL, 3),
(211, 0, 0, 0, 'Underwood 3', 1685, 5, 0, 0, 0, 0, 44, NULL, 3),
(212, 0, 0, 0, 'Underwood 4', 2235, 5, 0, 0, 0, 0, 56, NULL, 4),
(213, 0, 0, 0, 'Underwood 10', 585, 5, 0, 0, 0, 0, 20, NULL, 1),
(214, 0, 0, 0, 'Underwood 6', 1595, 5, 0, 0, 0, 0, 42, NULL, 3),
(215, 0, 0, 0, 'Great Willow 1a', 500, 5, 0, 0, 0, 0, 16, NULL, 1),
(216, 0, 0, 0, 'Great Willow 1b', 650, 5, 0, 0, 0, 0, 22, NULL, 1),
(217, 0, 0, 0, 'Great Willow 1c', 650, 5, 0, 0, 0, 0, 22, NULL, 1),
(218, 0, 0, 0, 'Great Willow 2d', 450, 5, 0, 0, 0, 0, 10, NULL, 1),
(219, 0, 0, 0, 'Great Willow 2c', 650, 5, 0, 0, 0, 0, 21, NULL, 1),
(220, 0, 0, 0, 'Great Willow 2b', 450, 5, 0, 0, 0, 0, 16, NULL, 1),
(221, 0, 0, 0, 'Great Willow 2a', 650, 5, 0, 0, 0, 0, 17, NULL, 1),
(222, 0, 0, 0, 'Great Willow 3d', 450, 5, 0, 0, 0, 0, 17, NULL, 1),
(223, 0, 0, 0, 'Great Willow 3c', 650, 5, 0, 0, 0, 0, 21, NULL, 1),
(224, 0, 0, 0, 'Great Willow 3b', 450, 5, 0, 0, 0, 0, 16, NULL, 1),
(225, 0, 0, 0, 'Great Willow 3a', 650, 5, 0, 0, 0, 0, 20, NULL, 1),
(226, 0, 0, 0, 'Great Willow 4b', 950, 5, 0, 0, 0, 0, 25, NULL, 2),
(227, 0, 0, 0, 'Great Willow 4c', 950, 5, 0, 0, 0, 0, 25, NULL, 2),
(228, 0, 0, 0, 'Great Willow 4d', 750, 5, 0, 0, 0, 0, 26, NULL, 1),
(229, 0, 0, 0, 'Great Willow 4a', 950, 5, 0, 0, 0, 0, 25, NULL, 2),
(230, 0, 0, 0, 'Underwood 7', 1460, 5, 0, 0, 0, 0, 39, NULL, 2),
(231, 0, 0, 0, 'Shadow Caves 3', 300, 5, 0, 0, 0, 0, 16, NULL, 1),
(232, 0, 0, 0, 'Shadow Caves 4', 300, 5, 0, 0, 0, 0, 18, NULL, 1),
(233, 0, 0, 0, 'Shadow Caves 2', 300, 5, 0, 0, 0, 0, 18, NULL, 1),
(234, 0, 0, 0, 'Shadow Caves 1', 300, 5, 0, 0, 0, 0, 16, NULL, 1),
(235, 0, 0, 0, 'Shadow Caves 17', 300, 5, 0, 0, 0, 0, 16, NULL, 1),
(236, 0, 0, 0, 'Shadow Caves 18', 300, 5, 0, 0, 0, 0, 17, NULL, 1),
(237, 0, 0, 0, 'Shadow Caves 15', 300, 5, 0, 0, 0, 0, 16, NULL, 1),
(238, 0, 0, 0, 'Shadow Caves 16', 300, 5, 0, 0, 0, 0, 17, NULL, 1),
(239, 0, 0, 0, 'Shadow Caves 13', 300, 5, 0, 0, 0, 0, 16, NULL, 1),
(240, 0, 0, 0, 'Shadow Caves 14', 300, 5, 0, 0, 0, 0, 19, NULL, 1),
(241, 0, 0, 0, 'Shadow Caves 11', 300, 5, 0, 0, 0, 0, 16, NULL, 1),
(242, 0, 0, 0, 'Shadow Caves 12', 300, 5, 0, 0, 0, 0, 18, NULL, 1),
(243, 0, 0, 0, 'Shadow Caves 27', 300, 5, 0, 0, 0, 0, 14, NULL, 1),
(244, 0, 0, 0, 'Shadow Caves 28', 300, 5, 0, 0, 0, 0, 17, NULL, 1),
(245, 0, 0, 0, 'Shadow Caves 25', 300, 5, 0, 0, 0, 0, 16, NULL, 1),
(246, 0, 0, 0, 'Shadow Caves 26', 300, 5, 0, 0, 0, 0, 17, NULL, 1),
(247, 0, 0, 0, 'Shadow Caves 23', 300, 5, 0, 0, 0, 0, 16, NULL, 1),
(248, 0, 0, 0, 'Shadow Caves 24', 300, 5, 0, 0, 0, 0, 19, NULL, 1),
(249, 0, 0, 0, 'Shadow Caves 21', 300, 5, 0, 0, 0, 0, 16, NULL, 1),
(250, 0, 0, 0, 'Shadow Caves 22', 300, 5, 0, 0, 0, 0, 17, NULL, 1),
(251, 0, 0, 0, 'Underwood 9', 585, 5, 0, 0, 0, 0, 17, NULL, 1),
(252, 0, 0, 0, 'Treetop 13', 1400, 5, 0, 0, 0, 0, 33, NULL, 2),
(254, 0, 0, 0, 'Underwood 8', 865, 5, 0, 0, 0, 0, 25, NULL, 2),
(255, 0, 0, 0, 'Mangrove 4', 950, 5, 0, 0, 0, 0, 25, NULL, 2),
(256, 0, 0, 0, 'Coastwood 10', 1630, 5, 0, 0, 0, 0, 36, NULL, 3),
(257, 0, 0, 0, 'Mangrove 1', 1750, 5, 0, 0, 0, 0, 42, NULL, 3),
(258, 0, 0, 0, 'Coastwood 1', 980, 5, 0, 0, 0, 0, 24, NULL, 2),
(259, 0, 0, 0, 'Coastwood 2', 980, 5, 0, 0, 0, 0, 24, NULL, 2),
(260, 0, 0, 0, 'Mangrove 2', 1350, 5, 0, 0, 0, 0, 33, NULL, 2),
(262, 0, 0, 0, 'Mangrove 3', 1150, 5, 0, 0, 0, 0, 29, NULL, 2),
(263, 0, 0, 0, 'Coastwood 9', 935, 5, 0, 0, 0, 0, 22, NULL, 1),
(264, 0, 0, 0, 'Coastwood 8', 1255, 5, 0, 0, 0, 0, 31, NULL, 2),
(265, 0, 0, 0, 'Coastwood 6 (Shop)', 1595, 5, 0, 0, 0, 0, 44, NULL, 1),
(266, 0, 0, 0, 'Coastwood 7', 660, 5, 0, 0, 0, 0, 19, NULL, 1),
(267, 0, 0, 0, 'Coastwood 5', 1530, 5, 0, 0, 0, 0, 35, NULL, 2),
(268, 0, 0, 0, 'Coastwood 4', 1145, 5, 0, 0, 0, 0, 30, NULL, 2),
(269, 0, 0, 0, 'Coastwood 3', 1310, 5, 0, 0, 0, 0, 34, NULL, 2),
(270, 0, 0, 0, 'Treetop 11', 900, 5, 0, 0, 0, 0, 26, NULL, 2),
(271, 0, 0, 0, 'Treetop 5 (Shop)', 1350, 5, 0, 0, 0, 0, 40, NULL, 1),
(272, 0, 0, 0, 'Treetop 7', 800, 5, 0, 0, 0, 0, 24, NULL, 1),
(273, 0, 0, 0, 'Treetop 6', 450, 5, 0, 0, 0, 0, 15, NULL, 1),
(274, 0, 0, 0, 'Treetop 8', 800, 5, 0, 0, 0, 0, 23, NULL, 1),
(275, 0, 0, 0, 'Treetop 9', 1150, 5, 0, 0, 0, 0, 30, NULL, 2),
(276, 0, 0, 0, 'Treetop 10', 1150, 5, 0, 0, 0, 0, 34, NULL, 2),
(277, 0, 0, 0, 'Treetop 4 (Shop)', 1250, 5, 0, 0, 0, 0, 40, NULL, 1),
(278, 0, 0, 0, 'Treetop 3 (Shop)', 1250, 5, 0, 0, 0, 0, 38, NULL, 1),
(279, 0, 0, 0, 'Treetop 2', 650, 5, 0, 0, 0, 0, 21, NULL, 1),
(280, 0, 0, 0, 'Treetop 1', 650, 5, 0, 0, 0, 0, 19, NULL, 1),
(281, 0, 0, 0, 'Treetop 12 (Shop)', 1350, 5, 0, 0, 0, 0, 40, NULL, 1),
(469, 0, 0, 0, 'Darashia 2, Flat 07', 1000, 10, 0, 0, 0, 0, 48, NULL, 1),
(470, 0, 0, 0, 'Darashia 2, Flat 01', 1000, 10, 0, 0, 0, 0, 48, NULL, 1),
(471, 0, 0, 0, 'Darashia 2, Flat 02', 1000, 10, 0, 0, 0, 0, 42, NULL, 1),
(472, 0, 0, 0, 'Darashia 2, Flat 06', 520, 10, 0, 0, 0, 0, 24, NULL, 1),
(473, 0, 0, 0, 'Darashia 2, Flat 05', 1260, 10, 0, 0, 0, 0, 48, NULL, 2),
(474, 0, 0, 0, 'Darashia 2, Flat 04', 520, 10, 0, 0, 0, 0, 24, NULL, 1),
(475, 0, 0, 0, 'Darashia 2, Flat 03', 1160, 10, 0, 0, 0, 0, 42, NULL, 1),
(476, 0, 0, 0, 'Darashia 2, Flat 13', 1160, 10, 0, 0, 0, 0, 42, NULL, 1),
(477, 0, 0, 0, 'Darashia 2, Flat 12', 520, 10, 0, 0, 0, 0, 24, NULL, 1),
(478, 0, 0, 0, 'Darashia 2, Flat 11', 1000, 10, 0, 0, 0, 0, 42, NULL, 1),
(479, 0, 0, 0, 'Darashia 2, Flat 14', 520, 10, 0, 0, 0, 0, 24, NULL, 1),
(480, 0, 0, 0, 'Darashia 2, Flat 15', 1260, 10, 0, 0, 0, 0, 47, NULL, 2),
(481, 0, 0, 0, 'Darashia 2, Flat 16', 680, 10, 0, 0, 0, 0, 30, NULL, 1),
(482, 0, 0, 0, 'Darashia 2, Flat 17', 1000, 10, 0, 0, 0, 0, 48, NULL, 1),
(483, 0, 0, 0, 'Darashia 2, Flat 18', 680, 10, 0, 0, 0, 0, 30, NULL, 1),
(484, 0, 0, 0, 'Darashia 1, Flat 05', 1100, 10, 0, 0, 0, 0, 48, NULL, 2),
(485, 0, 0, 0, 'Darashia 1, Flat 01', 1100, 10, 0, 0, 0, 0, 49, NULL, 2),
(486, 0, 0, 0, 'Darashia 1, Flat 04', 1000, 10, 0, 0, 0, 0, 42, NULL, 1),
(487, 0, 0, 0, 'Darashia 1, Flat 03', 2660, 10, 0, 0, 0, 0, 96, NULL, 4),
(488, 0, 0, 0, 'Darashia 1, Flat 02', 1000, 10, 0, 0, 0, 0, 41, NULL, 1),
(490, 0, 0, 0, 'Darashia 1, Flat 12', 1780, 10, 0, 0, 0, 0, 66, NULL, 2),
(491, 0, 0, 0, 'Darashia 1, Flat 11', 1100, 10, 0, 0, 0, 0, 41, NULL, 2),
(492, 0, 0, 0, 'Darashia 1, Flat 13', 1780, 10, 0, 0, 0, 0, 72, NULL, 2),
(493, 0, 0, 0, 'Darashia 1, Flat 14', 2760, 10, 0, 0, 0, 0, 108, NULL, 5),
(494, 0, 0, 0, 'Darashia 4, Flat 01', 1000, 10, 0, 0, 0, 0, 48, NULL, 1),
(495, 0, 0, 0, 'Darashia 4, Flat 05', 1100, 10, 0, 0, 0, 0, 48, NULL, 2),
(496, 0, 0, 0, 'Darashia 4, Flat 04', 1780, 10, 0, 0, 0, 0, 72, NULL, 2),
(497, 0, 0, 0, 'Darashia 4, Flat 03', 1000, 10, 0, 0, 0, 0, 42, NULL, 1),
(498, 0, 0, 0, 'Darashia 4, Flat 02', 1780, 10, 0, 0, 0, 0, 66, NULL, 2),
(499, 0, 0, 0, 'Darashia 4, Flat 13', 1780, 10, 0, 0, 0, 0, 78, NULL, 2),
(500, 0, 0, 0, 'Darashia 4, Flat 14', 1780, 10, 0, 0, 0, 0, 72, NULL, 2),
(501, 0, 0, 0, 'Darashia 4, Flat 11', 1000, 10, 0, 0, 0, 0, 41, NULL, 1),
(502, 0, 0, 0, 'Darashia 4, Flat 12', 2560, 10, 0, 0, 0, 0, 96, NULL, 3),
(503, 0, 0, 0, 'Darashia 7, Flat 05', 1225, 10, 0, 0, 0, 0, 40, NULL, 2),
(504, 0, 0, 0, 'Darashia 7, Flat 01', 1125, 10, 0, 0, 0, 0, 40, NULL, 1),
(505, 0, 0, 0, 'Darashia 7, Flat 02', 1125, 10, 0, 0, 0, 0, 41, NULL, 1),
(506, 0, 0, 0, 'Darashia 7, Flat 03', 2955, 10, 0, 0, 0, 0, 108, NULL, 4),
(507, 0, 0, 0, 'Darashia 7, Flat 04', 1125, 10, 0, 0, 0, 0, 42, NULL, 1),
(508, 0, 0, 0, 'Darashia 7, Flat 14', 2955, 10, 0, 0, 0, 0, 108, NULL, 4),
(509, 0, 0, 0, 'Darashia 7, Flat 13', 1125, 10, 0, 0, 0, 0, 42, NULL, 1),
(510, 0, 0, 0, 'Darashia 7, Flat 11', 1125, 10, 0, 0, 0, 0, 41, NULL, 1),
(511, 0, 0, 0, 'Darashia 7, Flat 12', 2955, 10, 0, 0, 0, 0, 95, NULL, 4),
(512, 0, 0, 0, 'Darashia 5, Flat 01', 1000, 10, 0, 0, 0, 0, 38, NULL, 1),
(513, 0, 0, 0, 'Darashia 5, Flat 05', 1000, 10, 0, 0, 0, 0, 48, NULL, 1),
(514, 0, 0, 0, 'Darashia 5, Flat 02', 1620, 10, 0, 0, 0, 0, 57, NULL, 2),
(515, 0, 0, 0, 'Darashia 5, Flat 03', 1000, 10, 0, 0, 0, 0, 41, NULL, 1),
(516, 0, 0, 0, 'Darashia 5, Flat 04', 1620, 10, 0, 0, 0, 0, 66, NULL, 2),
(517, 0, 0, 0, 'Darashia 5, Flat 11', 1780, 10, 0, 0, 0, 0, 66, NULL, 2),
(518, 0, 0, 0, 'Darashia 5, Flat 12', 1620, 10, 0, 0, 0, 0, 65, NULL, 2),
(519, 0, 0, 0, 'Darashia 5, Flat 13', 1780, 10, 0, 0, 0, 0, 78, NULL, 2),
(520, 0, 0, 0, 'Darashia 5, Flat 14', 1620, 10, 0, 0, 0, 0, 66, NULL, 2),
(521, 0, 0, 0, 'Darashia 6a', 3115, 10, 0, 0, 0, 0, 117, NULL, 2),
(522, 0, 0, 0, 'Darashia 6b', 3430, 10, 0, 0, 0, 0, 139, NULL, 2),
(523, 0, 0, 0, 'Darashia, Villa', 5385, 10, 0, 0, 0, 0, 233, NULL, 4),
(525, 0, 0, 0, 'Darashia, Western Guildhall', 10435, 10, 0, 0, 0, 0, 376, NULL, 14),
(526, 0, 0, 0, 'Darashia 3, Flat 01', 1100, 10, 0, 0, 0, 0, 40, NULL, 2),
(527, 0, 0, 0, 'Darashia 3, Flat 05', 1000, 10, 0, 0, 0, 0, 40, NULL, 1),
(529, 0, 0, 0, 'Darashia 3, Flat 02', 1620, 10, 0, 0, 0, 0, 65, NULL, 2),
(530, 0, 0, 0, 'Darashia 3, Flat 03', 1100, 10, 0, 0, 0, 0, 42, NULL, 2),
(531, 0, 0, 0, 'Darashia 3, Flat 04', 1620, 10, 0, 0, 0, 0, 72, NULL, 2),
(532, 0, 0, 0, 'Darashia 3, Flat 13', 1100, 10, 0, 0, 0, 0, 42, NULL, 2),
(533, 0, 0, 0, 'Darashia 3, Flat 14', 2400, 10, 0, 0, 0, 0, 102, NULL, 3),
(534, 0, 0, 0, 'Darashia 3, Flat 11', 1000, 10, 0, 0, 0, 0, 41, NULL, 1),
(535, 0, 0, 0, 'Darashia 3, Flat 12', 2600, 10, 0, 0, 0, 0, 90, NULL, 5),
(541, 0, 0, 0, 'Darashia 8, Flat 11', 1990, 10, 0, 0, 0, 0, 66, NULL, 2),
(542, 0, 0, 0, 'Darashia 8, Flat 12', 1810, 10, 0, 0, 0, 0, 65, NULL, 2),
(544, 0, 0, 0, 'Darashia 8, Flat 14', 1810, 10, 0, 0, 0, 0, 66, NULL, 2),
(545, 0, 0, 0, 'Darashia 8, Flat 13', 1990, 10, 0, 0, 0, 0, 78, NULL, 2),
(574, 0, 0, 0, 'Oskahl I j', 680, 9, 0, 0, 0, 0, 25, NULL, 1),
(575, 0, 0, 0, 'Oskahl I f', 840, 9, 0, 0, 0, 0, 34, NULL, 1),
(576, 0, 0, 0, 'Oskahl I i', 840, 9, 0, 0, 0, 0, 30, NULL, 1),
(577, 0, 0, 0, 'Oskahl I g', 1140, 9, 0, 0, 0, 0, 42, NULL, 2),
(578, 0, 0, 0, 'Oskahl I h', 1760, 9, 0, 0, 0, 0, 63, NULL, 3),
(579, 0, 0, 0, 'Oskahl I d', 1140, 9, 0, 0, 0, 0, 36, NULL, 2),
(580, 0, 0, 0, 'Oskahl I b', 840, 9, 0, 0, 0, 0, 30, NULL, 1),
(581, 0, 0, 0, 'Oskahl I c', 680, 9, 0, 0, 0, 0, 29, NULL, 1),
(582, 0, 0, 0, 'Oskahl I e', 840, 9, 0, 0, 0, 0, 33, NULL, 1),
(583, 0, 0, 0, 'Oskahl I a', 1580, 9, 0, 0, 0, 0, 52, NULL, 2),
(584, 0, 0, 0, 'Chameken I', 850, 9, 0, 0, 0, 0, 30, NULL, 1),
(585, 0, 0, 0, 'Charsirakh III', 680, 9, 0, 0, 0, 0, 30, NULL, 1),
(586, 0, 0, 0, 'Murkhol I d', 440, 9, 0, 0, 0, 0, 21, NULL, 1),
(587, 0, 0, 0, 'Murkhol I c', 440, 9, 0, 0, 0, 0, 18, NULL, 1),
(588, 0, 0, 0, 'Murkhol I b', 440, 9, 0, 0, 0, 0, 18, NULL, 1),
(589, 0, 0, 0, 'Murkhol I a', 440, 9, 0, 0, 0, 0, 20, NULL, 1),
(590, 0, 0, 0, 'Charsirakh II', 1140, 9, 0, 0, 0, 0, 39, NULL, 2),
(591, 0, 0, 0, 'Thanah II h', 1400, 9, 0, 0, 0, 0, 40, NULL, 2),
(592, 0, 0, 0, 'Thanah II g', 1650, 9, 0, 0, 0, 0, 45, NULL, 2),
(593, 0, 0, 0, 'Thanah II f', 2850, 9, 0, 0, 0, 0, 80, NULL, 3),
(594, 0, 0, 0, 'Thanah II b', 450, 9, 0, 0, 0, 0, 20, NULL, 1),
(595, 0, 0, 0, 'Thanah II c', 450, 9, 0, 0, 0, 0, 15, NULL, 1),
(596, 0, 0, 0, 'Thanah II d', 350, 9, 0, 0, 0, 0, 16, NULL, 1),
(597, 0, 0, 0, 'Thanah II e', 350, 9, 0, 0, 0, 0, 12, NULL, 1),
(599, 0, 0, 0, 'Thanah II a', 850, 9, 0, 0, 0, 0, 37, NULL, 1),
(600, 0, 0, 0, 'Thrarhor I c (Shop)', 1050, 9, 0, 0, 0, 0, 28, NULL, 1),
(601, 0, 0, 0, 'Thrarhor I d (Shop)', 1050, 9, 0, 0, 0, 0, 21, NULL, 1),
(602, 0, 0, 0, 'Thrarhor I a (Shop)', 1050, 9, 0, 0, 0, 0, 32, NULL, 1),
(603, 0, 0, 0, 'Thrarhor I b (Shop)', 1050, 9, 0, 0, 0, 0, 24, NULL, 1),
(604, 0, 0, 0, 'Thanah I c', 3250, 9, 0, 0, 0, 0, 91, NULL, 3),
(605, 0, 0, 0, 'Thanah I d', 2900, 9, 0, 0, 0, 0, 80, NULL, 4),
(606, 0, 0, 0, 'Thanah I b', 3000, 9, 0, 0, 0, 0, 84, NULL, 3),
(607, 0, 0, 0, 'Thanah I a', 850, 9, 0, 0, 0, 0, 27, NULL, 1),
(608, 0, 0, 0, 'Harrah I', 5740, 9, 0, 0, 0, 0, 190, NULL, 10),
(609, 0, 0, 0, 'Charsirakh I b', 1580, 9, 0, 0, 0, 0, 51, NULL, 2),
(610, 0, 0, 0, 'Charsirakh I a', 280, 9, 0, 0, 0, 0, 15, NULL, 1),
(611, 0, 0, 0, 'Othehothep I d', 2020, 9, 0, 0, 0, 0, 68, NULL, 4),
(612, 0, 0, 0, 'Othehothep I c', 1720, 9, 0, 0, 0, 0, 58, NULL, 3),
(613, 0, 0, 0, 'Othehothep I b', 1380, 9, 0, 0, 0, 0, 49, NULL, 2),
(614, 0, 0, 0, 'Othehothep I a', 280, 9, 0, 0, 0, 0, 14, NULL, 1),
(615, 0, 0, 0, 'Othehothep II e', 1340, 9, 0, 0, 0, 0, 44, NULL, 2),
(616, 0, 0, 0, 'Othehothep II f', 1340, 9, 0, 0, 0, 0, 44, NULL, 2),
(617, 0, 0, 0, 'Othehothep II d', 840, 9, 0, 0, 0, 0, 32, NULL, 1),
(618, 0, 0, 0, 'Othehothep II c', 840, 9, 0, 0, 0, 0, 30, NULL, 1),
(619, 0, 0, 0, 'Othehothep II b', 1920, 9, 0, 0, 0, 0, 67, NULL, 3),
(620, 0, 0, 0, 'Othehothep II a', 400, 9, 0, 0, 0, 0, 18, NULL, 1),
(621, 0, 0, 0, 'Mothrem I', 1140, 9, 0, 0, 0, 0, 38, NULL, 2),
(622, 0, 0, 0, 'Arakmehn I', 1320, 9, 0, 0, 0, 0, 41, NULL, 3),
(623, 0, 0, 0, 'Othehothep III d', 1040, 9, 0, 0, 0, 0, 36, NULL, 1),
(624, 0, 0, 0, 'Othehothep III c', 940, 9, 0, 0, 0, 0, 30, NULL, 2),
(625, 0, 0, 0, 'Othehothep III e', 840, 9, 0, 0, 0, 0, 32, NULL, 1),
(626, 0, 0, 0, 'Othehothep III f', 680, 9, 0, 0, 0, 0, 27, NULL, 1),
(627, 0, 0, 0, 'Othehothep III b', 1340, 9, 0, 0, 0, 0, 49, NULL, 2),
(628, 0, 0, 0, 'Othehothep III a', 280, 9, 0, 0, 0, 0, 14, NULL, 1),
(629, 0, 0, 0, 'Unklath I d', 1680, 9, 0, 0, 0, 0, 49, NULL, 3),
(630, 0, 0, 0, 'Unklath I e', 1580, 9, 0, 0, 0, 0, 51, NULL, 2),
(631, 0, 0, 0, 'Unklath I g', 1480, 9, 0, 0, 0, 0, 51, NULL, 1),
(632, 0, 0, 0, 'Unklath I f', 1580, 9, 0, 0, 0, 0, 51, NULL, 2),
(633, 0, 0, 0, 'Unklath I c', 1460, 9, 0, 0, 0, 0, 50, NULL, 2),
(634, 0, 0, 0, 'Unklath I b', 1460, 9, 0, 0, 0, 0, 50, NULL, 2),
(635, 0, 0, 0, 'Unklath I a', 1140, 9, 0, 0, 0, 0, 38, NULL, 2),
(636, 0, 0, 0, 'Arakmehn II', 1040, 9, 0, 0, 0, 0, 38, NULL, 1),
(637, 0, 0, 0, 'Arakmehn III', 1140, 9, 0, 0, 0, 0, 38, NULL, 2),
(638, 0, 0, 0, 'Unklath II b', 680, 9, 0, 0, 0, 0, 25, NULL, 1),
(639, 0, 0, 0, 'Unklath II c', 680, 9, 0, 0, 0, 0, 27, NULL, 1),
(640, 0, 0, 0, 'Unklath II d', 1580, 9, 0, 0, 0, 0, 52, NULL, 2),
(641, 0, 0, 0, 'Unklath II a', 1040, 9, 0, 0, 0, 0, 36, NULL, 1),
(642, 0, 0, 0, 'Arakmehn IV', 1220, 9, 0, 0, 0, 0, 41, NULL, 2),
(643, 0, 0, 0, 'Rathal I b', 680, 9, 0, 0, 0, 0, 25, NULL, 1),
(644, 0, 0, 0, 'Rathal I c', 680, 9, 0, 0, 0, 0, 27, NULL, 1),
(645, 0, 0, 0, 'Rathal I e', 780, 9, 0, 0, 0, 0, 27, NULL, 2),
(646, 0, 0, 0, 'Rathal I d', 780, 9, 0, 0, 0, 0, 27, NULL, 2),
(647, 0, 0, 0, 'Rathal I a', 1140, 9, 0, 0, 0, 0, 36, NULL, 2),
(648, 0, 0, 0, 'Rathal II b', 680, 9, 0, 0, 0, 0, 25, NULL, 1),
(649, 0, 0, 0, 'Rathal II c', 680, 9, 0, 0, 0, 0, 27, NULL, 1),
(650, 0, 0, 0, 'Rathal II d', 1460, 9, 0, 0, 0, 0, 52, NULL, 2),
(651, 0, 0, 0, 'Rathal II a', 1040, 9, 0, 0, 0, 0, 38, NULL, 1),
(653, 0, 0, 0, 'Esuph II a', 280, 9, 0, 0, 0, 0, 14, NULL, 1),
(654, 0, 0, 0, 'Uthemath II', 4460, 9, 0, 0, 0, 0, 138, NULL, 8),
(655, 0, 0, 0, 'Uthemath I e', 940, 9, 0, 0, 0, 0, 32, NULL, 2),
(656, 0, 0, 0, 'Uthemath I d', 840, 9, 0, 0, 0, 0, 30, NULL, 1),
(657, 0, 0, 0, 'Uthemath I f', 2440, 9, 0, 0, 0, 0, 86, NULL, 3),
(658, 0, 0, 0, 'Uthemath I b', 800, 9, 0, 0, 0, 0, 32, NULL, 1),
(659, 0, 0, 0, 'Uthemath I c', 900, 9, 0, 0, 0, 0, 34, NULL, 2),
(660, 0, 0, 0, 'Uthemath I a', 400, 9, 0, 0, 0, 0, 18, NULL, 1),
(661, 0, 0, 0, 'Botham I c', 1700, 9, 0, 0, 0, 0, 49, NULL, 2),
(662, 0, 0, 0, 'Botham I e', 1650, 9, 0, 0, 0, 0, 44, NULL, 2),
(663, 0, 0, 0, 'Botham I d', 3050, 9, 0, 0, 0, 0, 80, NULL, 3),
(664, 0, 0, 0, 'Botham I b', 3000, 9, 0, 0, 0, 0, 83, NULL, 3),
(666, 0, 0, 0, 'Horakhal', 9420, 9, 0, 0, 0, 0, 277, NULL, 14),
(667, 0, 0, 0, 'Esuph III b', 1340, 9, 0, 0, 0, 0, 49, NULL, 2),
(668, 0, 0, 0, 'Esuph III a', 280, 9, 0, 0, 0, 0, 14, NULL, 1),
(669, 0, 0, 0, 'Esuph IV b', 400, 9, 0, 0, 0, 0, 16, NULL, 1),
(670, 0, 0, 0, 'Esuph IV c', 400, 9, 0, 0, 0, 0, 18, NULL, 1),
(671, 0, 0, 0, 'Esuph IV d', 800, 9, 0, 0, 0, 0, 34, NULL, 1),
(672, 0, 0, 0, 'Esuph IV a', 400, 9, 0, 0, 0, 0, 16, NULL, 1),
(673, 0, 0, 0, 'Botham II e', 1650, 9, 0, 0, 0, 0, 42, NULL, 2),
(674, 0, 0, 0, 'Botham II g', 1400, 9, 0, 0, 0, 0, 38, NULL, 2),
(675, 0, 0, 0, 'Botham II f', 1650, 9, 0, 0, 0, 0, 44, NULL, 2),
(676, 0, 0, 0, 'Botham II d', 1950, 9, 0, 0, 0, 0, 49, NULL, 2),
(677, 0, 0, 0, 'Botham II c', 1250, 9, 0, 0, 0, 0, 38, NULL, 2),
(678, 0, 0, 0, 'Botham II b', 1600, 9, 0, 0, 0, 0, 47, NULL, 2),
(679, 0, 0, 0, 'Botham II a', 850, 9, 0, 0, 0, 0, 25, NULL, 1),
(680, 0, 0, 0, 'Botham III g', 1650, 9, 0, 0, 0, 0, 42, NULL, 2),
(681, 0, 0, 0, 'Botham III f', 2350, 9, 0, 0, 0, 0, 56, NULL, 3),
(682, 0, 0, 0, 'Botham III h', 3750, 9, 0, 0, 0, 0, 98, NULL, 3),
(683, 0, 0, 0, 'Botham III d', 850, 9, 0, 0, 0, 0, 27, NULL, 1),
(684, 0, 0, 0, 'Botham III e', 850, 9, 0, 0, 0, 0, 27, NULL, 1),
(685, 0, 0, 0, 'Botham III b', 950, 9, 0, 0, 0, 0, 25, NULL, 2),
(686, 0, 0, 0, 'Botham III c', 850, 9, 0, 0, 0, 0, 27, NULL, 1),
(687, 0, 0, 0, 'Botham III a', 1400, 9, 0, 0, 0, 0, 36, NULL, 2),
(688, 0, 0, 0, 'Botham IV i', 1800, 9, 0, 0, 0, 0, 51, NULL, 3),
(689, 0, 0, 0, 'Botham IV h', 1850, 9, 0, 0, 0, 0, 49, NULL, 1),
(690, 0, 0, 0, 'Botham IV f', 1700, 9, 0, 0, 0, 0, 49, NULL, 2),
(691, 0, 0, 0, 'Botham IV g', 1650, 9, 0, 0, 0, 0, 49, NULL, 2),
(692, 0, 0, 0, 'Botham IV c', 850, 9, 0, 0, 0, 0, 27, NULL, 1),
(693, 0, 0, 0, 'Botham IV e', 850, 9, 0, 0, 0, 0, 27, NULL, 1),
(694, 0, 0, 0, 'Botham IV d', 850, 9, 0, 0, 0, 0, 27, NULL, 1),
(695, 0, 0, 0, 'Botham IV b', 850, 9, 0, 0, 0, 0, 25, NULL, 1),
(696, 0, 0, 0, 'Botham IV a', 1400, 9, 0, 0, 0, 0, 36, NULL, 2),
(697, 0, 0, 0, 'Ramen Tah', 7650, 9, 0, 0, 0, 0, 184, NULL, 16),
(698, 0, 0, 0, 'Banana Bay 1', 450, 8, 0, 0, 0, 0, 25, NULL, 1),
(699, 0, 0, 0, 'Banana Bay 2', 765, 8, 0, 0, 0, 0, 36, NULL, 1),
(700, 0, 0, 0, 'Banana Bay 3', 450, 8, 0, 0, 0, 0, 25, NULL, 1),
(701, 0, 0, 0, 'Banana Bay 4', 450, 8, 0, 0, 0, 0, 25, NULL, 1),
(702, 0, 0, 0, 'Shark Manor', 8780, 8, 0, 0, 0, 0, 286, NULL, 15),
(703, 0, 0, 0, 'Coconut Quay 1', 1765, 8, 0, 0, 0, 0, 64, NULL, 2),
(704, 0, 0, 0, 'Coconut Quay 2', 1045, 8, 0, 0, 0, 0, 42, NULL, 2),
(705, 0, 0, 0, 'Coconut Quay 3', 2145, 8, 0, 0, 0, 0, 70, NULL, 4),
(706, 0, 0, 0, 'Coconut Quay 4', 2135, 8, 0, 0, 0, 0, 72, NULL, 3),
(707, 0, 0, 0, 'Crocodile Bridge 3', 1270, 8, 0, 0, 0, 0, 49, NULL, 2),
(708, 0, 0, 0, 'Crocodile Bridge 2', 865, 8, 0, 0, 0, 0, 36, NULL, 2),
(709, 0, 0, 0, 'Crocodile Bridge 1', 1045, 8, 0, 0, 0, 0, 42, NULL, 2),
(710, 0, 0, 0, 'Bamboo Garden 1', 1640, 8, 0, 0, 0, 0, 63, NULL, 3),
(711, 0, 0, 0, 'Crocodile Bridge 4', 4755, 8, 0, 0, 0, 0, 176, NULL, 4),
(712, 0, 0, 0, 'Crocodile Bridge 5', 3970, 8, 0, 0, 0, 0, 157, NULL, 2),
(713, 0, 0, 0, 'Woodway 1', 765, 8, 0, 0, 0, 0, 36, NULL, 1),
(714, 0, 0, 0, 'Woodway 2', 585, 8, 0, 0, 0, 0, 30, NULL, 1),
(715, 0, 0, 0, 'Woodway 3', 1540, 8, 0, 0, 0, 0, 65, NULL, 2),
(716, 0, 0, 0, 'Woodway 4', 405, 8, 0, 0, 0, 0, 24, NULL, 1),
(717, 0, 0, 0, 'Flamingo Flats 5', 1845, 8, 0, 0, 0, 0, 84, NULL, 1),
(718, 0, 0, 0, 'Bamboo Fortress', 21970, 8, 0, 0, 0, 0, 848, NULL, 20),
(719, 0, 0, 0, 'Bamboo Garden 3', 1540, 8, 0, 0, 0, 0, 63, NULL, 2),
(720, 0, 0, 0, 'Bamboo Garden 2', 1045, 8, 0, 0, 0, 0, 42, NULL, 2),
(721, 0, 0, 0, 'Flamingo Flats 4', 865, 8, 0, 0, 0, 0, 36, NULL, 2),
(722, 0, 0, 0, 'Flamingo Flats 2', 1045, 8, 0, 0, 0, 0, 42, NULL, 2),
(723, 0, 0, 0, 'Flamingo Flats 3', 685, 8, 0, 0, 0, 0, 30, NULL, 2),
(724, 0, 0, 0, 'Flamingo Flats 1', 685, 8, 0, 0, 0, 0, 30, NULL, 2),
(725, 0, 0, 0, 'Jungle Edge 4', 865, 8, 0, 0, 0, 0, 36, NULL, 2),
(726, 0, 0, 0, 'Jungle Edge 5', 865, 8, 0, 0, 0, 0, 36, NULL, 2),
(727, 0, 0, 0, 'Jungle Edge 6', 450, 8, 0, 0, 0, 0, 25, NULL, 1),
(728, 0, 0, 0, 'Jungle Edge 2', 3170, 8, 0, 0, 0, 0, 128, NULL, 3),
(729, 0, 0, 0, 'Jungle Edge 3', 865, 8, 0, 0, 0, 0, 36, NULL, 2),
(730, 0, 0, 0, 'Jungle Edge 1', 2495, 8, 0, 0, 0, 0, 98, NULL, 3),
(731, 0, 0, 0, 'Haggler\'s Hangout 6', 6450, 8, 0, 0, 0, 0, 208, NULL, 4),
(732, 0, 0, 0, 'Haggler\'s Hangout 5 (Shop)', 1550, 8, 0, 0, 0, 0, 56, NULL, 1),
(733, 0, 0, 0, 'Haggler\'s Hangout 4a (Shop)', 1850, 8, 0, 0, 0, 0, 56, NULL, 1),
(734, 0, 0, 0, 'Haggler\'s Hangout 4b (Shop)', 1550, 8, 0, 0, 0, 0, 56, NULL, 1),
(735, 0, 0, 0, 'Haggler\'s Hangout 3', 7550, 8, 0, 0, 0, 0, 256, NULL, 4),
(736, 0, 0, 0, 'Haggler\'s Hangout 2', 1300, 8, 0, 0, 0, 0, 49, NULL, 1),
(737, 0, 0, 0, 'Haggler\'s Hangout 1', 1400, 8, 0, 0, 0, 0, 49, NULL, 2),
(738, 0, 0, 0, 'River Homes 1', 3485, 8, 0, 0, 0, 0, 128, NULL, 3),
(739, 0, 0, 0, 'River Homes 2a', 1270, 8, 0, 0, 0, 0, 42, NULL, 2),
(740, 0, 0, 0, 'River Homes 2b', 1595, 8, 0, 0, 0, 0, 56, NULL, 3),
(741, 0, 0, 0, 'River Homes 3', 5055, 8, 0, 0, 0, 0, 176, NULL, 7),
(742, 0, 0, 0, 'The Treehouse', 24120, 8, 0, 0, 0, 0, 894, NULL, 23),
(743, 0, 0, 0, 'Corner Shop (Shop)', 2215, 12, 0, 0, 0, 0, 96, NULL, 2),
(744, 0, 0, 0, 'Tusk Flats 1', 765, 12, 0, 0, 0, 0, 40, NULL, 2),
(745, 0, 0, 0, 'Tusk Flats 2', 835, 12, 0, 0, 0, 0, 42, NULL, 2),
(746, 0, 0, 0, 'Tusk Flats 3', 660, 12, 0, 0, 0, 0, 34, NULL, 2),
(747, 0, 0, 0, 'Tusk Flats 4', 315, 12, 0, 0, 0, 0, 24, NULL, 1),
(748, 0, 0, 0, 'Tusk Flats 6', 660, 12, 0, 0, 0, 0, 35, NULL, 2),
(749, 0, 0, 0, 'Tusk Flats 5', 455, 12, 0, 0, 0, 0, 30, NULL, 1),
(750, 0, 0, 0, 'Shady Rocks 5', 2890, 12, 0, 0, 0, 0, 110, NULL, 2),
(751, 0, 0, 0, 'Shady Rocks 4 (Shop)', 2710, 12, 0, 0, 0, 0, 110, NULL, 2),
(752, 0, 0, 0, 'Shady Rocks 3', 4115, 12, 0, 0, 0, 0, 154, NULL, 3),
(753, 0, 0, 0, 'Shady Rocks 2', 2010, 12, 0, 0, 0, 0, 77, NULL, 4),
(754, 0, 0, 0, 'Shady Rocks 1', 3630, 12, 0, 0, 0, 0, 132, NULL, 4),
(755, 0, 0, 0, 'Crystal Glance', 19625, 12, 0, 0, 0, 0, 569, NULL, 24),
(756, 0, 0, 0, 'Arena Walk 3', 3550, 12, 0, 0, 0, 0, 126, NULL, 3),
(757, 0, 0, 0, 'Arena Walk 2', 1400, 12, 0, 0, 0, 0, 54, NULL, 2),
(758, 0, 0, 0, 'Arena Walk 1', 3250, 12, 0, 0, 0, 0, 128, NULL, 3),
(759, 0, 0, 0, 'Bears Paw 2', 2305, 12, 0, 0, 0, 0, 100, NULL, 2),
(760, 0, 0, 0, 'Bears Paw 1', 1810, 12, 0, 0, 0, 0, 72, NULL, 2),
(761, 0, 0, 0, 'Spirit Homes 5', 1450, 12, 0, 0, 0, 0, 56, NULL, 2),
(762, 0, 0, 0, 'Glacier Side 3', 1950, 12, 0, 0, 0, 0, 75, NULL, 2),
(763, 0, 0, 0, 'Glacier Side 2', 4750, 12, 0, 0, 0, 0, 154, NULL, 3),
(764, 0, 0, 0, 'Glacier Side 1', 1600, 12, 0, 0, 0, 0, 65, NULL, 2),
(765, 0, 0, 0, 'Spirit Homes 1', 1700, 12, 0, 0, 0, 0, 56, NULL, 2),
(766, 0, 0, 0, 'Spirit Homes 2', 1900, 12, 0, 0, 0, 0, 72, NULL, 2),
(767, 0, 0, 0, 'Spirit Homes 3', 4250, 12, 0, 0, 0, 0, 128, NULL, 3),
(768, 0, 0, 0, 'Spirit Homes 4', 1100, 12, 0, 0, 0, 0, 49, NULL, 1),
(770, 0, 0, 0, 'Glacier Side 4', 2050, 12, 0, 0, 0, 0, 75, NULL, 1),
(771, 0, 0, 0, 'Shelf Site', 4800, 12, 0, 0, 0, 0, 160, NULL, 3),
(772, 0, 0, 0, 'Raven Corner 1', 855, 12, 0, 0, 0, 0, 45, NULL, 1),
(773, 0, 0, 0, 'Raven Corner 2', 1685, 12, 0, 0, 0, 0, 60, NULL, 3),
(774, 0, 0, 0, 'Raven Corner 3', 855, 12, 0, 0, 0, 0, 45, NULL, 1),
(775, 0, 0, 0, 'Bears Paw 3', 2090, 12, 0, 0, 0, 0, 82, NULL, 3),
(776, 0, 0, 0, 'Bears Paw 4', 5205, 12, 0, 0, 0, 0, 189, NULL, 4),
(778, 0, 0, 0, 'Bears Paw 5', 2045, 12, 0, 0, 0, 0, 81, NULL, 3),
(779, 0, 0, 0, 'Trout Plaza 5 (Shop)', 3880, 12, 0, 0, 0, 0, 144, NULL, 2),
(780, 0, 0, 0, 'Pilchard Bin 1', 685, 12, 0, 0, 0, 0, 30, NULL, 2),
(781, 0, 0, 0, 'Pilchard Bin 2', 685, 12, 0, 0, 0, 0, 24, NULL, 2),
(782, 0, 0, 0, 'Pilchard Bin 3', 585, 12, 0, 0, 0, 0, 24, NULL, 1),
(783, 0, 0, 0, 'Pilchard Bin 4', 585, 12, 0, 0, 0, 0, 24, NULL, 1),
(784, 0, 0, 0, 'Pilchard Bin 5', 685, 12, 0, 0, 0, 0, 24, NULL, 2),
(785, 0, 0, 0, 'Pilchard Bin 10', 450, 12, 0, 0, 0, 0, 20, NULL, 1),
(786, 0, 0, 0, 'Pilchard Bin 9', 450, 12, 0, 0, 0, 0, 20, NULL, 1),
(787, 0, 0, 0, 'Pilchard Bin 8', 450, 12, 0, 0, 0, 0, 20, NULL, 2),
(789, 0, 0, 0, 'Pilchard Bin 7', 450, 12, 0, 0, 0, 0, 20, NULL, 1),
(790, 0, 0, 0, 'Pilchard Bin 6', 450, 12, 0, 0, 0, 0, 25, NULL, 1),
(791, 0, 0, 0, 'Trout Plaza 1', 2395, 12, 0, 0, 0, 0, 112, NULL, 2),
(792, 0, 0, 0, 'Trout Plaza 2', 1540, 12, 0, 0, 0, 0, 64, NULL, 2),
(793, 0, 0, 0, 'Trout Plaza 3', 900, 12, 0, 0, 0, 0, 36, NULL, 1),
(794, 0, 0, 0, 'Trout Plaza 4', 900, 12, 0, 0, 0, 0, 45, NULL, 1),
(795, 0, 0, 0, 'Skiffs End 1', 1540, 12, 0, 0, 0, 0, 70, NULL, 2),
(796, 0, 0, 0, 'Skiffs End 2', 910, 12, 0, 0, 0, 0, 42, NULL, 2),
(797, 0, 0, 0, 'Furrier Quarter 3', 1010, 12, 0, 0, 0, 0, 54, NULL, 2),
(798, 0, 0, 0, 'Mammoth Belly', 22810, 12, 0, 0, 0, 0, 634, NULL, 30),
(799, 0, 0, 0, 'Furrier Quarter 2', 1045, 12, 0, 0, 0, 0, 56, NULL, 2),
(800, 0, 0, 0, 'Furrier Quarter 1', 1635, 12, 0, 0, 0, 0, 84, NULL, 3),
(801, 0, 0, 0, 'Fimbul Shelf 3', 1255, 12, 0, 0, 0, 0, 66, NULL, 2),
(802, 0, 0, 0, 'Fimbul Shelf 4', 1045, 12, 0, 0, 0, 0, 56, NULL, 2),
(803, 0, 0, 0, 'Fimbul Shelf 2', 1045, 12, 0, 0, 0, 0, 56, NULL, 2),
(804, 0, 0, 0, 'Fimbul Shelf 1', 975, 12, 0, 0, 0, 0, 48, NULL, 2),
(805, 0, 0, 0, 'Frost Manor', 26370, 12, 0, 0, 0, 0, 806, NULL, 24),
(831, 0, 0, 0, 'Marble Guildhall', 16810, 3, 0, 0, 0, 0, 530, NULL, 17),
(832, 0, 0, 0, 'Iron Guildhall', 15560, 3, 0, 0, 0, 0, 464, NULL, 17),
(833, 0, 0, 0, 'The Market 1 (Shop)', 650, 3, 0, 0, 0, 0, 25, NULL, 1),
(834, 0, 0, 0, 'The Market 3 (Shop)', 1450, 3, 0, 0, 0, 0, 40, NULL, 1),
(835, 0, 0, 0, 'The Market 2 (Shop)', 1100, 3, 0, 0, 0, 0, 40, NULL, 1),
(836, 0, 0, 0, 'The Market 4 (Shop)', 1800, 3, 0, 0, 0, 0, 48, NULL, 1),
(837, 0, 0, 0, 'Granite Guildhall', 17845, 3, 0, 0, 0, 0, 530, NULL, 17),
(838, 0, 0, 0, 'Upper Barracks 1', 210, 3, 0, 0, 0, 0, 14, NULL, 1),
(850, 0, 0, 0, 'Upper Barracks 13', 580, 3, 0, 0, 0, 0, 24, NULL, 2),
(851, 0, 0, 0, 'Nobility Quarter 4', 765, 3, 0, 0, 0, 0, 25, NULL, 1),
(852, 0, 0, 0, 'Nobility Quarter 5', 765, 3, 0, 0, 0, 0, 25, NULL, 1),
(853, 0, 0, 0, 'Nobility Quarter 7', 765, 3, 0, 0, 0, 0, 25, NULL, 1),
(854, 0, 0, 0, 'Nobility Quarter 6', 765, 3, 0, 0, 0, 0, 26, NULL, 1),
(855, 0, 0, 0, 'Nobility Quarter 8', 765, 3, 0, 0, 0, 0, 26, NULL, 1),
(856, 0, 0, 0, 'Nobility Quarter 9', 765, 3, 0, 0, 0, 0, 26, NULL, 1),
(857, 0, 0, 0, 'Nobility Quarter 2', 1865, 3, 0, 0, 0, 0, 50, NULL, 3),
(858, 0, 0, 0, 'Nobility Quarter 3', 1865, 3, 0, 0, 0, 0, 50, NULL, 3),
(859, 0, 0, 0, 'Nobility Quarter 1', 1865, 3, 0, 0, 0, 0, 50, NULL, 3),
(863, 0, 0, 0, 'The Farms 6, Fishing Hut', 1255, 3, 0, 0, 0, 0, 32, NULL, 2),
(864, 0, 0, 0, 'The Farms 5', 1530, 3, 0, 0, 0, 0, 36, NULL, 2),
(866, 0, 0, 0, 'The Farms 3', 1530, 3, 0, 0, 0, 0, 36, NULL, 2),
(867, 0, 0, 0, 'The Farms 2', 1530, 3, 0, 0, 0, 0, 36, NULL, 2),
(868, 0, 0, 0, 'The Farms 1', 2510, 3, 0, 0, 0, 0, 60, NULL, 3),
(886, 0, 0, 0, 'Outlaw Castle', 8000, 3, 0, 0, 0, 0, 307, NULL, 9),
(889, 0, 0, 0, 'Tunnel Gardens 3', 2000, 3, 0, 0, 0, 0, 43, NULL, 3),
(890, 0, 0, 0, 'Tunnel Gardens 4', 2000, 3, 0, 0, 0, 0, 42, NULL, 3),
(892, 0, 0, 0, 'Tunnel Gardens 5', 1360, 3, 0, 0, 0, 0, 35, NULL, 2),
(893, 0, 0, 0, 'Tunnel Gardens 6', 1360, 3, 0, 0, 0, 0, 38, NULL, 2),
(894, 0, 0, 0, 'Tunnel Gardens 8', 1360, 3, 0, 0, 0, 0, 35, NULL, 2),
(895, 0, 0, 0, 'Tunnel Gardens 7', 1360, 3, 0, 0, 0, 0, 35, NULL, 2),
(900, 0, 0, 0, 'Wolftower', 21550, 3, 0, 0, 0, 0, 638, NULL, 23),
(901, 0, 0, 0, 'Paupers Palace, Flat 11', 315, 1, 0, 0, 0, 0, 12, NULL, 1),
(905, 0, 0, 0, 'Botham I a', 950, 9, 0, 0, 0, 0, 36, NULL, 1),
(906, 0, 0, 0, 'Esuph I', 680, 9, 0, 0, 0, 0, 39, NULL, 1),
(907, 0, 0, 0, 'Esuph II b', 1380, 9, 0, 0, 0, 0, 51, NULL, 2),
(1883, 0, 0, 0, 'Aureate Court 1', 5240, 13, 0, 0, 0, 0, 276, NULL, 3),
(1884, 0, 0, 0, 'Aureate Court 2', 4860, 13, 0, 0, 0, 0, 201, NULL, 2),
(1885, 0, 0, 0, 'Aureate Court 3', 4300, 13, 0, 0, 0, 0, 228, NULL, 2),
(1886, 0, 0, 0, 'Aureate Court 4', 3980, 13, 0, 0, 0, 0, 210, NULL, 4),
(1887, 0, 0, 0, 'Fortune Wing 1', 10180, 13, 0, 0, 0, 0, 422, NULL, 4),
(1888, 0, 0, 0, 'Fortune Wing 2', 5580, 13, 0, 0, 0, 0, 260, NULL, 2),
(1889, 0, 0, 0, 'Fortune Wing 3', 5740, 13, 0, 0, 0, 0, 258, NULL, 2),
(1890, 0, 0, 0, 'Fortune Wing 4', 5740, 13, 0, 0, 0, 0, 306, NULL, 4),
(1891, 0, 0, 0, 'Luminous Arc 1', 6460, 13, 0, 0, 0, 0, 344, NULL, 2),
(1892, 0, 0, 0, 'Luminous Arc 2', 6460, 13, 0, 0, 0, 0, 301, NULL, 4),
(1893, 0, 0, 0, 'Luminous Arc 3', 5400, 13, 0, 0, 0, 0, 249, NULL, 3),
(1894, 0, 0, 0, 'Luminous Arc 4', 8000, 13, 0, 0, 0, 0, 343, NULL, 5),
(1895, 0, 0, 0, 'Radiant Plaza 1', 5620, 13, 0, 0, 0, 0, 276, NULL, 4),
(1896, 0, 0, 0, 'Radiant Plaza 2', 3820, 13, 0, 0, 0, 0, 179, NULL, 2),
(1897, 0, 0, 0, 'Radiant Plaza 3', 4900, 13, 0, 0, 0, 0, 257, NULL, 2),
(1898, 0, 0, 0, 'Radiant Plaza 4', 7460, 13, 0, 0, 0, 0, 367, NULL, 3),
(1899, 0, 0, 0, 'Sun Palace', 23120, 13, 0, 0, 0, 0, 976, NULL, 27),
(1900, 0, 0, 0, 'Halls of Serenity', 23360, 13, 0, 0, 0, 0, 1093, NULL, 33),
(1901, 0, 0, 0, 'Cascade Towers', 19500, 13, 0, 0, 0, 0, 811, NULL, 33),
(1902, 0, 0, 0, 'Sorcerer\'s Avenue 5', 2695, 2, 0, 0, 0, 0, 96, NULL, 1),
(1903, 0, 0, 0, 'Sorcerer\'s Avenue 1a', 1255, 2, 0, 0, 0, 0, 42, NULL, 2),
(1904, 0, 0, 0, 'Sorcerer\'s Avenue 1b', 1035, 2, 0, 0, 0, 0, 36, NULL, 2),
(1905, 0, 0, 0, 'Sorcerer\'s Avenue 1c', 1255, 2, 0, 0, 0, 0, 36, NULL, 2),
(1906, 0, 0, 0, 'Beach Home Apartments, Flat 06', 1145, 2, 0, 0, 0, 0, 40, NULL, 2),
(1907, 0, 0, 0, 'Beach Home Apartments, Flat 01', 715, 2, 0, 0, 0, 0, 30, NULL, 1),
(1908, 0, 0, 0, 'Beach Home Apartments, Flat 02', 715, 2, 0, 0, 0, 0, 25, NULL, 1),
(1909, 0, 0, 0, 'Beach Home Apartments, Flat 03', 715, 2, 0, 0, 0, 0, 30, NULL, 1),
(1910, 0, 0, 0, 'Beach Home Apartments, Flat 04', 715, 2, 0, 0, 0, 0, 24, NULL, 1),
(1911, 0, 0, 0, 'Beach Home Apartments, Flat 05', 715, 2, 0, 0, 0, 0, 24, NULL, 1),
(1912, 0, 0, 0, 'Beach Home Apartments, Flat 16', 1145, 2, 0, 0, 0, 0, 40, NULL, 2),
(1913, 0, 0, 0, 'Beach Home Apartments, Flat 11', 715, 2, 0, 0, 0, 0, 30, NULL, 1),
(1914, 0, 0, 0, 'Beach Home Apartments, Flat 12', 880, 2, 0, 0, 0, 0, 30, NULL, 1),
(1915, 0, 0, 0, 'Beach Home Apartments, Flat 13', 880, 2, 0, 0, 0, 0, 29, NULL, 1),
(1916, 0, 0, 0, 'Beach Home Apartments, Flat 14', 385, 2, 0, 0, 0, 0, 15, NULL, 1),
(1917, 0, 0, 0, 'Beach Home Apartments, Flat 15', 385, 2, 0, 0, 0, 0, 15, NULL, 1),
(1918, 0, 0, 0, 'Thais Clanhall', 8420, 2, 0, 0, 0, 0, 370, NULL, 10),
(1919, 0, 0, 0, 'Harbour Street 4', 935, 2, 0, 0, 0, 0, 30, NULL, 1),
(1920, 0, 0, 0, 'Thais Hostel', 6980, 2, 0, 0, 0, 0, 171, NULL, 24),
(1921, 0, 0, 0, 'Lower Swamp Lane 1', 4740, 2, 0, 0, 0, 0, 166, NULL, 4),
(1923, 0, 0, 0, 'Lower Swamp Lane 3', 4740, 2, 0, 0, 0, 0, 161, NULL, 4),
(1924, 0, 0, 0, 'Sunset Homes, Flat 01', 520, 2, 0, 0, 0, 0, 25, NULL, 1),
(1925, 0, 0, 0, 'Sunset Homes, Flat 02', 520, 2, 0, 0, 0, 0, 30, NULL, 1),
(1926, 0, 0, 0, 'Sunset Homes, Flat 03', 520, 2, 0, 0, 0, 0, 30, NULL, 1),
(1927, 0, 0, 0, 'Sunset Homes, Flat 14', 520, 2, 0, 0, 0, 0, 30, NULL, 1),
(1929, 0, 0, 0, 'Sunset Homes, Flat 13', 860, 2, 0, 0, 0, 0, 35, NULL, 2),
(1930, 0, 0, 0, 'Sunset Homes, Flat 12', 520, 2, 0, 0, 0, 0, 25, NULL, 1),
(1932, 0, 0, 0, 'Sunset Homes, Flat 11', 520, 2, 0, 0, 0, 0, 25, NULL, 1),
(1935, 0, 0, 0, 'Sunset Homes, Flat 24', 520, 2, 0, 0, 0, 0, 30, NULL, 1),
(1936, 0, 0, 0, 'Sunset Homes, Flat 23', 860, 2, 0, 0, 0, 0, 35, NULL, 2),
(1937, 0, 0, 0, 'Sunset Homes, Flat 22', 520, 2, 0, 0, 0, 0, 25, NULL, 1),
(1938, 0, 0, 0, 'Sunset Homes, Flat 21', 520, 2, 0, 0, 0, 0, 25, NULL, 1),
(1939, 0, 0, 0, 'Harbour Place 1 (Shop)', 1100, 2, 0, 0, 0, 0, 37, NULL, 1),
(1940, 0, 0, 0, 'Harbour Place 2 (Shop)', 1300, 2, 0, 0, 0, 0, 48, NULL, 1),
(1941, 0, 0, 0, 'Warriors Guildhall', 14725, 2, 0, 0, 0, 0, 522, NULL, 11),
(1942, 0, 0, 0, 'Farm Lane, 1st floor (Shop)', 945, 2, 0, 0, 0, 0, 42, NULL, 0),
(1943, 0, 0, 0, 'Farm Lane, Basement (Shop)', 945, 2, 0, 0, 0, 0, 36, NULL, 0),
(1944, 0, 0, 0, 'Main Street 9, 1st floor (Shop)', 1440, 2, 0, 0, 0, 0, 47, NULL, 0),
(1945, 0, 0, 0, 'Main Street 9a, 2nd floor (Shop)', 765, 2, 0, 0, 0, 0, 30, NULL, 0),
(1946, 0, 0, 0, 'Main Street 9b, 2nd floor (Shop)', 1260, 2, 0, 0, 0, 0, 48, NULL, 0),
(1947, 0, 0, 0, 'Farm Lane, 2nd Floor (Shop)', 945, 2, 0, 0, 0, 0, 42, NULL, 0),
(1948, 0, 0, 0, 'The City Wall 5a', 585, 2, 0, 0, 0, 0, 24, NULL, 1),
(1949, 0, 0, 0, 'The City Wall 5c', 585, 2, 0, 0, 0, 0, 24, NULL, 1),
(1950, 0, 0, 0, 'The City Wall 5e', 585, 2, 0, 0, 0, 0, 30, NULL, 1),
(1951, 0, 0, 0, 'The City Wall 5b', 585, 2, 0, 0, 0, 0, 24, NULL, 1),
(1952, 0, 0, 0, 'The City Wall 5d', 585, 2, 0, 0, 0, 0, 24, NULL, 1),
(1953, 0, 0, 0, 'The City Wall 5f', 585, 2, 0, 0, 0, 0, 30, NULL, 1),
(1954, 0, 0, 0, 'The City Wall 3a', 1045, 2, 0, 0, 0, 0, 42, NULL, 2),
(1955, 0, 0, 0, 'The City Wall 3b', 1045, 2, 0, 0, 0, 0, 35, NULL, 2),
(1956, 0, 0, 0, 'The City Wall 3c', 1045, 2, 0, 0, 0, 0, 35, NULL, 2),
(1957, 0, 0, 0, 'The City Wall 3d', 1045, 2, 0, 0, 0, 0, 41, NULL, 2),
(1958, 0, 0, 0, 'The City Wall 3e', 1045, 2, 0, 0, 0, 0, 30, NULL, 2),
(1959, 0, 0, 0, 'The City Wall 3f', 1045, 2, 0, 0, 0, 0, 31, NULL, 2),
(1960, 0, 0, 0, 'The City Wall 1a', 1270, 2, 0, 0, 0, 0, 49, NULL, 2),
(1961, 0, 0, 0, 'Mill Avenue 3', 1400, 2, 0, 0, 0, 0, 49, NULL, 2),
(1962, 0, 0, 0, 'The City Wall 1b', 1270, 2, 0, 0, 0, 0, 49, NULL, 2),
(1963, 0, 0, 0, 'Mill Avenue 4', 1400, 2, 0, 0, 0, 0, 49, NULL, 2),
(1964, 0, 0, 0, 'Mill Avenue 5', 3250, 2, 0, 0, 0, 0, 128, NULL, 4),
(1965, 0, 0, 0, 'Mill Avenue 1 (Shop)', 1300, 2, 0, 0, 0, 0, 54, NULL, 1),
(1966, 0, 0, 0, 'Mill Avenue 2 (Shop)', 2350, 2, 0, 0, 0, 0, 80, NULL, 2),
(1967, 0, 0, 0, 'The City Wall 7c', 865, 2, 0, 0, 0, 0, 36, NULL, 2),
(1968, 0, 0, 0, 'The City Wall 7a', 585, 2, 0, 0, 0, 0, 30, NULL, 1),
(1969, 0, 0, 0, 'The City Wall 7e', 865, 2, 0, 0, 0, 0, 36, NULL, 2),
(1970, 0, 0, 0, 'The City Wall 7g', 585, 2, 0, 0, 0, 0, 30, NULL, 1),
(1971, 0, 0, 0, 'The City Wall 7d', 865, 2, 0, 0, 0, 0, 36, NULL, 2),
(1972, 0, 0, 0, 'The City Wall 7b', 585, 2, 0, 0, 0, 0, 30, NULL, 1),
(1973, 0, 0, 0, 'The City Wall 7f', 865, 2, 0, 0, 0, 0, 35, NULL, 2),
(1974, 0, 0, 0, 'The City Wall 7h', 585, 2, 0, 0, 0, 0, 30, NULL, 1),
(1975, 0, 0, 0, 'The City Wall 9', 955, 2, 0, 0, 0, 0, 50, NULL, 2),
(1976, 0, 0, 0, 'Upper Swamp Lane 12', 3800, 2, 0, 0, 0, 0, 116, NULL, 3),
(1977, 0, 0, 0, 'Upper Swamp Lane 10', 2060, 2, 0, 0, 0, 0, 70, NULL, 3),
(1978, 0, 0, 0, 'Upper Swamp Lane 8', 8120, 2, 0, 0, 0, 0, 216, NULL, 3),
(1979, 0, 0, 0, 'Southern Thais Guildhall', 22440, 2, 0, 0, 0, 0, 596, NULL, 16),
(1980, 0, 0, 0, 'Alai Flats, Flat 04', 765, 2, 0, 0, 0, 0, 30, NULL, 1),
(1981, 0, 0, 0, 'Alai Flats, Flat 05', 1225, 2, 0, 0, 0, 0, 38, NULL, 2),
(1982, 0, 0, 0, 'Alai Flats, Flat 06', 1225, 2, 0, 0, 0, 0, 48, NULL, 2),
(1983, 0, 0, 0, 'Alai Flats, Flat 07', 765, 2, 0, 0, 0, 0, 30, NULL, 1),
(1984, 0, 0, 0, 'Alai Flats, Flat 08', 765, 2, 0, 0, 0, 0, 30, NULL, 1),
(1985, 0, 0, 0, 'Alai Flats, Flat 03', 765, 2, 0, 0, 0, 0, 36, NULL, 1),
(1986, 0, 0, 0, 'Alai Flats, Flat 01', 765, 2, 0, 0, 0, 0, 26, NULL, 1),
(1987, 0, 0, 0, 'Alai Flats, Flat 02', 765, 2, 0, 0, 0, 0, 34, NULL, 1),
(1988, 0, 0, 0, 'Alai Flats, Flat 14', 900, 2, 0, 0, 0, 0, 33, NULL, 1),
(1989, 0, 0, 0, 'Alai Flats, Flat 15', 1450, 2, 0, 0, 0, 0, 48, NULL, 2),
(1990, 0, 0, 0, 'Alai Flats, Flat 16', 1450, 2, 0, 0, 0, 0, 54, NULL, 2),
(1991, 0, 0, 0, 'Alai Flats, Flat 17', 900, 2, 0, 0, 0, 0, 38, NULL, 1),
(1992, 0, 0, 0, 'Alai Flats, Flat 18', 900, 2, 0, 0, 0, 0, 38, NULL, 1),
(1993, 0, 0, 0, 'Alai Flats, Flat 13', 765, 2, 0, 0, 0, 0, 36, NULL, 1),
(1994, 0, 0, 0, 'Alai Flats, Flat 12', 765, 2, 0, 0, 0, 0, 25, NULL, 1),
(1995, 0, 0, 0, 'Alai Flats, Flat 11', 765, 2, 0, 0, 0, 0, 35, NULL, 1),
(1996, 0, 0, 0, 'Alai Flats, Flat 24', 900, 2, 0, 0, 0, 0, 36, NULL, 1),
(1997, 0, 0, 0, 'Alai Flats, Flat 25', 1450, 2, 0, 0, 0, 0, 52, NULL, 2),
(1998, 0, 0, 0, 'Alai Flats, Flat 26', 1450, 2, 0, 0, 0, 0, 60, NULL, 2),
(1999, 0, 0, 0, 'Alai Flats, Flat 27', 900, 2, 0, 0, 0, 0, 38, NULL, 1),
(2000, 0, 0, 0, 'Alai Flats, Flat 28', 900, 2, 0, 0, 0, 0, 38, NULL, 1),
(2001, 0, 0, 0, 'Alai Flats, Flat 23', 765, 2, 0, 0, 0, 0, 35, NULL, 1),
(2002, 0, 0, 0, 'Alai Flats, Flat 22', 765, 2, 0, 0, 0, 0, 25, NULL, 1),
(2003, 0, 0, 0, 'Alai Flats, Flat 21', 765, 2, 0, 0, 0, 0, 36, NULL, 1),
(2004, 0, 0, 0, 'Upper Swamp Lane 4', 4740, 2, 0, 0, 0, 0, 165, NULL, 4),
(2005, 0, 0, 0, 'Upper Swamp Lane 2', 4740, 2, 0, 0, 0, 0, 159, NULL, 4),
(2006, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2c', 715, 2, 0, 0, 0, 0, 20, NULL, 1),
(2007, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2d', 715, 2, 0, 0, 0, 0, 20, NULL, 1),
(2008, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2e', 715, 2, 0, 0, 0, 0, 20, NULL, 1),
(2009, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2f', 715, 2, 0, 0, 0, 0, 20, NULL, 1),
(2010, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2b', 715, 2, 0, 0, 0, 0, 24, NULL, 1),
(2011, 0, 0, 0, 'Sorcerer\'s Avenue Labs 2a', 715, 2, 0, 0, 0, 0, 24, NULL, 1),
(2012, 0, 0, 0, 'Ivory Circle 1', 4280, 7, 0, 0, 0, 0, 160, NULL, 2),
(2013, 0, 0, 0, 'Admiral\'s Avenue 3', 4115, 7, 0, 0, 0, 0, 142, NULL, 2),
(2014, 0, 0, 0, 'Admiral\'s Avenue 2', 5470, 7, 0, 0, 0, 0, 176, NULL, 4),
(2015, 0, 0, 0, 'Admiral\'s Avenue 1', 5105, 7, 0, 0, 0, 0, 168, NULL, 2),
(2016, 0, 0, 0, 'Sugar Street 5', 1350, 7, 0, 0, 0, 0, 48, NULL, 2),
(2017, 0, 0, 0, 'Freedom Street 1', 2450, 7, 0, 0, 0, 0, 84, NULL, 2),
(2018, 0, 0, 0, 'Freedom Street 2', 6050, 7, 0, 0, 0, 0, 208, NULL, 4),
(2019, 0, 0, 0, 'Trader\'s Point 2 (Shop)', 5350, 7, 0, 0, 0, 0, 198, NULL, 2),
(2020, 0, 0, 0, 'Trader\'s Point 3 (Shop)', 5950, 7, 0, 0, 0, 0, 195, NULL, 2),
(2021, 0, 0, 0, 'Ivory Circle 2', 7030, 7, 0, 0, 0, 0, 214, NULL, 2),
(2022, 0, 0, 0, 'The Tavern 1a', 2750, 7, 0, 0, 0, 0, 72, NULL, 4),
(2023, 0, 0, 0, 'The Tavern 1b', 1900, 7, 0, 0, 0, 0, 54, NULL, 2),
(2024, 0, 0, 0, 'The Tavern 1c', 4150, 7, 0, 0, 0, 0, 132, NULL, 3),
(2025, 0, 0, 0, 'The Tavern 1d', 1550, 7, 0, 0, 0, 0, 48, NULL, 2),
(2026, 0, 0, 0, 'The Tavern 2d', 1350, 7, 0, 0, 0, 0, 40, NULL, 2),
(2027, 0, 0, 0, 'The Tavern 2c', 950, 7, 0, 0, 0, 0, 32, NULL, 1),
(2028, 0, 0, 0, 'The Tavern 2b', 1700, 7, 0, 0, 0, 0, 62, NULL, 2),
(2029, 0, 0, 0, 'The Tavern 2a', 5550, 7, 0, 0, 0, 0, 163, NULL, 5),
(2030, 0, 0, 0, 'Straycat\'s Corner 4', 210, 7, 0, 0, 0, 0, 20, NULL, 1),
(2031, 0, 0, 0, 'Straycat\'s Corner 3', 210, 7, 0, 0, 0, 0, 20, NULL, 1),
(2032, 0, 0, 0, 'Straycat\'s Corner 2', 660, 7, 0, 0, 0, 0, 49, NULL, 1),
(2033, 0, 0, 0, 'Litter Promenade 5', 580, 7, 0, 0, 0, 0, 35, NULL, 2),
(2034, 0, 0, 0, 'Litter Promenade 4', 390, 7, 0, 0, 0, 0, 30, NULL, 1),
(2035, 0, 0, 0, 'Litter Promenade 3', 450, 7, 0, 0, 0, 0, 36, NULL, 1),
(2036, 0, 0, 0, 'Litter Promenade 2', 300, 7, 0, 0, 0, 0, 25, NULL, 1),
(2037, 0, 0, 0, 'Litter Promenade 1', 400, 7, 0, 0, 0, 0, 25, NULL, 2),
(2038, 0, 0, 0, 'The Shelter', 13590, 7, 0, 0, 0, 0, 560, NULL, 31),
(2039, 0, 0, 0, 'Straycat\'s Corner 6', 300, 7, 0, 0, 0, 0, 25, NULL, 1);
INSERT INTO `houses` (`id`, `owner`, `paid`, `warnings`, `name`, `rent`, `town_id`, `bid`, `bid_end`, `last_bid`, `highest_bidder`, `size`, `guildid`, `beds`) VALUES
(2040, 0, 0, 0, 'Straycat\'s Corner 5', 760, 7, 0, 0, 0, 0, 48, NULL, 2),
(2042, 0, 0, 0, 'Rum Alley 3', 330, 7, 0, 0, 0, 0, 28, NULL, 1),
(2043, 0, 0, 0, 'Straycat\'s Corner 1', 300, 7, 0, 0, 0, 0, 25, NULL, 1),
(2044, 0, 0, 0, 'Rum Alley 2', 300, 7, 0, 0, 0, 0, 25, NULL, 1),
(2045, 0, 0, 0, 'Rum Alley 1', 510, 7, 0, 0, 0, 0, 36, NULL, 1),
(2046, 0, 0, 0, 'Smuggler Backyard 3', 700, 7, 0, 0, 0, 0, 40, NULL, 2),
(2048, 0, 0, 0, 'Shady Trail 3', 300, 7, 0, 0, 0, 0, 25, NULL, 1),
(2049, 0, 0, 0, 'Shady Trail 1', 1150, 7, 0, 0, 0, 0, 48, NULL, 5),
(2050, 0, 0, 0, 'Shady Trail 2', 490, 7, 0, 0, 0, 0, 30, NULL, 2),
(2051, 0, 0, 0, 'Smuggler Backyard 5', 610, 7, 0, 0, 0, 0, 35, NULL, 2),
(2052, 0, 0, 0, 'Smuggler Backyard 4', 390, 7, 0, 0, 0, 0, 30, NULL, 1),
(2053, 0, 0, 0, 'Smuggler Backyard 2', 670, 7, 0, 0, 0, 0, 40, NULL, 2),
(2054, 0, 0, 0, 'Smuggler Backyard 1', 670, 7, 0, 0, 0, 0, 40, NULL, 2),
(2055, 0, 0, 0, 'Sugar Street 2', 2550, 7, 0, 0, 0, 0, 84, NULL, 3),
(2056, 0, 0, 0, 'Sugar Street 1', 3000, 7, 0, 0, 0, 0, 84, NULL, 3),
(2057, 0, 0, 0, 'Sugar Street 3a', 1650, 7, 0, 0, 0, 0, 54, NULL, 3),
(2058, 0, 0, 0, 'Sugar Street 3b', 2050, 7, 0, 0, 0, 0, 60, NULL, 3),
(2059, 0, 0, 0, 'Harvester\'s Haven, Flat 01', 950, 7, 0, 0, 0, 0, 36, NULL, 2),
(2060, 0, 0, 0, 'Harvester\'s Haven, Flat 03', 950, 7, 0, 0, 0, 0, 30, NULL, 2),
(2061, 0, 0, 0, 'Harvester\'s Haven, Flat 05', 950, 7, 0, 0, 0, 0, 30, NULL, 2),
(2062, 0, 0, 0, 'Harvester\'s Haven, Flat 02', 950, 7, 0, 0, 0, 0, 36, NULL, 2),
(2063, 0, 0, 0, 'Harvester\'s Haven, Flat 04', 950, 7, 0, 0, 0, 0, 30, NULL, 2),
(2064, 0, 0, 0, 'Harvester\'s Haven, Flat 06', 950, 7, 0, 0, 0, 0, 30, NULL, 2),
(2065, 0, 0, 0, 'Harvester\'s Haven, Flat 07', 950, 7, 0, 0, 0, 0, 30, NULL, 2),
(2066, 0, 0, 0, 'Harvester\'s Haven, Flat 09', 950, 7, 0, 0, 0, 0, 30, NULL, 2),
(2067, 0, 0, 0, 'Harvester\'s Haven, Flat 11', 950, 7, 0, 0, 0, 0, 36, NULL, 2),
(2068, 0, 0, 0, 'Harvester\'s Haven, Flat 12', 950, 7, 0, 0, 0, 0, 36, NULL, 2),
(2069, 0, 0, 0, 'Harvester\'s Haven, Flat 10', 950, 7, 0, 0, 0, 0, 30, NULL, 2),
(2070, 0, 0, 0, 'Harvester\'s Haven, Flat 08', 950, 7, 0, 0, 0, 0, 30, NULL, 2),
(2071, 0, 0, 0, 'Marble Lane 4', 6350, 7, 0, 0, 0, 0, 192, NULL, 4),
(2072, 0, 0, 0, 'Marble Lane 2', 6415, 7, 0, 0, 0, 0, 200, NULL, 3),
(2073, 0, 0, 0, 'Marble Lane 3', 8055, 7, 0, 0, 0, 0, 240, NULL, 4),
(2074, 0, 0, 0, 'Marble Lane 1', 11060, 7, 0, 0, 0, 0, 320, NULL, 6),
(2075, 0, 0, 0, 'Ivy Cottage', 30650, 7, 0, 0, 0, 0, 858, NULL, 26),
(2076, 0, 0, 0, 'Sugar Street 4d', 750, 7, 0, 0, 0, 0, 24, NULL, 2),
(2077, 0, 0, 0, 'Sugar Street 4c', 650, 7, 0, 0, 0, 0, 24, NULL, 1),
(2078, 0, 0, 0, 'Sugar Street 4b', 950, 7, 0, 0, 0, 0, 36, NULL, 2),
(2079, 0, 0, 0, 'Sugar Street 4a', 950, 7, 0, 0, 0, 0, 30, NULL, 2),
(2080, 0, 0, 0, 'Trader\'s Point 1', 2200, 7, 0, 0, 0, 0, 77, NULL, 2),
(2081, 0, 0, 0, 'Mountain Hideout', 15550, 7, 0, 0, 0, 0, 486, NULL, 17),
(2082, 0, 0, 0, 'Dark Mansion', 17845, 2, 0, 0, 0, 0, 575, NULL, 17),
(2083, 0, 0, 0, 'Halls of the Adventurers', 15380, 2, 0, 0, 0, 0, 518, NULL, 18),
(2084, 0, 0, 0, 'Castle of Greenshore', 18860, 2, 0, 0, 0, 0, 600, NULL, 12),
(2085, 0, 0, 0, 'Greenshore Clanhall', 10800, 2, 0, 0, 0, 0, 312, NULL, 10),
(2086, 0, 0, 0, 'Greenshore Village 1', 2420, 2, 0, 0, 0, 0, 64, NULL, 3),
(2087, 0, 0, 0, 'Greenshore Village, Shop', 1800, 2, 0, 0, 0, 0, 56, NULL, 1),
(2088, 0, 0, 0, 'Greenshore Village, Villa', 8700, 2, 0, 0, 0, 0, 263, NULL, 4),
(2089, 0, 0, 0, 'Greenshore Village 2', 780, 2, 0, 0, 0, 0, 30, NULL, 1),
(2090, 0, 0, 0, 'Greenshore Village 3', 780, 2, 0, 0, 0, 0, 25, NULL, 1),
(2091, 0, 0, 0, 'Greenshore Village 5', 780, 2, 0, 0, 0, 0, 30, NULL, 1),
(2092, 0, 0, 0, 'Greenshore Village 4', 780, 2, 0, 0, 0, 0, 25, NULL, 1),
(2093, 0, 0, 0, 'Greenshore Village 6', 4360, 2, 0, 0, 0, 0, 118, NULL, 2),
(2094, 0, 0, 0, 'Greenshore Village 7', 1260, 2, 0, 0, 0, 0, 42, NULL, 1),
(2095, 0, 0, 0, 'The Tibianic', 34500, 2, 0, 0, 0, 0, 862, NULL, 22),
(2097, 0, 0, 0, 'Fibula Village 5', 1790, 2, 0, 0, 0, 0, 42, NULL, 2),
(2098, 0, 0, 0, 'Fibula Village 4', 1790, 2, 0, 0, 0, 0, 42, NULL, 2),
(2099, 0, 0, 0, 'Fibula Village, Tower Flat', 5105, 2, 0, 0, 0, 0, 161, NULL, 2),
(2100, 0, 0, 0, 'Fibula Village 1', 845, 2, 0, 0, 0, 0, 30, NULL, 1),
(2101, 0, 0, 0, 'Fibula Village 2', 845, 2, 0, 0, 0, 0, 30, NULL, 1),
(2102, 0, 0, 0, 'Fibula Village 3', 3810, 2, 0, 0, 0, 0, 110, NULL, 4),
(2103, 0, 0, 0, 'Mercenary Tower', 41955, 2, 0, 0, 0, 0, 996, NULL, 26),
(2104, 0, 0, 0, 'Guildhall of the Red Rose', 27725, 2, 0, 0, 0, 0, 571, NULL, 15),
(2105, 0, 0, 0, 'Fibula Village, Bar', 5235, 2, 0, 0, 0, 0, 122, NULL, 2),
(2106, 0, 0, 0, 'Fibula Village, Villa', 11490, 2, 0, 0, 0, 0, 402, NULL, 5),
(2107, 0, 0, 0, 'Fibula Clanhall', 11430, 2, 0, 0, 0, 0, 290, NULL, 10),
(2108, 0, 0, 0, 'Spiritkeep', 19210, 2, 0, 0, 0, 0, 783, NULL, 23),
(2109, 0, 0, 0, 'Snake Tower', 29720, 2, 0, 0, 0, 0, 1064, NULL, 21),
(2110, 0, 0, 0, 'Bloodhall', 15270, 2, 0, 0, 0, 0, 569, NULL, 15),
(2111, 0, 0, 0, 'Senja Clanhall', 10575, 4, 0, 0, 0, 0, 396, NULL, 9),
(2112, 0, 0, 0, 'Senja Village 2', 765, 4, 0, 0, 0, 0, 36, NULL, 1),
(2113, 0, 0, 0, 'Senja Village 1a', 765, 4, 0, 0, 0, 0, 36, NULL, 1),
(2114, 0, 0, 0, 'Senja Village 1b', 1630, 4, 0, 0, 0, 0, 66, NULL, 2),
(2115, 0, 0, 0, 'Senja Village 4', 765, 4, 0, 0, 0, 0, 30, NULL, 1),
(2116, 0, 0, 0, 'Senja Village 3', 1765, 4, 0, 0, 0, 0, 72, NULL, 2),
(2117, 0, 0, 0, 'Senja Village 6b', 765, 4, 0, 0, 0, 0, 30, NULL, 1),
(2118, 0, 0, 0, 'Senja Village 6a', 765, 4, 0, 0, 0, 0, 30, NULL, 1),
(2119, 0, 0, 0, 'Senja Village 5', 1225, 4, 0, 0, 0, 0, 48, NULL, 2),
(2120, 0, 0, 0, 'Senja Village 10', 1485, 4, 0, 0, 0, 0, 72, NULL, 1),
(2121, 0, 0, 0, 'Senja Village 11', 2620, 4, 0, 0, 0, 0, 96, NULL, 2),
(2122, 0, 0, 0, 'Senja Village 9', 2575, 4, 0, 0, 0, 0, 103, NULL, 2),
(2123, 0, 0, 0, 'Senja Village 8', 1675, 4, 0, 0, 0, 0, 57, NULL, 2),
(2124, 0, 0, 0, 'Senja Village 7', 865, 4, 0, 0, 0, 0, 37, NULL, 2),
(2125, 0, 0, 0, 'Rosebud C', 1340, 4, 0, 0, 0, 0, 70, NULL, 0),
(2127, 0, 0, 0, 'Rosebud A', 1000, 4, 0, 0, 0, 0, 60, NULL, 1),
(2128, 0, 0, 0, 'Rosebud B', 1000, 4, 0, 0, 0, 0, 60, NULL, 1),
(2129, 0, 0, 0, 'Nordic Stronghold', 18400, 4, 0, 0, 0, 0, 718, NULL, 21),
(2130, 0, 0, 0, 'Northport Village 2', 1475, 4, 0, 0, 0, 0, 40, NULL, 2),
(2131, 0, 0, 0, 'Northport Village 1', 1475, 4, 0, 0, 0, 0, 48, NULL, 2),
(2132, 0, 0, 0, 'Northport Village 3', 5435, 4, 0, 0, 0, 0, 178, NULL, 2),
(2133, 0, 0, 0, 'Northport Village 4', 2630, 4, 0, 0, 0, 0, 81, NULL, 2),
(2134, 0, 0, 0, 'Northport Village 5', 1805, 4, 0, 0, 0, 0, 56, NULL, 2),
(2135, 0, 0, 0, 'Northport Village 6', 2135, 4, 0, 0, 0, 0, 64, NULL, 2),
(2136, 0, 0, 0, 'Seawatch', 25010, 4, 0, 0, 0, 0, 749, NULL, 19),
(2137, 0, 0, 0, 'Northport Clanhall', 9810, 4, 0, 0, 0, 0, 292, NULL, 10),
(2138, 0, 0, 0, 'Druids Retreat D', 1180, 4, 0, 0, 0, 0, 54, NULL, 2),
(2139, 0, 0, 0, 'Druids Retreat A', 1340, 4, 0, 0, 0, 0, 60, NULL, 2),
(2140, 0, 0, 0, 'Druids Retreat C', 980, 4, 0, 0, 0, 0, 45, NULL, 2),
(2141, 0, 0, 0, 'Druids Retreat B', 980, 4, 0, 0, 0, 0, 55, NULL, 2),
(2142, 0, 0, 0, 'Theater Avenue 14 (Shop)', 2115, 4, 0, 0, 0, 0, 83, NULL, 1),
(2143, 0, 0, 0, 'Theater Avenue 12', 955, 4, 0, 0, 0, 0, 28, NULL, 2),
(2144, 0, 0, 0, 'Theater Avenue 10', 1090, 4, 0, 0, 0, 0, 45, NULL, 2),
(2145, 0, 0, 0, 'Theater Avenue 11c', 585, 4, 0, 0, 0, 0, 24, NULL, 1),
(2146, 0, 0, 0, 'Theater Avenue 11b', 585, 4, 0, 0, 0, 0, 24, NULL, 1),
(2147, 0, 0, 0, 'Theater Avenue 11a', 1405, 4, 0, 0, 0, 0, 54, NULL, 2),
(2148, 0, 0, 0, 'Magician\'s Alley 1', 1050, 4, 0, 0, 0, 0, 35, NULL, 2),
(2149, 0, 0, 0, 'Magician\'s Alley 1a', 700, 4, 0, 0, 0, 0, 29, NULL, 2),
(2150, 0, 0, 0, 'Magician\'s Alley 1d', 450, 4, 0, 0, 0, 0, 24, NULL, 1),
(2151, 0, 0, 0, 'Magician\'s Alley 1b', 750, 4, 0, 0, 0, 0, 24, NULL, 2),
(2152, 0, 0, 0, 'Magician\'s Alley 1c', 500, 4, 0, 0, 0, 0, 20, NULL, 1),
(2153, 0, 0, 0, 'Magician\'s Alley 5a', 350, 4, 0, 0, 0, 0, 14, NULL, 1),
(2154, 0, 0, 0, 'Magician\'s Alley 5b', 500, 4, 0, 0, 0, 0, 25, NULL, 1),
(2155, 0, 0, 0, 'Magician\'s Alley 5d', 500, 4, 0, 0, 0, 0, 20, NULL, 1),
(2156, 0, 0, 0, 'Magician\'s Alley 5e', 500, 4, 0, 0, 0, 0, 25, NULL, 1),
(2157, 0, 0, 0, 'Magician\'s Alley 5c', 1150, 4, 0, 0, 0, 0, 35, NULL, 2),
(2158, 0, 0, 0, 'Magician\'s Alley 5f', 1150, 4, 0, 0, 0, 0, 42, NULL, 2),
(2159, 0, 0, 0, 'Carlin Clanhall', 10750, 4, 0, 0, 0, 0, 364, NULL, 10),
(2160, 0, 0, 0, 'Magician\'s Alley 4', 2750, 4, 0, 0, 0, 0, 96, NULL, 4),
(2161, 0, 0, 0, 'Lonely Sea Side Hostel', 10540, 4, 0, 0, 0, 0, 454, NULL, 8),
(2162, 0, 0, 0, 'Suntower', 10080, 4, 0, 0, 0, 0, 450, NULL, 7),
(2163, 0, 0, 0, 'Harbour Lane 3', 3560, 4, 0, 0, 0, 0, 145, NULL, 3),
(2164, 0, 0, 0, 'Harbour Flats, Flat 11', 520, 4, 0, 0, 0, 0, 24, NULL, 1),
(2165, 0, 0, 0, 'Harbour Flats, Flat 13', 520, 4, 0, 0, 0, 0, 24, NULL, 1),
(2166, 0, 0, 0, 'Harbour Flats, Flat 15', 360, 4, 0, 0, 0, 0, 18, NULL, 1),
(2167, 0, 0, 0, 'Harbour Flats, Flat 17', 360, 4, 0, 0, 0, 0, 24, NULL, 1),
(2168, 0, 0, 0, 'Harbour Flats, Flat 12', 400, 4, 0, 0, 0, 0, 20, NULL, 1),
(2169, 0, 0, 0, 'Harbour Flats, Flat 14', 400, 4, 0, 0, 0, 0, 20, NULL, 1),
(2170, 0, 0, 0, 'Harbour Flats, Flat 16', 400, 4, 0, 0, 0, 0, 20, NULL, 1),
(2171, 0, 0, 0, 'Harbour Flats, Flat 18', 400, 4, 0, 0, 0, 0, 25, NULL, 1),
(2172, 0, 0, 0, 'Harbour Flats, Flat 21', 860, 4, 0, 0, 0, 0, 35, NULL, 2),
(2173, 0, 0, 0, 'Harbour Flats, Flat 22', 980, 4, 0, 0, 0, 0, 45, NULL, 2),
(2174, 0, 0, 0, 'Harbour Flats, Flat 23', 400, 4, 0, 0, 0, 0, 25, NULL, 1),
(2175, 0, 0, 0, 'Harbour Lane 2a (Shop)', 680, 4, 0, 0, 0, 0, 32, NULL, 0),
(2176, 0, 0, 0, 'Harbour Lane 2b (Shop)', 680, 4, 0, 0, 0, 0, 40, NULL, 0),
(2177, 0, 0, 0, 'Harbour Lane 1 (Shop)', 1040, 4, 0, 0, 0, 0, 54, NULL, 0),
(2178, 0, 0, 0, 'Theater Avenue 6e', 820, 4, 0, 0, 0, 0, 31, NULL, 2),
(2179, 0, 0, 0, 'Theater Avenue 6c', 225, 4, 0, 0, 0, 0, 12, NULL, 1),
(2180, 0, 0, 0, 'Theater Avenue 6a', 820, 4, 0, 0, 0, 0, 35, NULL, 2),
(2181, 0, 0, 0, 'Theater Avenue 6f', 820, 4, 0, 0, 0, 0, 31, NULL, 2),
(2182, 0, 0, 0, 'Theater Avenue 6d', 225, 4, 0, 0, 0, 0, 12, NULL, 1),
(2183, 0, 0, 0, 'Theater Avenue 6b', 820, 4, 0, 0, 0, 0, 35, NULL, 2),
(2184, 0, 0, 0, 'East Lane 1a', 2260, 4, 0, 0, 0, 0, 95, NULL, 2),
(2185, 0, 0, 0, 'East Lane 1b', 1700, 4, 0, 0, 0, 0, 83, NULL, 2),
(2186, 0, 0, 0, 'East Lane 2', 3900, 4, 0, 0, 0, 0, 172, NULL, 2),
(2191, 0, 0, 0, 'Northern Street 5', 1980, 4, 0, 0, 0, 0, 94, NULL, 2),
(2192, 0, 0, 0, 'Northern Street 7', 1700, 4, 0, 0, 0, 0, 83, NULL, 2),
(2193, 0, 0, 0, 'Northern Street 3a', 740, 4, 0, 0, 0, 0, 31, NULL, 2),
(2194, 0, 0, 0, 'Northern Street 3b', 780, 4, 0, 0, 0, 0, 36, NULL, 2),
(2195, 0, 0, 0, 'Northern Street 1c', 740, 4, 0, 0, 0, 0, 31, NULL, 2),
(2196, 0, 0, 0, 'Northern Street 1b', 740, 4, 0, 0, 0, 0, 37, NULL, 2),
(2197, 0, 0, 0, 'Northern Street 1a', 940, 4, 0, 0, 0, 0, 41, NULL, 2),
(2198, 0, 0, 0, 'Theater Avenue 7, Flat 06', 315, 4, 0, 0, 0, 0, 20, NULL, 1),
(2199, 0, 0, 0, 'Theater Avenue 7, Flat 01', 315, 4, 0, 0, 0, 0, 15, NULL, 1),
(2200, 0, 0, 0, 'Theater Avenue 7, Flat 05', 405, 4, 0, 0, 0, 0, 20, NULL, 1),
(2201, 0, 0, 0, 'Theater Avenue 7, Flat 02', 405, 4, 0, 0, 0, 0, 20, NULL, 1),
(2202, 0, 0, 0, 'Theater Avenue 7, Flat 04', 495, 4, 0, 0, 0, 0, 20, NULL, 1),
(2203, 0, 0, 0, 'Theater Avenue 7, Flat 03', 405, 4, 0, 0, 0, 0, 19, NULL, 1),
(2204, 0, 0, 0, 'Theater Avenue 7, Flat 14', 495, 4, 0, 0, 0, 0, 20, NULL, 1),
(2205, 0, 0, 0, 'Theater Avenue 7, Flat 13', 405, 4, 0, 0, 0, 0, 17, NULL, 1),
(2206, 0, 0, 0, 'Theater Avenue 7, Flat 15', 405, 4, 0, 0, 0, 0, 19, NULL, 1),
(2207, 0, 0, 0, 'Theater Avenue 7, Flat 16', 405, 4, 0, 0, 0, 0, 20, NULL, 1),
(2208, 0, 0, 0, 'Theater Avenue 7, Flat 11', 495, 4, 0, 0, 0, 0, 23, NULL, 1),
(2209, 0, 0, 0, 'Theater Avenue 7, Flat 12', 405, 4, 0, 0, 0, 0, 15, NULL, 1),
(2210, 0, 0, 0, 'Theater Avenue 8a', 1270, 4, 0, 0, 0, 0, 50, NULL, 2),
(2211, 0, 0, 0, 'Theater Avenue 8b', 1370, 4, 0, 0, 0, 0, 49, NULL, 3),
(2212, 0, 0, 0, 'Central Plaza 3', 600, 4, 0, 0, 0, 0, 20, NULL, 0),
(2213, 0, 0, 0, 'Central Plaza 2', 600, 4, 0, 0, 0, 0, 20, NULL, 0),
(2214, 0, 0, 0, 'Central Plaza 1', 600, 4, 0, 0, 0, 0, 24, NULL, 0),
(2215, 0, 0, 0, 'Park Lane 1a', 1220, 4, 0, 0, 0, 0, 53, NULL, 2),
(2216, 0, 0, 0, 'Park Lane 3a', 1220, 4, 0, 0, 0, 0, 48, NULL, 2),
(2217, 0, 0, 0, 'Park Lane 1b', 1380, 4, 0, 0, 0, 0, 64, NULL, 2),
(2218, 0, 0, 0, 'Park Lane 3b', 1100, 4, 0, 0, 0, 0, 48, NULL, 2),
(2219, 0, 0, 0, 'Park Lane 4', 980, 4, 0, 0, 0, 0, 42, NULL, 2),
(2220, 0, 0, 0, 'Park Lane 2', 980, 4, 0, 0, 0, 0, 42, NULL, 2),
(2221, 0, 0, 0, 'Magician\'s Alley 8', 1400, 4, 0, 0, 0, 0, 42, NULL, 2),
(2222, 0, 0, 0, 'Moonkeep', 13020, 4, 0, 0, 0, 0, 522, NULL, 16),
(2225, 0, 0, 0, 'Castle, Basement, Flat 01', 585, 11, 0, 0, 0, 0, 30, NULL, 1),
(2226, 0, 0, 0, 'Castle, Basement, Flat 02', 585, 11, 0, 0, 0, 0, 20, NULL, 1),
(2227, 0, 0, 0, 'Castle, Basement, Flat 03', 585, 11, 0, 0, 0, 0, 20, NULL, 1),
(2228, 0, 0, 0, 'Castle, Basement, Flat 04', 585, 11, 0, 0, 0, 0, 20, NULL, 1),
(2229, 0, 0, 0, 'Castle, Basement, Flat 07', 585, 11, 0, 0, 0, 0, 20, NULL, 1),
(2230, 0, 0, 0, 'Castle, Basement, Flat 08', 585, 11, 0, 0, 0, 0, 20, NULL, 1),
(2231, 0, 0, 0, 'Castle, Basement, Flat 09', 585, 11, 0, 0, 0, 0, 24, NULL, 1),
(2232, 0, 0, 0, 'Castle, Basement, Flat 06', 585, 11, 0, 0, 0, 0, 24, NULL, 1),
(2233, 0, 0, 0, 'Castle, Basement, Flat 05', 585, 11, 0, 0, 0, 0, 24, NULL, 1),
(2234, 0, 0, 0, 'Castle Shop 1', 1890, 11, 0, 0, 0, 0, 67, NULL, 1),
(2235, 0, 0, 0, 'Castle Shop 2', 1890, 11, 0, 0, 0, 0, 70, NULL, 1),
(2236, 0, 0, 0, 'Castle Shop 3', 1890, 11, 0, 0, 0, 0, 67, NULL, 1),
(2237, 0, 0, 0, 'Castle, 4th Floor, Flat 09', 720, 11, 0, 0, 0, 0, 28, NULL, 1),
(2238, 0, 0, 0, 'Castle, 4th Floor, Flat 08', 945, 11, 0, 0, 0, 0, 42, NULL, 1),
(2239, 0, 0, 0, 'Castle, 4th Floor, Flat 06', 945, 11, 0, 0, 0, 0, 36, NULL, 1),
(2240, 0, 0, 0, 'Castle, 4th Floor, Flat 07', 720, 11, 0, 0, 0, 0, 30, NULL, 1),
(2241, 0, 0, 0, 'Castle, 4th Floor, Flat 05', 765, 11, 0, 0, 0, 0, 30, NULL, 1),
(2242, 0, 0, 0, 'Castle, 4th Floor, Flat 04', 585, 11, 0, 0, 0, 0, 25, NULL, 1),
(2243, 0, 0, 0, 'Castle, 4th Floor, Flat 03', 585, 11, 0, 0, 0, 0, 30, NULL, 1),
(2244, 0, 0, 0, 'Castle, 4th Floor, Flat 02', 765, 11, 0, 0, 0, 0, 30, NULL, 1),
(2245, 0, 0, 0, 'Castle, 4th Floor, Flat 01', 585, 11, 0, 0, 0, 0, 30, NULL, 1),
(2246, 0, 0, 0, 'Castle, 3rd Floor, Flat 01', 585, 11, 0, 0, 0, 0, 30, NULL, 1),
(2247, 0, 0, 0, 'Castle, 3rd Floor, Flat 02', 765, 11, 0, 0, 0, 0, 30, NULL, 1),
(2248, 0, 0, 0, 'Castle, 3rd Floor, Flat 03', 585, 11, 0, 0, 0, 0, 25, NULL, 1),
(2249, 0, 0, 0, 'Castle, 3rd Floor, Flat 05', 765, 11, 0, 0, 0, 0, 30, NULL, 1),
(2250, 0, 0, 0, 'Castle, 3rd Floor, Flat 04', 585, 11, 0, 0, 0, 0, 25, NULL, 1),
(2251, 0, 0, 0, 'Castle, 3rd Floor, Flat 06', 1045, 11, 0, 0, 0, 0, 36, NULL, 2),
(2252, 0, 0, 0, 'Castle, 3rd Floor, Flat 07', 720, 11, 0, 0, 0, 0, 30, NULL, 1),
(2253, 0, 0, 0, 'Castle Street 1', 2900, 11, 0, 0, 0, 0, 112, NULL, 3),
(2254, 0, 0, 0, 'Castle Street 2', 1495, 11, 0, 0, 0, 0, 56, NULL, 2),
(2255, 0, 0, 0, 'Castle Street 3', 1765, 11, 0, 0, 0, 0, 56, NULL, 2),
(2256, 0, 0, 0, 'Castle Street 4', 1765, 11, 0, 0, 0, 0, 64, NULL, 2),
(2257, 0, 0, 0, 'Castle Street 5', 1765, 11, 0, 0, 0, 0, 61, NULL, 2),
(2258, 0, 0, 0, 'Edron Flats, Basement Flat 2', 1540, 11, 0, 0, 0, 0, 48, NULL, 2),
(2259, 0, 0, 0, 'Edron Flats, Basement Flat 1', 1540, 11, 0, 0, 0, 0, 48, NULL, 2),
(2260, 0, 0, 0, 'Edron Flats, Flat 01', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2261, 0, 0, 0, 'Edron Flats, Flat 02', 860, 11, 0, 0, 0, 0, 28, NULL, 2),
(2262, 0, 0, 0, 'Edron Flats, Flat 03', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2263, 0, 0, 0, 'Edron Flats, Flat 04', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2264, 0, 0, 0, 'Edron Flats, Flat 06', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2265, 0, 0, 0, 'Edron Flats, Flat 05', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2266, 0, 0, 0, 'Edron Flats, Flat 07', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2267, 0, 0, 0, 'Edron Flats, Flat 08', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2268, 0, 0, 0, 'Edron Flats, Flat 11', 400, 11, 0, 0, 0, 0, 25, NULL, 1),
(2269, 0, 0, 0, 'Edron Flats, Flat 12', 400, 11, 0, 0, 0, 0, 25, NULL, 1),
(2270, 0, 0, 0, 'Edron Flats, Flat 14', 400, 11, 0, 0, 0, 0, 25, NULL, 1),
(2271, 0, 0, 0, 'Edron Flats, Flat 13', 400, 11, 0, 0, 0, 0, 25, NULL, 1),
(2272, 0, 0, 0, 'Edron Flats, Flat 16', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2273, 0, 0, 0, 'Edron Flats, Flat 15', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2274, 0, 0, 0, 'Edron Flats, Flat 18', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2275, 0, 0, 0, 'Edron Flats, Flat 17', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2276, 0, 0, 0, 'Edron Flats, Flat 22', 400, 11, 0, 0, 0, 0, 25, NULL, 1),
(2277, 0, 0, 0, 'Edron Flats, Flat 21', 860, 11, 0, 0, 0, 0, 40, NULL, 2),
(2278, 0, 0, 0, 'Edron Flats, Flat 24', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2279, 0, 0, 0, 'Edron Flats, Flat 23', 400, 11, 0, 0, 0, 0, 25, NULL, 1),
(2280, 0, 0, 0, 'Edron Flats, Flat 26', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2281, 0, 0, 0, 'Edron Flats, Flat 27', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2282, 0, 0, 0, 'Edron Flats, Flat 28', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2283, 0, 0, 0, 'Edron Flats, Flat 25', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2284, 0, 0, 0, 'Central Circle 1', 3020, 11, 0, 0, 0, 0, 119, NULL, 2),
(2285, 0, 0, 0, 'Central Circle 2', 3300, 11, 0, 0, 0, 0, 109, NULL, 2),
(2286, 0, 0, 0, 'Central Circle 3', 4160, 11, 0, 0, 0, 0, 147, NULL, 5),
(2287, 0, 0, 0, 'Central Circle 4', 4160, 11, 0, 0, 0, 0, 147, NULL, 5),
(2288, 0, 0, 0, 'Central Circle 5', 4160, 11, 0, 0, 0, 0, 161, NULL, 5),
(2289, 0, 0, 0, 'Central Circle 6 (Shop)', 3980, 11, 0, 0, 0, 0, 182, NULL, 2),
(2290, 0, 0, 0, 'Central Circle 7 (Shop)', 3980, 11, 0, 0, 0, 0, 161, NULL, 2),
(2291, 0, 0, 0, 'Central Circle 8 (Shop)', 3980, 11, 0, 0, 0, 0, 166, NULL, 2),
(2292, 0, 0, 0, 'Central Circle 9a', 940, 11, 0, 0, 0, 0, 42, NULL, 2),
(2293, 0, 0, 0, 'Central Circle 9b', 940, 11, 0, 0, 0, 0, 44, NULL, 2),
(2294, 0, 0, 0, 'Sky Lane, Guild 1', 21145, 11, 0, 0, 0, 0, 666, NULL, 23),
(2295, 0, 0, 0, 'Sky Lane, Guild 2', 19300, 11, 0, 0, 0, 0, 672, NULL, 14),
(2296, 0, 0, 0, 'Sky Lane, Guild 3', 17315, 11, 0, 0, 0, 0, 564, NULL, 18),
(2297, 0, 0, 0, 'Sky Lane, Sea Tower', 4775, 11, 0, 0, 0, 0, 196, NULL, 6),
(2298, 0, 0, 0, 'Wood Avenue 6a', 1450, 11, 0, 0, 0, 0, 56, NULL, 2),
(2299, 0, 0, 0, 'Wood Avenue 9a', 1540, 11, 0, 0, 0, 0, 56, NULL, 2),
(2300, 0, 0, 0, 'Wood Avenue 10a', 1540, 11, 0, 0, 0, 0, 64, NULL, 2),
(2301, 0, 0, 0, 'Wood Avenue 11', 7205, 11, 0, 0, 0, 0, 253, NULL, 6),
(2302, 0, 0, 0, 'Wood Avenue 8', 5960, 11, 0, 0, 0, 0, 198, NULL, 3),
(2303, 0, 0, 0, 'Wood Avenue 7', 5960, 11, 0, 0, 0, 0, 191, NULL, 3),
(2304, 0, 0, 0, 'Wood Avenue 6b', 1450, 11, 0, 0, 0, 0, 56, NULL, 2),
(2305, 0, 0, 0, 'Wood Avenue 9b', 1495, 11, 0, 0, 0, 0, 56, NULL, 2),
(2306, 0, 0, 0, 'Wood Avenue 10b', 1595, 11, 0, 0, 0, 0, 64, NULL, 3),
(2307, 0, 0, 0, 'Wood Avenue 5', 1765, 11, 0, 0, 0, 0, 64, NULL, 2),
(2308, 0, 0, 0, 'Wood Avenue 4a', 1495, 11, 0, 0, 0, 0, 56, NULL, 2),
(2309, 0, 0, 0, 'Wood Avenue 4b', 1495, 11, 0, 0, 0, 0, 56, NULL, 2),
(2310, 0, 0, 0, 'Wood Avenue 4c', 1765, 11, 0, 0, 0, 0, 56, NULL, 2),
(2311, 0, 0, 0, 'Wood Avenue 4', 1765, 11, 0, 0, 0, 0, 64, NULL, 2),
(2312, 0, 0, 0, 'Wood Avenue 3', 1765, 11, 0, 0, 0, 0, 56, NULL, 2),
(2313, 0, 0, 0, 'Wood Avenue 2', 1765, 11, 0, 0, 0, 0, 49, NULL, 2),
(2314, 0, 0, 0, 'Wood Avenue 1', 1765, 11, 0, 0, 0, 0, 64, NULL, 2),
(2315, 0, 0, 0, 'Magic Academy, Guild', 12025, 11, 0, 0, 0, 0, 414, NULL, 14),
(2316, 0, 0, 0, 'Magic Academy, Flat 1', 1465, 11, 0, 0, 0, 0, 57, NULL, 3),
(2317, 0, 0, 0, 'Magic Academy, Flat 2', 1530, 11, 0, 0, 0, 0, 55, NULL, 2),
(2318, 0, 0, 0, 'Magic Academy, Flat 3', 1430, 11, 0, 0, 0, 0, 55, NULL, 1),
(2319, 0, 0, 0, 'Magic Academy, Flat 4', 1530, 11, 0, 0, 0, 0, 55, NULL, 2),
(2320, 0, 0, 0, 'Magic Academy, Flat 5', 1430, 11, 0, 0, 0, 0, 55, NULL, 1),
(2321, 0, 0, 0, 'Magic Academy, Shop', 1595, 11, 0, 0, 0, 0, 48, NULL, 1),
(2322, 0, 0, 0, 'Stonehome Village 1', 1780, 11, 0, 0, 0, 0, 74, NULL, 2),
(2323, 0, 0, 0, 'Stonehome Flats, Flat 05', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2324, 0, 0, 0, 'Stonehome Flats, Flat 04', 400, 11, 0, 0, 0, 0, 25, NULL, 1),
(2325, 0, 0, 0, 'Stonehome Flats, Flat 06', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2326, 0, 0, 0, 'Stonehome Flats, Flat 03', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2327, 0, 0, 0, 'Stonehome Flats, Flat 01', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2328, 0, 0, 0, 'Stonehome Flats, Flat 02', 740, 11, 0, 0, 0, 0, 30, NULL, 2),
(2329, 0, 0, 0, 'Stonehome Flats, Flat 11', 740, 11, 0, 0, 0, 0, 35, NULL, 2),
(2330, 0, 0, 0, 'Stonehome Flats, Flat 12', 740, 11, 0, 0, 0, 0, 35, NULL, 2),
(2331, 0, 0, 0, 'Stonehome Flats, Flat 13', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2332, 0, 0, 0, 'Stonehome Flats, Flat 14', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2333, 0, 0, 0, 'Stonehome Flats, Flat 16', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2334, 0, 0, 0, 'Stonehome Flats, Flat 15', 400, 11, 0, 0, 0, 0, 20, NULL, 1),
(2335, 0, 0, 0, 'Stonehome Village 2', 640, 11, 0, 0, 0, 0, 35, NULL, 1),
(2336, 0, 0, 0, 'Stonehome Village 3', 680, 11, 0, 0, 0, 0, 36, NULL, 1),
(2337, 0, 0, 0, 'Stonehome Village 4', 940, 11, 0, 0, 0, 0, 42, NULL, 2),
(2338, 0, 0, 0, 'Stonehome Village 6', 1300, 11, 0, 0, 0, 0, 55, NULL, 2),
(2339, 0, 0, 0, 'Stonehome Village 5', 1140, 11, 0, 0, 0, 0, 56, NULL, 2),
(2340, 0, 0, 0, 'Stonehome Village 7', 1140, 11, 0, 0, 0, 0, 49, NULL, 2),
(2341, 0, 0, 0, 'Stonehome Village 8', 680, 11, 0, 0, 0, 0, 36, NULL, 1),
(2342, 0, 0, 0, 'Stonehome Village 9', 680, 11, 0, 0, 0, 0, 36, NULL, 1),
(2343, 0, 0, 0, 'Stonehome Clanhall', 8580, 11, 0, 0, 0, 0, 345, NULL, 9),
(2344, 0, 0, 0, 'Cormaya 1', 1270, 11, 0, 0, 0, 0, 49, NULL, 2),
(2345, 0, 0, 0, 'Cormaya 2', 3710, 11, 0, 0, 0, 0, 145, NULL, 3),
(2346, 0, 0, 0, 'Cormaya Flats, Flat 01', 450, 11, 0, 0, 0, 0, 20, NULL, 1),
(2347, 0, 0, 0, 'Cormaya Flats, Flat 02', 450, 11, 0, 0, 0, 0, 20, NULL, 1),
(2348, 0, 0, 0, 'Cormaya Flats, Flat 03', 820, 11, 0, 0, 0, 0, 30, NULL, 2),
(2349, 0, 0, 0, 'Cormaya Flats, Flat 06', 450, 11, 0, 0, 0, 0, 20, NULL, 1),
(2350, 0, 0, 0, 'Cormaya Flats, Flat 05', 450, 11, 0, 0, 0, 0, 20, NULL, 1),
(2351, 0, 0, 0, 'Cormaya Flats, Flat 04', 820, 11, 0, 0, 0, 0, 30, NULL, 2),
(2352, 0, 0, 0, 'Cormaya Flats, Flat 13', 820, 11, 0, 0, 0, 0, 30, NULL, 2),
(2353, 0, 0, 0, 'Cormaya Flats, Flat 14', 820, 11, 0, 0, 0, 0, 35, NULL, 2),
(2354, 0, 0, 0, 'Cormaya Flats, Flat 15', 450, 11, 0, 0, 0, 0, 20, NULL, 1),
(2355, 0, 0, 0, 'Cormaya Flats, Flat 16', 450, 11, 0, 0, 0, 0, 20, NULL, 1),
(2356, 0, 0, 0, 'Cormaya Flats, Flat 11', 450, 11, 0, 0, 0, 0, 20, NULL, 1),
(2357, 0, 0, 0, 'Cormaya Flats, Flat 12', 450, 11, 0, 0, 0, 0, 20, NULL, 1),
(2358, 0, 0, 0, 'Cormaya 3', 2035, 11, 0, 0, 0, 0, 72, NULL, 2),
(2359, 0, 0, 0, 'Castle of the White Dragon', 25110, 11, 0, 0, 0, 0, 761, NULL, 19),
(2360, 0, 0, 0, 'Cormaya 4', 1720, 11, 0, 0, 0, 0, 63, NULL, 2),
(2361, 0, 0, 0, 'Cormaya 5', 4250, 11, 0, 0, 0, 0, 167, NULL, 3),
(2362, 0, 0, 0, 'Cormaya 6', 2395, 11, 0, 0, 0, 0, 84, NULL, 2),
(2363, 0, 0, 0, 'Cormaya 7', 2395, 11, 0, 0, 0, 0, 84, NULL, 2),
(2364, 0, 0, 0, 'Cormaya 8', 2710, 11, 0, 0, 0, 0, 113, NULL, 2),
(2365, 0, 0, 0, 'Cormaya 9b', 2620, 11, 0, 0, 0, 0, 88, NULL, 2),
(2366, 0, 0, 0, 'Cormaya 9a', 1225, 11, 0, 0, 0, 0, 48, NULL, 2),
(2367, 0, 0, 0, 'Cormaya 9c', 1225, 11, 0, 0, 0, 0, 48, NULL, 2),
(2368, 0, 0, 0, 'Cormaya 9d', 2620, 11, 0, 0, 0, 0, 88, NULL, 2),
(2369, 0, 0, 0, 'Cormaya 10', 3800, 11, 0, 0, 0, 0, 140, NULL, 3),
(2370, 0, 0, 0, 'Cormaya 11', 2035, 11, 0, 0, 0, 0, 72, NULL, 2),
(2371, 0, 0, 0, 'Demon Tower', 3340, 2, 0, 0, 0, 0, 127, NULL, 2),
(2372, 0, 0, 0, 'Nautic Observer', 6540, 4, 0, 0, 0, 0, 300, NULL, 4),
(2373, 0, 0, 0, 'Riverspring', 19450, 3, 0, 0, 0, 0, 565, NULL, 18),
(2374, 0, 0, 0, 'House of Recreation', 22540, 4, 0, 0, 0, 0, 702, NULL, 16),
(2375, 0, 0, 0, 'Valorous Venore', 14435, 1, 0, 0, 0, 0, 496, NULL, 9),
(2376, 0, 0, 0, 'Ab\'Dendriel Clanhall', 14850, 5, 0, 0, 0, 0, 405, NULL, 10),
(2377, 0, 0, 0, 'Castle of the Winds', 23885, 5, 0, 0, 0, 0, 842, NULL, 18),
(2378, 0, 0, 0, 'The Hideout', 20800, 5, 0, 0, 0, 0, 597, NULL, 20),
(2379, 0, 0, 0, 'Shadow Towers', 21800, 5, 0, 0, 0, 0, 750, NULL, 18),
(2380, 0, 0, 0, 'Hill Hideout', 13950, 3, 0, 0, 0, 0, 346, NULL, 15),
(2381, 0, 0, 0, 'Meriana Beach', 8230, 7, 0, 0, 0, 0, 184, NULL, 3),
(2382, 0, 0, 0, 'Darashia 8, Flat 01', 2485, 10, 0, 0, 0, 0, 80, NULL, 2),
(2383, 0, 0, 0, 'Darashia 8, Flat 02', 3385, 10, 0, 0, 0, 0, 114, NULL, 2),
(2384, 0, 0, 0, 'Darashia 8, Flat 03', 4700, 10, 0, 0, 0, 0, 171, NULL, 3),
(2385, 0, 0, 0, 'Darashia 8, Flat 04', 2845, 10, 0, 0, 0, 0, 90, NULL, 2),
(2386, 0, 0, 0, 'Darashia 8, Flat 05', 2665, 10, 0, 0, 0, 0, 85, NULL, 2),
(2387, 0, 0, 0, 'Darashia, Eastern Guildhall', 12660, 10, 0, 0, 0, 0, 444, NULL, 16),
(2388, 0, 0, 0, 'Theater Avenue 5a', 450, 4, 0, 0, 0, 0, 20, NULL, 1),
(2389, 0, 0, 0, 'Theater Avenue 5b', 450, 4, 0, 0, 0, 0, 19, NULL, 1),
(2390, 0, 0, 0, 'Theater Avenue 5c', 450, 4, 0, 0, 0, 0, 16, NULL, 1),
(2391, 0, 0, 0, 'Theater Avenue 5d', 450, 4, 0, 0, 0, 0, 16, NULL, 1),
(2392, 0, 0, 0, 'Outlaw Camp 1', 1660, 3, 0, 0, 0, 0, 52, NULL, 2),
(2393, 0, 0, 0, 'Outlaw Camp 2', 280, 3, 0, 0, 0, 0, 12, NULL, 1),
(2394, 0, 0, 0, 'Outlaw Camp 3', 740, 3, 0, 0, 0, 0, 27, NULL, 2),
(2395, 0, 0, 0, 'Outlaw Camp 4', 200, 3, 0, 0, 0, 0, 9, NULL, 1),
(2396, 0, 0, 0, 'Outlaw Camp 5', 200, 3, 0, 0, 0, 0, 9, NULL, 1),
(2397, 0, 0, 0, 'Outlaw Camp 6', 200, 3, 0, 0, 0, 0, 9, NULL, 1),
(2398, 0, 0, 0, 'Outlaw Camp 7', 780, 3, 0, 0, 0, 0, 27, NULL, 2),
(2399, 0, 0, 0, 'Outlaw Camp 8', 280, 3, 0, 0, 0, 0, 12, NULL, 1),
(2400, 0, 0, 0, 'Outlaw Camp 9', 200, 3, 0, 0, 0, 0, 9, NULL, 1),
(2401, 0, 0, 0, 'Outlaw Camp 10', 200, 3, 0, 0, 0, 0, 9, NULL, 1),
(2402, 0, 0, 0, 'Outlaw Camp 11', 200, 3, 0, 0, 0, 0, 9, NULL, 1),
(2404, 0, 0, 0, 'Outlaw Camp 12 (Shop)', 280, 3, 0, 0, 0, 0, 7, NULL, 0),
(2405, 0, 0, 0, 'Outlaw Camp 13 (Shop)', 280, 3, 0, 0, 0, 0, 7, NULL, 0),
(2406, 0, 0, 0, 'Outlaw Camp 14 (Shop)', 640, 3, 0, 0, 0, 0, 16, NULL, 0),
(2407, 0, 0, 0, 'Open-Air Theatre', 2700, 2, 0, 0, 0, 0, 60, NULL, 1),
(2408, 0, 0, 0, 'The Lair', 7625, 1, 0, 0, 0, 0, 165, NULL, 3),
(2409, 0, 0, 0, 'Upper Barracks 2', 210, 3, 0, 0, 0, 0, 13, NULL, 1),
(2410, 0, 0, 0, 'Upper Barracks 3', 210, 3, 0, 0, 0, 0, 13, NULL, 1),
(2411, 0, 0, 0, 'Upper Barracks 4', 210, 3, 0, 0, 0, 0, 14, NULL, 1),
(2412, 0, 0, 0, 'Upper Barracks 5', 210, 3, 0, 0, 0, 0, 12, NULL, 1),
(2413, 0, 0, 0, 'Upper Barracks 6', 210, 3, 0, 0, 0, 0, 12, NULL, 1),
(2414, 0, 0, 0, 'Upper Barracks 7', 210, 3, 0, 0, 0, 0, 12, NULL, 1),
(2415, 0, 0, 0, 'Upper Barracks 8', 210, 3, 0, 0, 0, 0, 13, NULL, 1),
(2416, 0, 0, 0, 'Upper Barracks 9', 210, 3, 0, 0, 0, 0, 13, NULL, 1),
(2417, 0, 0, 0, 'Upper Barracks 10', 210, 3, 0, 0, 0, 0, 13, NULL, 1),
(2418, 0, 0, 0, 'Upper Barracks 11', 210, 3, 0, 0, 0, 0, 14, NULL, 1),
(2419, 0, 0, 0, 'Upper Barracks 12', 210, 3, 0, 0, 0, 0, 12, NULL, 1),
(2420, 0, 0, 0, 'Low Waters Observatory', 17165, 9, 0, 0, 0, 0, 721, NULL, 5),
(2421, 0, 0, 0, 'Eastern House of Tranquility', 11120, 14, 0, 0, 0, 0, 356, NULL, 5),
(2422, 0, 0, 0, 'Mammoth House', 9300, 12, 0, 0, 0, 0, 218, NULL, 6),
(2427, 0, 0, 0, 'Lower Barracks 1', 300, 3, 0, 0, 0, 0, 17, NULL, 1),
(2428, 0, 0, 0, 'Lower Barracks 2', 300, 3, 0, 0, 0, 0, 16, NULL, 1),
(2429, 0, 0, 0, 'Lower Barracks 3', 300, 3, 0, 0, 0, 0, 17, NULL, 1),
(2430, 0, 0, 0, 'Lower Barracks 4', 300, 3, 0, 0, 0, 0, 16, NULL, 1),
(2431, 0, 0, 0, 'Lower Barracks 5', 300, 3, 0, 0, 0, 0, 17, NULL, 1),
(2432, 0, 0, 0, 'Lower Barracks 6', 300, 3, 0, 0, 0, 0, 15, NULL, 1),
(2433, 0, 0, 0, 'Lower Barracks 7', 300, 3, 0, 0, 0, 0, 17, NULL, 1),
(2434, 0, 0, 0, 'Lower Barracks 8', 300, 3, 0, 0, 0, 0, 16, NULL, 1),
(2435, 0, 0, 0, 'Lower Barracks 9', 300, 3, 0, 0, 0, 0, 17, NULL, 1),
(2436, 0, 0, 0, 'Lower Barracks 10', 300, 3, 0, 0, 0, 0, 16, NULL, 1),
(2437, 0, 0, 0, 'Lower Barracks 11', 300, 3, 0, 0, 0, 0, 17, NULL, 1),
(2438, 0, 0, 0, 'Lower Barracks 12', 300, 3, 0, 0, 0, 0, 16, NULL, 1),
(2439, 0, 0, 0, 'Lower Barracks 13', 300, 3, 0, 0, 0, 0, 17, NULL, 1),
(2440, 0, 0, 0, 'Lower Barracks 14', 300, 3, 0, 0, 0, 0, 16, NULL, 1),
(2441, 0, 0, 0, 'Lower Barracks 15', 300, 3, 0, 0, 0, 0, 17, NULL, 1),
(2442, 0, 0, 0, 'Lower Barracks 16', 300, 3, 0, 0, 0, 0, 16, NULL, 1),
(2443, 0, 0, 0, 'Lower Barracks 17', 300, 3, 0, 0, 0, 0, 17, NULL, 1),
(2444, 0, 0, 0, 'Lower Barracks 18', 300, 3, 0, 0, 0, 0, 16, NULL, 1),
(2445, 0, 0, 0, 'Lower Barracks 19', 300, 3, 0, 0, 0, 0, 17, NULL, 1),
(2446, 0, 0, 0, 'Lower Barracks 20', 300, 3, 0, 0, 0, 0, 16, NULL, 1),
(2447, 0, 0, 0, 'Lower Barracks 21', 300, 3, 0, 0, 0, 0, 17, NULL, 1),
(2448, 0, 0, 0, 'Lower Barracks 22', 300, 3, 0, 0, 0, 0, 16, NULL, 1),
(2449, 0, 0, 0, 'Lower Barracks 23', 300, 3, 0, 0, 0, 0, 17, NULL, 1),
(2450, 0, 0, 0, 'Lower Barracks 24', 300, 3, 0, 0, 0, 0, 16, NULL, 1),
(2451, 0, 0, 0, 'The Farms 4', 1530, 3, 0, 0, 0, 0, 36, NULL, 2),
(2452, 0, 0, 0, 'Tunnel Gardens 1', 2000, 3, 0, 0, 0, 0, 40, NULL, 3),
(2455, 0, 0, 0, 'Tunnel Gardens 2', 2000, 3, 0, 0, 0, 0, 39, NULL, 3),
(2456, 0, 0, 0, 'The Yeah Beach Project', 6525, 7, 0, 0, 0, 0, 183, NULL, 3),
(2460, 0, 0, 0, 'Hare\'s Den', 7500, 3, 0, 0, 0, 0, 233, NULL, 4),
(2461, 0, 0, 0, 'Lost Cavern', 14730, 3, 0, 0, 0, 0, 621, NULL, 7),
(2462, 0, 0, 0, 'Caveman Shelter', 3780, 14, 0, 0, 0, 0, 92, NULL, 4),
(2463, 0, 0, 0, 'Old Sanctuary of God King Qjell', 21940, 28, 0, 0, 0, 0, 854, NULL, 6),
(2464, 0, 0, 0, 'Wallside Lane 1', 7590, 33, 0, 0, 0, 0, 295, NULL, 4),
(2465, 0, 0, 0, 'Wallside Residence', 6680, 33, 0, 0, 0, 0, 223, NULL, 4),
(2466, 0, 0, 0, 'Wallside Lane 2', 8445, 33, 0, 0, 0, 0, 294, NULL, 4),
(2467, 0, 0, 0, 'Antimony Lane 3', 3665, 33, 0, 0, 0, 0, 126, NULL, 3),
(2468, 0, 0, 0, 'Antimony Lane 2', 4745, 33, 0, 0, 0, 0, 159, NULL, 3),
(2469, 0, 0, 0, 'Vanward Flats B', 7410, 33, 0, 0, 0, 0, 245, NULL, 4),
(2470, 0, 0, 0, 'Vanward Flats A', 7410, 33, 0, 0, 0, 0, 222, NULL, 4),
(2471, 0, 0, 0, 'Bronze Brothers Bastion', 35205, 33, 0, 0, 0, 0, 1181, NULL, 15),
(2472, 0, 0, 0, 'Antimony Lane 1', 7105, 33, 0, 0, 0, 0, 242, NULL, 5),
(2473, 0, 0, 0, 'Rathleton Hills Estate', 20685, 33, 0, 0, 0, 0, 646, NULL, 13),
(2474, 0, 0, 0, 'Rathleton Hills Residence', 7085, 33, 0, 0, 0, 0, 228, NULL, 3),
(2475, 0, 0, 0, 'Rathleton Plaza 1', 2890, 33, 0, 0, 0, 0, 95, NULL, 2),
(2476, 0, 0, 0, 'Rathleton Plaza 2', 2620, 33, 0, 0, 0, 0, 99, NULL, 2),
(2478, 0, 0, 0, 'Antimony Lane 4', 5150, 33, 0, 0, 0, 0, 176, NULL, 3),
(2480, 0, 0, 0, 'Old Heritage Estate', 12075, 33, 0, 0, 0, 0, 402, NULL, 7),
(2481, 0, 0, 0, 'Cistern Ave', 3745, 33, 0, 0, 0, 0, 173, NULL, 2),
(2482, 0, 0, 0, 'Rathleton Plaza 4', 5005, 33, 0, 0, 0, 0, 193, NULL, 2),
(2483, 0, 0, 0, 'Rathleton Plaza 3', 5735, 33, 0, 0, 0, 0, 193, NULL, 3),
(2488, 0, 0, 0, 'Thrarhor V e (Shop)', 3000, 9, 0, 0, 0, 0, 36, NULL, 1),
(2491, 0, 0, 0, 'Isle of Solitude House', 3000, 31, 0, 0, 0, 0, 529, NULL, 14),
(2492, 0, 0, 0, 'Marketplace 1', 400000, 63, 0, 0, 0, 0, 147, NULL, 1),
(2493, 0, 0, 0, 'Marketplace 2', 400000, 63, 0, 0, 0, 0, 166, NULL, 2),
(2495, 0, 0, 0, 'Quay 1', 200000, 63, 0, 0, 0, 0, 191, NULL, 4),
(2496, 0, 0, 0, 'Quay 2', 200000, 63, 0, 0, 0, 0, 148, NULL, 2),
(2497, 0, 0, 0, 'Wave Tower', 400000, 63, 0, 0, 0, 0, 358, NULL, 4),
(2498, 0, 0, 0, 'Halls of Sun and Sea', 1000000, 63, 0, 0, 0, 0, 611, NULL, 11),
(2500, 0, 0, 0, 'Holy Castle', 0, 65, 0, 0, 0, 0, 3065, NULL, 20);

-- --------------------------------------------------------

--
-- Estrutura para tabela `house_lists`
--

CREATE TABLE `house_lists` (
  `house_id` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `list` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ip_bans`
--

CREATE TABLE `ip_bans` (
  `ip` int(10) UNSIGNED NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `live_casts`
--

CREATE TABLE `live_casts` (
  `player_id` int(11) NOT NULL,
  `cast_name` varchar(255) NOT NULL,
  `password` tinyint(1) NOT NULL DEFAULT 0,
  `description` varchar(255) DEFAULT NULL,
  `spectators` smallint(5) DEFAULT 0,
  `version` int(10) DEFAULT 1220
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `market_history`
--

CREATE TABLE `market_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT 0,
  `itemtype` int(10) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `price` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `expires_at` bigint(20) UNSIGNED NOT NULL,
  `inserted` bigint(20) UNSIGNED NOT NULL,
  `state` tinyint(1) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `market_offers`
--

CREATE TABLE `market_offers` (
  `id` int(10) UNSIGNED NOT NULL,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(1) NOT NULL DEFAULT 0,
  `itemtype` int(10) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `created` bigint(20) UNSIGNED NOT NULL,
  `anonymous` tinyint(1) NOT NULL DEFAULT 0,
  `price` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `newsticker`
--

CREATE TABLE `newsticker` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` int(11) NOT NULL,
  `text` mediumtext NOT NULL,
  `icon` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pagseguro`
--

CREATE TABLE `pagseguro` (
  `date` datetime NOT NULL,
  `code` varchar(50) NOT NULL,
  `reference` varchar(200) NOT NULL,
  `type` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `lastEventDate` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pagseguro_transactions`
--

CREATE TABLE `pagseguro_transactions` (
  `transaction_code` varchar(36) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `payment_method` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `item_count` int(11) NOT NULL,
  `data` datetime NOT NULL,
  `payment_amount` float DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `paypal_transactions`
--

CREATE TABLE `paypal_transactions` (
  `id` int(11) NOT NULL,
  `payment_status` varchar(70) NOT NULL DEFAULT '',
  `date` datetime NOT NULL,
  `payer_email` varchar(255) NOT NULL DEFAULT '',
  `payer_id` varchar(255) NOT NULL DEFAULT '',
  `item_number1` varchar(255) NOT NULL DEFAULT '',
  `mc_gross` float NOT NULL,
  `mc_currency` varchar(5) NOT NULL DEFAULT '',
  `txn_id` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT 1,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 1,
  `vocation` int(11) NOT NULL DEFAULT 0,
  `health` int(11) NOT NULL DEFAULT 150,
  `healthmax` int(11) NOT NULL DEFAULT 150,
  `experience` bigint(20) NOT NULL DEFAULT 0,
  `exptoday` int(11) DEFAULT NULL,
  `lookbody` int(11) NOT NULL DEFAULT 0,
  `lookfeet` int(11) NOT NULL DEFAULT 0,
  `lookhead` int(11) NOT NULL DEFAULT 0,
  `looklegs` int(11) NOT NULL DEFAULT 0,
  `looktype` int(11) NOT NULL DEFAULT 136,
  `lookaddons` int(11) NOT NULL DEFAULT 0,
  `maglevel` int(11) NOT NULL DEFAULT 0,
  `mana` int(11) NOT NULL DEFAULT 0,
  `manamax` int(11) NOT NULL DEFAULT 0,
  `manaspent` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `soul` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `town_id` int(11) NOT NULL DEFAULT 0,
  `posx` int(11) NOT NULL DEFAULT 0,
  `posy` int(11) NOT NULL DEFAULT 0,
  `posz` int(11) NOT NULL DEFAULT 0,
  `conditions` blob NOT NULL,
  `cap` int(11) NOT NULL DEFAULT 0,
  `sex` int(11) NOT NULL DEFAULT 0,
  `lastlogin` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `lastip` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `save` tinyint(1) NOT NULL DEFAULT 1,
  `skull` tinyint(1) NOT NULL DEFAULT 0,
  `skulltime` bigint(20) NOT NULL DEFAULT 0,
  `lastlogout` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `blessings` tinyint(2) NOT NULL DEFAULT 0,
  `blessings1` tinyint(4) NOT NULL DEFAULT 0,
  `blessings2` tinyint(4) NOT NULL DEFAULT 0,
  `blessings3` tinyint(4) NOT NULL DEFAULT 0,
  `blessings4` tinyint(4) NOT NULL DEFAULT 0,
  `blessings5` tinyint(4) NOT NULL DEFAULT 0,
  `blessings6` tinyint(4) NOT NULL DEFAULT 0,
  `blessings7` tinyint(4) NOT NULL DEFAULT 0,
  `blessings8` tinyint(4) NOT NULL DEFAULT 0,
  `onlinetime` bigint(20) NOT NULL DEFAULT 0,
  `deletion` bigint(15) NOT NULL DEFAULT 0,
  `balance` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `bonusrerollcount` bigint(20) DEFAULT 0,
  `quick_loot_fallback` tinyint(1) DEFAULT 0,
  `offlinetraining_time` smallint(5) UNSIGNED NOT NULL DEFAULT 43200,
  `offlinetraining_skill` int(11) NOT NULL DEFAULT -1,
  `stamina` smallint(5) UNSIGNED NOT NULL DEFAULT 2520,
  `skill_fist` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_fist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_club` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_club_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_sword` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_sword_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_axe` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_axe_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_dist` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_dist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_shielding` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_shielding_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_fishing` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_fishing_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `description` varchar(255) NOT NULL DEFAULT '',
  `comment` text NOT NULL,
  `create_ip` bigint(20) NOT NULL DEFAULT 0,
  `create_date` bigint(20) NOT NULL DEFAULT 0,
  `hide_char` int(11) NOT NULL DEFAULT 0,
  `skill_critical_hit_chance` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skill_critical_hit_chance_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_critical_hit_damage` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skill_critical_hit_damage_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_life_leech_chance` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skill_life_leech_chance_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_life_leech_amount` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skill_life_leech_amount_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_mana_leech_chance` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skill_mana_leech_chance_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_mana_leech_amount` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `skill_mana_leech_amount_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_criticalhit_chance` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_criticalhit_damage` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_lifeleech_chance` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_lifeleech_amount` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_manaleech_chance` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_manaleech_amount` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `prey_stamina_1` int(11) DEFAULT NULL,
  `prey_stamina_2` int(11) DEFAULT NULL,
  `prey_stamina_3` int(11) DEFAULT NULL,
  `prey_column` smallint(6) NOT NULL DEFAULT 1,
  `xpboost_stamina` int(11) DEFAULT NULL,
  `xpboost_value` int(10) DEFAULT NULL,
  `marriage_status` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `hide_skills` int(11) DEFAULT NULL,
  `hide_set` int(11) DEFAULT NULL,
  `former` varchar(255) NOT NULL DEFAULT '-',
  `signature` varchar(255) NOT NULL DEFAULT '',
  `marriage_spouse` int(11) NOT NULL DEFAULT -1,
  `loyalty_ranking` tinyint(1) NOT NULL DEFAULT 0,
  `bonus_rerolls` bigint(21) NOT NULL DEFAULT 0,
  `critical` int(20) DEFAULT 0,
  `sbw_points` int(11) NOT NULL DEFAULT 0,
  `instantrewardtokens` int(11) UNSIGNED NOT NULL DEFAULT 0,
  `charmpoints` int(11) DEFAULT 0,
  `direction` tinyint(1) DEFAULT 0,
  `lookmount` int(11) DEFAULT 0,
  `version` int(11) DEFAULT 1000,
  `lootaction` tinyint(2) DEFAULT 0,
  `spells` blob DEFAULT NULL,
  `storages` mediumblob DEFAULT NULL,
  `items` longblob DEFAULT NULL,
  `depotitems` longblob DEFAULT NULL,
  `inboxitems` longblob DEFAULT NULL,
  `rewards` longblob DEFAULT NULL,
  `varcap` int(11) NOT NULL DEFAULT 0,
  `charmExpansion` tinyint(2) DEFAULT 0,
  `bestiarykills` longblob DEFAULT NULL,
  `charms` longblob DEFAULT NULL,
  `bestiaryTracker` longblob DEFAULT NULL,
  `autoloot` blob DEFAULT NULL,
  `lastday` bigint(22) DEFAULT 0,
  `bonus_reroll` int(11) NOT NULL DEFAULT 0,
  `lookmountbody` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `lookmountfeet` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `lookmounthead` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `lookmountlegs` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `lookfamiliarstype` int(11) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Despejando dados para a tabela `players`
--

INSERT INTO `players` (`id`, `name`, `group_id`, `account_id`, `level`, `vocation`, `health`, `healthmax`, `experience`, `exptoday`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `lookaddons`, `maglevel`, `mana`, `manamax`, `manaspent`, `soul`, `town_id`, `posx`, `posy`, `posz`, `conditions`, `cap`, `sex`, `lastlogin`, `lastip`, `save`, `skull`, `skulltime`, `lastlogout`, `blessings`, `blessings1`, `blessings2`, `blessings3`, `blessings4`, `blessings5`, `blessings6`, `blessings7`, `blessings8`, `onlinetime`, `deletion`, `balance`, `bonusrerollcount`, `quick_loot_fallback`, `offlinetraining_time`, `offlinetraining_skill`, `stamina`, `skill_fist`, `skill_fist_tries`, `skill_club`, `skill_club_tries`, `skill_sword`, `skill_sword_tries`, `skill_axe`, `skill_axe_tries`, `skill_dist`, `skill_dist_tries`, `skill_shielding`, `skill_shielding_tries`, `skill_fishing`, `skill_fishing_tries`, `deleted`, `description`, `comment`, `create_ip`, `create_date`, `hide_char`, `skill_critical_hit_chance`, `skill_critical_hit_chance_tries`, `skill_critical_hit_damage`, `skill_critical_hit_damage_tries`, `skill_life_leech_chance`, `skill_life_leech_chance_tries`, `skill_life_leech_amount`, `skill_life_leech_amount_tries`, `skill_mana_leech_chance`, `skill_mana_leech_chance_tries`, `skill_mana_leech_amount`, `skill_mana_leech_amount_tries`, `skill_criticalhit_chance`, `skill_criticalhit_damage`, `skill_lifeleech_chance`, `skill_lifeleech_amount`, `skill_manaleech_chance`, `skill_manaleech_amount`, `prey_stamina_1`, `prey_stamina_2`, `prey_stamina_3`, `prey_column`, `xpboost_stamina`, `xpboost_value`, `marriage_status`, `hide_skills`, `hide_set`, `former`, `signature`, `marriage_spouse`, `loyalty_ranking`, `bonus_rerolls`, `critical`, `sbw_points`, `instantrewardtokens`, `charmpoints`, `direction`, `lookmount`, `version`, `lootaction`, `spells`, `storages`, `items`, `depotitems`, `inboxitems`, `rewards`, `varcap`, `charmExpansion`, `bestiarykills`, `charms`, `bestiaryTracker`, `autoloot`, `lastday`, `bonus_reroll`, `lookmountbody`, `lookmountfeet`, `lookmounthead`, `lookmountlegs`, `lookfamiliarstype`) VALUES
(1, 'Rook Sample', 1, 1, 1, 0, 150, 150, 0, NULL, 106, 76, 78, 58, 136, 0, 0, 5, 5, 0, 0, 6, 32097, 32205, 7, '', 400, 0, 1594061826, 16777343, 1, 0, 0, 1594062801, 0, 0, 1, 1, 1, 1, 1, 0, 0, 2936, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 1, 0, 0, 0, NULL, NULL, '-', '', -1, 0, 0, 0, 0, 0, 0, 0, 0, 1230, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0, 0, 0, 0, 0, 0, 0),
(2, 'Sorcerer Sample', 1, 1, 8, 1, 185, 185, 4200, NULL, 44, 98, 15, 76, 128, 0, 0, 90, 90, 0, 100, 1, 0, 0, 0, '', 470, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, NULL, '-', '', -1, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0),
(3, 'Druid Sample', 1, 1, 8, 2, 185, 185, 4200, NULL, 44, 98, 15, 76, 128, 0, 0, 90, 90, 0, 100, 1, 0, 0, 0, '', 470, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, NULL, '-', '', -1, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0),
(4, 'Paladin Sample', 1, 1, 8, 3, 185, 185, 4200, NULL, 44, 98, 15, 76, 128, 0, 0, 90, 90, 0, 100, 1, 0, 0, 0, '', 470, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, NULL, '-', '', -1, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0),
(5, 'Knight Sample', 1, 1, 8, 4, 185, 185, 4200, NULL, 44, 98, 15, 76, 128, 0, 0, 90, 90, 0, 100, 1, 0, 0, 0, '', 470, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 1, NULL, NULL, 0, NULL, NULL, '-', '', -1, 0, 0, 0, 0, 0, 0, 0, 0, 1000, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, NULL, NULL, NULL, 0, 0, 0, 0, 0, 0, 0),
(6, 'God', 6, 1, 1, 0, 185, 185, 0, NULL, 106, 76, 78, 58, 136, 0, 0, 90, 90, 0, 100, 1, 95, 128, 7, 0x010020000002ffffffff03401f00001a001b0000000004e02e0000050a0000000670170000070a000000fe, 470, 0, 1744894824, 16777343, 1, 0, 0, 1744895043, 0, 0, 1, 1, 1, 1, 1, 0, 0, 219, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, 1, 0, 0, 0, NULL, NULL, '-', '', -1, 0, 0, 0, 0, 0, 0, 2, 0, 1100, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0x0000000000000000, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `players_online`
--

CREATE TABLE `players_online` (
  `player_id` int(11) NOT NULL
) ENGINE=MEMORY DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_binary_items`
--

CREATE TABLE `player_binary_items` (
  `player_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `items` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_deaths`
--

CREATE TABLE `player_deaths` (
  `player_id` int(11) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 1,
  `killed_by` varchar(255) NOT NULL,
  `is_player` tinyint(1) NOT NULL DEFAULT 1,
  `mostdamage_by` varchar(100) NOT NULL,
  `mostdamage_is_player` tinyint(1) NOT NULL DEFAULT 0,
  `unjustified` tinyint(1) NOT NULL DEFAULT 0,
  `mostdamage_unjustified` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_depotitems`
--

CREATE TABLE `player_depotitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'any given range eg 0-100 will be reserved for depot lockers and all > 100 will be then normal items inside depots',
  `pid` int(11) NOT NULL DEFAULT 0,
  `itemtype` int(11) NOT NULL DEFAULT 0,
  `count` int(11) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_former_names`
--

CREATE TABLE `player_former_names` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `former_name` varchar(35) NOT NULL,
  `date` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_hirelings`
--

CREATE TABLE `player_hirelings` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `active` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `sex` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `posx` int(11) NOT NULL DEFAULT 0,
  `posy` int(11) NOT NULL DEFAULT 0,
  `posz` int(11) NOT NULL DEFAULT 0,
  `lookbody` int(11) NOT NULL DEFAULT 0,
  `lookfeet` int(11) NOT NULL DEFAULT 0,
  `lookhead` int(11) NOT NULL DEFAULT 0,
  `looklegs` int(11) NOT NULL DEFAULT 0,
  `looktype` int(11) NOT NULL DEFAULT 136
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_inboxitems`
--

CREATE TABLE `player_inboxitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT 0,
  `itemtype` int(11) NOT NULL DEFAULT 0,
  `count` int(11) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_items`
--

CREATE TABLE `player_items` (
  `player_id` int(11) NOT NULL DEFAULT 0,
  `pid` int(11) NOT NULL DEFAULT 0,
  `sid` int(11) NOT NULL DEFAULT 0,
  `itemtype` int(11) NOT NULL DEFAULT 0,
  `count` int(11) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Despejando dados para a tabela `player_items`
--

INSERT INTO `player_items` (`player_id`, `pid`, `sid`, `itemtype`, `count`, `attributes`) VALUES
(6, 1, 101, 2461, 1, ''),
(6, 3, 102, 1987, 1, 0x2601),
(6, 4, 103, 2467, 1, ''),
(6, 6, 104, 2398, 1, ''),
(6, 7, 105, 2649, 1, ''),
(6, 11, 106, 26052, 1, ''),
(6, 102, 107, 2554, 1, ''),
(6, 102, 108, 2120, 1, '');

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_kills`
--

CREATE TABLE `player_kills` (
  `player_id` int(11) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `target` int(11) NOT NULL,
  `unavenged` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_misc`
--

CREATE TABLE `player_misc` (
  `player_id` int(11) NOT NULL,
  `info` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_namelocks`
--

CREATE TABLE `player_namelocks` (
  `player_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `namelocked_at` bigint(20) NOT NULL,
  `namelocked_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_prey`
--

CREATE TABLE `player_prey` (
  `player_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `mindex` smallint(6) NOT NULL,
  `mcolumn` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_preydata`
--

CREATE TABLE `player_preydata` (
  `player_id` int(11) NOT NULL,
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Despejando dados para a tabela `player_preydata`
--

INSERT INTO `player_preydata` (`player_id`, `data`) VALUES
(6, 0x000000000000000000030917004372617a65642053756d6d6572205265617267756172640c0043727970742057617264656e0f00446565706c696e6720547972616e7406004566726565740e00486964656f75732046756e6775731500496e737461626c65204272656163682042726f6f6407004c6164796275670f004e696768746d617265205363696f6e13005765616b656e6564204672617a7a6c656d617701000000000000000003090c004164756c7420476f616e6e610d0042726f6b656e2053686170657218004368617267656420456e6572677920456c656d656e74616c0700446972656d61770a004665766572736c6565700b00466c79696e6720426f6f6b12004c697a617264204c6567696f6e6e6169726510004d6f6f68275461682057617272696f720d0057617465722042756666616c6f0200000000000000000000);

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_preytimes`
--

CREATE TABLE `player_preytimes` (
  `player_id` int(11) NOT NULL,
  `bonus_type1` int(11) NOT NULL,
  `bonus_value1` int(11) NOT NULL,
  `bonus_name1` varchar(50) NOT NULL,
  `bonus_type2` int(11) NOT NULL,
  `bonus_value2` int(11) NOT NULL,
  `bonus_name2` varchar(50) NOT NULL,
  `bonus_type3` int(11) NOT NULL,
  `bonus_value3` int(11) NOT NULL,
  `bonus_name3` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_rewards`
--

CREATE TABLE `player_rewards` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT 0,
  `itemtype` int(11) NOT NULL DEFAULT 0,
  `count` int(11) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_spells`
--

CREATE TABLE `player_spells` (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `player_storage`
--

CREATE TABLE `player_storage` (
  `player_id` int(11) NOT NULL DEFAULT 0,
  `key` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `value` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Despejando dados para a tabela `player_storage`
--

INSERT INTO `player_storage` (`player_id`, `key`, `value`) VALUES
(6, 90, 1),
(6, 130, 2),
(6, 131, 5),
(6, 132, 3),
(6, 133, 3),
(6, 134, 3),
(6, 135, 2),
(6, 136, 1),
(6, 138, 1),
(6, 140, 4),
(6, 141, 3),
(6, 142, 9),
(6, 143, 10),
(6, 144, 3),
(6, 145, 3),
(6, 146, 3),
(6, 147, 3),
(6, 148, 3),
(6, 149, 3),
(6, 150, 3),
(6, 151, 3),
(6, 152, 5),
(6, 153, 1),
(6, 154, 3),
(6, 155, 3),
(6, 156, 3),
(6, 800, 1),
(6, 847, 1),
(6, 849, 1),
(6, 851, 1),
(6, 900, 30),
(6, 921, 30),
(6, 954, 1),
(6, 955, 2),
(6, 956, 2),
(6, 957, 2),
(6, 2086, 1),
(6, 6983, 1744895048),
(6, 7097, 1),
(6, 10132, 1),
(6, 10133, 1),
(6, 10134, 1),
(6, 10135, 1),
(6, 10136, 1),
(6, 10137, 1),
(6, 10167, 1),
(6, 12120, 1),
(6, 12121, 18),
(6, 12130, 24),
(6, 12131, 3),
(6, 12132, 6),
(6, 12133, 3),
(6, 12134, 2),
(6, 12135, 7),
(6, 12136, 3),
(6, 12137, 3),
(6, 12138, 2),
(6, 12139, 3),
(6, 12140, 1),
(6, 12152, 1),
(6, 12160, 18),
(6, 12161, 7),
(6, 12162, 3),
(6, 12163, 6),
(6, 12164, 3),
(6, 12165, 3),
(6, 12166, 3),
(6, 12167, 1),
(6, 12190, 8),
(6, 12191, 3),
(6, 12192, 3),
(6, 12193, 3),
(6, 12200, 1),
(6, 12201, 3),
(6, 12202, 5),
(6, 12203, 3),
(6, 12204, 2),
(6, 12205, 6),
(6, 12206, 8),
(6, 12207, 3),
(6, 12208, 4),
(6, 12209, 2),
(6, 12210, 2),
(6, 12211, 2),
(6, 12212, 6),
(6, 12240, 48),
(6, 12241, 6),
(6, 12242, 8),
(6, 12243, 6),
(6, 12244, 6),
(6, 12245, 8),
(6, 12246, 5),
(6, 12247, 5),
(6, 12248, 4),
(6, 12249, 2),
(6, 12250, 2),
(6, 12276, 1),
(6, 12350, 28),
(6, 12351, 3),
(6, 12352, 3),
(6, 12353, 3),
(6, 12354, 3),
(6, 12355, 3),
(6, 12356, 4),
(6, 12357, 6),
(6, 12358, 2),
(6, 12359, 2),
(6, 12700, 1),
(6, 12701, 3),
(6, 12702, 2),
(6, 12703, 1),
(6, 12704, 3),
(6, 12705, 5),
(6, 12706, 1),
(6, 12707, 1),
(6, 12710, 4),
(6, 12800, 8),
(6, 12801, 1),
(6, 12802, 1),
(6, 12803, 1),
(6, 12804, 1),
(6, 12805, 1),
(6, 12806, 1),
(6, 12807, 1),
(6, 12808, 1),
(6, 14000, 1),
(6, 14001, 0),
(6, 14002, 0),
(6, 14003, 0),
(6, 14004, 0),
(6, 17950, 1),
(6, 18001, 1),
(6, 18002, 1),
(6, 18003, 1),
(6, 18004, 1),
(6, 18005, 1),
(6, 18006, 1),
(6, 18007, 1),
(6, 22399, 1),
(6, 22400, 1),
(6, 22401, 1),
(6, 22420, 1),
(6, 22430, 1),
(6, 22450, 2),
(6, 22470, 2),
(6, 22490, 1),
(6, 23000, 1),
(6, 23100, 2),
(6, 23101, 8),
(6, 23115, 3),
(6, 23130, 6),
(6, 23170, 2),
(6, 23179, 1),
(6, 23185, 7),
(6, 23190, 1),
(6, 50095, 1),
(6, 50722, 0),
(6, 81705, 1),
(6, 300159, 1),
(6, 300169, 1),
(6, 300243, 1),
(6, 300248, 1),
(6, 10001001, 18874368),
(6, 10001002, 18939904),
(6, 10001003, 9895936),
(6, 10001004, 10158080),
(6, 10001005, 10092544),
(6, 10001006, 10354688),
(6, 10001007, 21954560),
(6, 10001008, 22020096),
(6, 10001009, 16449536),
(6, 10001010, 16515072),
(6, 98231521, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `prey_slots`
--

CREATE TABLE `prey_slots` (
  `player_id` int(11) NOT NULL,
  `num` smallint(2) NOT NULL,
  `state` smallint(2) NOT NULL DEFAULT 1,
  `unlocked` tinyint(1) NOT NULL DEFAULT 0,
  `current` varchar(40) NOT NULL DEFAULT '',
  `monster_list` varchar(360) NOT NULL,
  `free_reroll_in` int(11) NOT NULL DEFAULT 0,
  `time_left` smallint(5) NOT NULL DEFAULT 0,
  `next_use` int(11) NOT NULL DEFAULT 0,
  `bonus_type` smallint(3) NOT NULL,
  `bonus_value` smallint(3) NOT NULL DEFAULT 0,
  `bonus_grade` smallint(3) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `sellchar`
--

CREATE TABLE `sellchar` (
  `id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `vocation` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `status` varchar(40) NOT NULL,
  `oldid` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `sell_players`
--

CREATE TABLE `sell_players` (
  `player_id` int(11) NOT NULL,
  `account` int(11) NOT NULL,
  `create` bigint(20) NOT NULL,
  `createip` bigint(20) NOT NULL,
  `coin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `sell_players_history`
--

CREATE TABLE `sell_players_history` (
  `player_id` int(11) NOT NULL,
  `accountold` int(11) NOT NULL,
  `accountnew` int(11) NOT NULL,
  `create` bigint(20) NOT NULL,
  `createip` bigint(20) NOT NULL,
  `buytime` bigint(20) NOT NULL,
  `buyip` bigint(20) NOT NULL,
  `coin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `server_config`
--

CREATE TABLE `server_config` (
  `config` varchar(50) NOT NULL,
  `value` varchar(256) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Despejando dados para a tabela `server_config`
--

INSERT INTO `server_config` (`config`, `value`) VALUES
('boost_monster', '0'),
('boost_monster_name', ''),
('boost_monster_url', ''),
('db_version', '37'),
('motd_hash', '815194dfb446b52a3e94f39defd8f2cef3fb2863'),
('motd_num', '2'),
('players_record', '1');

-- --------------------------------------------------------

--
-- Estrutura para tabela `snowballwar`
--

CREATE TABLE `snowballwar` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `score` int(11) NOT NULL,
  `data` varchar(255) NOT NULL,
  `hora` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `store_history`
--

CREATE TABLE `store_history` (
  `accountid` int(11) NOT NULL,
  `mode` tinyint(1) NOT NULL DEFAULT 0,
  `amount` int(11) NOT NULL,
  `coinMode` tinyint(2) NOT NULL DEFAULT 0,
  `description` varchar(255) DEFAULT NULL,
  `cust` int(11) NOT NULL,
  `time` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `store_history_old`
--

CREATE TABLE `store_history_old` (
  `account_id` int(11) NOT NULL,
  `mode` smallint(2) NOT NULL DEFAULT 0,
  `description` varchar(3500) NOT NULL,
  `coin_amount` int(12) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL,
  `timestamp` int(11) NOT NULL DEFAULT 0,
  `id` int(11) NOT NULL,
  `coins` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tickets`
--

CREATE TABLE `tickets` (
  `ticket_id` int(11) NOT NULL,
  `ticket_subject` varchar(255) DEFAULT NULL,
  `ticket_author` varchar(255) DEFAULT NULL,
  `ticket_author_acc_id` int(11) NOT NULL,
  `ticket_last_reply` varchar(11) DEFAULT NULL,
  `ticket_admin_reply` int(11) DEFAULT NULL,
  `ticket_date` varchar(255) DEFAULT NULL,
  `ticket_ended` varchar(255) DEFAULT NULL,
  `ticket_status` varchar(255) DEFAULT NULL,
  `ticket_category` varchar(255) DEFAULT NULL,
  `ticket_description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tickets_reply`
--

CREATE TABLE `tickets_reply` (
  `reply_id` int(11) NOT NULL,
  `ticket_id` int(11) DEFAULT NULL,
  `reply_author` varchar(255) DEFAULT NULL,
  `reply_message` varchar(255) DEFAULT NULL,
  `reply_date` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tile_store`
--

CREATE TABLE `tile_store` (
  `house_id` int(11) NOT NULL,
  `data` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Despejando dados para a tabela `tile_store`
--

INSERT INTO `tile_store` (`house_id`, `data`) VALUES
(1, 0x55003b010701000000da0600),
(1, 0x57003a010701000000c50400),
(1, 0x59003b010701000000da0600),
(1, 0x55003c010701000000db0600),
(1, 0x59003c010701000000db0600),
(1, 0x570040010701000000c50400),
(2, 0x560047010601000000c30400),
(2, 0x550047010701000000c50400),
(2, 0x560046010701000000c30400),
(2, 0x570044010701000000c50400),
(2, 0x590046010601000000da0600),
(2, 0x590047010601000000db0600),
(2, 0x590049010601000000da0600),
(2, 0x59004a010601000000db0600),
(3, 0x58002e010701000000c50400),
(3, 0x5a002f010701000000da0600),
(3, 0x5a0030010701000000db0600),
(4, 0x60002e010701000000c50400),
(4, 0x61002f010701000000da0600),
(4, 0x610030010701000000db0600),
(5, 0x6d0036010701000000da0600),
(5, 0x6d0037010701000000db0600),
(5, 0x6b003a010701000000c50400),
(5, 0x6e003a010701000000c50400),
(5, 0x700036010701000000da0600),
(5, 0x700037010701000000db0600),
(5, 0x720036010701000000da0600),
(5, 0x720037010701000000db0600),
(5, 0x71003a010701000000c50400),
(5, 0x6e0040010701000000c50400),
(6, 0x6b0045010701000000130700),
(6, 0x6c0045010701000000c50400),
(7, 0x6b004a010701000000130700),
(7, 0x6e004e010701000000c30400),
(8, 0x6b0050010701000000130700),
(8, 0x6e0054010701000000c30400),
(9, 0x6b0056010701000000130700),
(9, 0x6e005a010701000000c30400),
(10, 0x3c0047010701000000c30400),
(10, 0x3d0045010701000000c50400),
(10, 0x3b0048010701000000c50400),
(10, 0x3c0049010601000000c60400),
(10, 0x3f004b010601000000da0600),
(10, 0x3f004b010701000000da0600),
(10, 0x3f004c010601000000db0600),
(10, 0x3f004c010701000000db0600),
(11, 0x470045010701000000c50400),
(11, 0x490047010701000000c40400),
(11, 0x43004b010701000000da0600),
(11, 0x45004b010701000000da0600),
(11, 0x4b0049010701000000c50400),
(11, 0x43004c010701000000db0600),
(11, 0x45004c010701000000db0600),
(11, 0x49004c010701000000c30400),
(12, 0x3f0030010601000000da0600),
(12, 0x3f0031010601000000db0600),
(12, 0x42002e010601000000c30400),
(12, 0x41002d010701000000c40400),
(12, 0x44002e010601000000c30400),
(12, 0x48002e010601000000c30400),
(12, 0x4a002e010601000000c30400),
(12, 0x4d002d010601000000e00600),
(12, 0x4e002d010601000000e10600),
(12, 0x4e002f010701000000c50400),
(12, 0x420031010601000000c30400),
(12, 0x440033010601000000c50400),
(12, 0x480033010601000000c50400),
(12, 0x4a0031010601000000c30400),
(12, 0x4e0030010601000000da0600),
(12, 0x4e0031010601000000db0600),
(12, 0x420035010601000000c30400),
(12, 0x470036010601000000e00600),
(12, 0x460037010701000000c50400),
(12, 0x480036010601000000e10600),
(12, 0x4a0035010601000000c30400),
(12, 0x480036010701000000c30400),
(12, 0x4d0036010601000000e00600),
(12, 0x4e0036010601000000e10600),
(13, 0x430047010601000000da0600),
(13, 0x430048010601000000db0600),
(13, 0x470048010601000000c30400),
(14, 0x4c0047010601000000da0600),
(14, 0x490048010601000000c30400),
(14, 0x4c0048010601000000db0600),
(15, 0x43004b010601000000da0600),
(15, 0x47004b010601000000c30400),
(15, 0x43004c010601000000db0600),
(16, 0x49004b010601000000c30400),
(16, 0x4c004b010601000000da0600),
(16, 0x4c004c010601000000db0600),
(17, 0x54004d010701000000da0600),
(17, 0x54004e010701000000db0600),
(17, 0x550050010701000000c50400),
(18, 0x59004d010701000000da0600),
(18, 0x59004e010701000000db0600),
(18, 0x580050010701000000c50400),
(19, 0x550052010701000000c50400),
(19, 0x530054010701000000da0600),
(19, 0x530055010701000000db0600),
(20, 0x580052010701000000c50400),
(20, 0x590054010701000000da0600),
(20, 0x590055010701000000db0600),
(21, 0x54004f010601000000c30400),
(21, 0x59004f010601000000da0600),
(21, 0x590050010601000000db0600),
(22, 0x540054010601000000c30400),
(22, 0x590054010601000000da0600),
(22, 0x590055010601000000db0600),
(23, 0x700048010601000000da0600),
(23, 0x700049010601000000db0600),
(23, 0x710048010601000000da0600),
(23, 0x710049010601000000db0600),
(23, 0x750048010601000000c30400),
(24, 0x7b0037010601000000e00600),
(24, 0x7c0037010601000000e10600),
(24, 0x760038010601000000da0600),
(24, 0x760039010601000000db0600),
(24, 0x79003a010601000000c50400),
(25, 0x76003e010601000000da0600),
(25, 0x76003f010601000000db0600),
(25, 0x79003c010601000000c50400),
(25, 0x7b003f010601000000e00600),
(25, 0x7c003f010601000000e10600),
(26, 0x7a0047010601000000da0600),
(26, 0x7d0047010601000000da0600),
(26, 0x7a0048010601000000db0600),
(26, 0x7c004a010601000000c60400),
(26, 0x7d0048010601000000db0600),
(26, 0x7e004c010601000000c30400),
(27, 0x870047010601000000c30400),
(27, 0x870047010701000000c30400),
(27, 0x8a0047010601000000c30400),
(27, 0x890045010701000000c50400),
(27, 0x8a0047010701000000c30400),
(27, 0x840049010601000000da0600),
(27, 0x84004a010601000000db0600),
(27, 0x840049010701000000da0600),
(27, 0x84004a010701000000db0600),
(27, 0x890048010601000000c50400),
(27, 0x890048010701000000c50400),
(27, 0x8d0049010601000000da0600),
(27, 0x8d004a010601000000db0600),
(27, 0x8d0049010701000000da0600),
(27, 0x8d004a010701000000db0600),
(28, 0x590027010701000000da0600),
(28, 0x57002b010701000000c50400),
(28, 0x580029010601000000da0600),
(28, 0x58002a010601000000db0600),
(28, 0x590028010701000000db0600),
(28, 0x610027010701000000da0600),
(28, 0x610028010701000000db0600),
(29, 0x5a0029010601000000da0600),
(29, 0x5a002a010601000000db0600),
(29, 0x5a002a0107010000001a0700),
(29, 0x610028010601000000c30400),
(29, 0x60002b010701000000c50400),
(30, 0x700028010701000000da0600),
(30, 0x700029010701000000db0600),
(30, 0x74002c010701000000c30400),
(31, 0x700028010601000000da0600),
(31, 0x700029010601000000db0600),
(31, 0x74002c010601000000c30400),
(32, 0x76002b010601000000c50400),
(32, 0x790029010601000000da0600),
(32, 0x79002a010601000000db0600),
(33, 0x81002b010601000000c50400),
(33, 0x830029010601000000da0600),
(33, 0x83002a010601000000db0600),
(34, 0x84002e010601000000c30400),
(34, 0x88002e010601000000da0600),
(34, 0x88002f010601000000db0600),
(35, 0x91002e010701000000da0600),
(35, 0x91002f010701000000db0600),
(35, 0x8d0030010701000000c50400),
(36, 0x960032010701000000c50400),
(36, 0x990030010701000000da0600),
(36, 0x990031010701000000db0600),
(37, 0xa1004b010701000000c30400),
(37, 0xa6004f010701000000da0600),
(37, 0xa7004e010701000000c30400),
(37, 0xa60050010701000000db0600),
(38, 0x9a004a010701000000c50400),
(38, 0x95004e010701000000da0600),
(38, 0x95004f010701000000db0600),
(38, 0x98004d010701000000c30400),
(39, 0x95004b010601000000da0600),
(39, 0x95004c010601000000db0600),
(39, 0x95004e010601000000da0600),
(39, 0x95004f010601000000db0600),
(39, 0x98004d010601000000c30400),
(39, 0x9c004e010601000000c30400),
(40, 0x8b004f010701000000da0600),
(40, 0x8b0050010701000000db0600),
(40, 0x8c0051010701000000c50400),
(40, 0x8d0055010701000000c50400),
(41, 0x8f004f010701000000da0600),
(41, 0x8f0050010701000000db0600),
(41, 0x900051010701000000c50400),
(41, 0x900055010701000000c50400),
(42, 0x890076010601000000c50400),
(42, 0x880078010601000000da0600),
(42, 0x880079010601000000db0600),
(43, 0x8d0076010601000000c50400),
(43, 0x8c0078010601000000da0600),
(43, 0x8c0079010601000000db0600),
(44, 0x910076010601000000c50400),
(44, 0x900078010601000000da0600),
(44, 0x900079010601000000db0600),
(45, 0x950076010601000000c50400),
(45, 0x940078010601000000da0600),
(45, 0x940079010601000000db0600),
(46, 0x8a006c010601000000da0600),
(46, 0x8a006d010601000000db0600),
(46, 0x8b0070010601000000c50400),
(47, 0x8e006c010601000000da0600),
(47, 0x8e006d010601000000db0600),
(47, 0x8f0070010601000000c50400),
(48, 0x92006c010601000000da0600),
(48, 0x92006d010601000000db0600),
(48, 0x930070010601000000c50400),
(49, 0x95006c010601000000da0600),
(49, 0x95006d010601000000db0600),
(49, 0x960070010601000000c50400),
(50, 0x750063010701000000da0600),
(50, 0x7c0062010701000000bc0400),
(50, 0x750064010701000000db0600),
(50, 0x750067010701000000da0600),
(50, 0x790064010701000000b90400),
(50, 0x790067010701000000b90400),
(50, 0x750068010701000000db0600),
(50, 0x79006b010701000000b90400),
(50, 0x7a006c010701000000bc0400),
(51, 0x5c0061010701000000c50400),
(51, 0x590065010701000000da0600),
(51, 0x590066010701000000db0600),
(51, 0x5d0065010701000000da0600),
(51, 0x5d0066010701000000db0600),
(52, 0x66007d010701000000c50400),
(52, 0x67007f010701000000c30400),
(52, 0x660081010701000000c60400),
(52, 0x670083010701000000c40400),
(52, 0x6b0080010701000000c50400),
(52, 0x6b0082010701000000da0600),
(52, 0x6b0083010701000000db0600),
(53, 0x4f0072010601000000da0600),
(53, 0x4f0073010601000000db0600),
(53, 0x4a0074010601000000c30400),
(53, 0x4a0074010701000000c30400),
(53, 0x4c0075010601000000c50400),
(53, 0x4e0074010601000000c30400),
(53, 0x4c0079010701000000c50400),
(53, 0x510072010601000000da0600),
(53, 0x510073010601000000db0600),
(53, 0x500071010701000000c50400),
(53, 0x500075010601000000c50400),
(53, 0x500075010701000000c50400),
(54, 0x4e0062010701000000c50400),
(54, 0x4d0065010701000000da0600),
(54, 0x4d0066010701000000db0600),
(55, 0x390061010601000000da0600),
(55, 0x390062010601000000db0600),
(55, 0x3b0062010601000000c30400),
(55, 0x390061010701000000da0600),
(55, 0x390062010701000000db0600),
(55, 0x3b0063010701000000c30400),
(55, 0x3e0063010601000000c50400),
(55, 0x3b0066010701000000c30400),
(55, 0x3e0064010701000000c60400),
(55, 0x400062010601000000c30400),
(55, 0x400062010701000000c40400),
(55, 0x430063010701000000c50400),
(55, 0x440060010701000000c50400),
(55, 0x400065010601000000c30400),
(55, 0x440064010601000000da0600),
(55, 0x440065010601000000db0600),
(55, 0x440067010601000000da0600),
(55, 0x440067010701000000da0600),
(55, 0x400068010601000000c30400),
(55, 0x440068010601000000db0600),
(55, 0x440068010701000000db0600),
(56, 0x290063010701000000bc0400),
(56, 0x240064010601000000da0600),
(56, 0x240065010601000000db0600),
(56, 0x270065010601000000c30400),
(56, 0x240067010701000000da0600),
(56, 0x270067010701000000c30400),
(56, 0x2a0067010601000000c50400),
(56, 0x2a0067010701000000c30400),
(56, 0x2c0064010601000000da0600),
(56, 0x2c0065010601000000db0600),
(56, 0x2d0067010601000000c50400),
(56, 0x2e0067010701000000da0600),
(56, 0x240068010601000000da0600),
(56, 0x240069010601000000db0600),
(56, 0x260068010601000000da0600),
(56, 0x260069010601000000db0600),
(56, 0x240068010701000000db0600),
(56, 0x24006a010701000000da0600),
(56, 0x24006b010701000000db0600),
(56, 0x280068010601000000da0600),
(56, 0x280069010601000000db0600),
(56, 0x290069010701000000bc0400),
(56, 0x2e0068010701000000db0600),
(56, 0x24006c010601000000da0600),
(56, 0x24006d010601000000db0600),
(56, 0x26006c010601000000da0600),
(56, 0x26006d010601000000db0600),
(56, 0x27006c010701000000c30400),
(56, 0x28006c010601000000da0600),
(56, 0x28006d010601000000db0600),
(56, 0x2c006c010701000000da0600),
(56, 0x2c006d010701000000db0600),
(56, 0x2e006c010701000000da0600),
(56, 0x2e006d010701000000db0600),
(57, 0xff023b030701000000c30400),
(57, 0x02033b030701000000620600),
(57, 0x05033c030701000000c30400),
(57, 0x08033c030701000000c30400),
(58, 0xff0242030701000000c30400),
(58, 0x020342030701000000620600),
(58, 0x050343030701000000c30400),
(58, 0x080343030701000000c30400),
(59, 0xff0249030701000000c30400),
(59, 0x020349030701000000620600),
(59, 0x05034a030701000000c30400),
(59, 0x08034a030701000000c30400),
(60, 0xc80229030701000000da0600),
(60, 0xc8022a030701000000db0600),
(60, 0xc4022f030701000000c50400),
(61, 0xcd0230030701000000da0600),
(61, 0xcd0231030701000000db0600),
(61, 0xcb0236030701000000c50400),
(62, 0xbf023b030701000000da0600),
(62, 0xbf023c030701000000db0600),
(62, 0xbf023f030701000000da0600),
(62, 0xc5023e030701000000c30400),
(62, 0xbf0240030701000000db0600),
(63, 0xcb023f030701000000c30400),
(63, 0xd00241030701000000da0600),
(63, 0xd00242030701000000db0600),
(64, 0xd50264030601000000da0600),
(64, 0xd50265030601000000db0600),
(64, 0xd50267030601000000da0600),
(64, 0xd60265030701000000c30400),
(64, 0xd50268030601000000db0600),
(65, 0xed0270030701000000c50400),
(66, 0xe70270030701000000c50400),
(67, 0xe30270030701000000c50400),
(68, 0xdf0270030701000000c50400),
(69, 0xed026d030701000000c50400),
(70, 0xe7026d030701000000c50400),
(71, 0xe3026d030701000000c50400),
(72, 0xdf026d030701000000c50400),
(73, 0xed026d030601000000c50400),
(74, 0xed0270030601000000c50400),
(75, 0xe70270030601000000c50400),
(76, 0xe30270030601000000c50400),
(77, 0xdf0270030601000000c50400),
(78, 0xdf026d030601000000c50400),
(79, 0xe3026d030601000000c50400),
(80, 0xe7026d030601000000c50400),
(81, 0xed0270030501000000c50400),
(82, 0xe70270030501000000c50400),
(83, 0xe30270030501000000c50400),
(84, 0xdf0270030501000000c50400),
(85, 0xdf026d030501000000c50400),
(86, 0xe3026d030501000000c50400),
(87, 0xe7026d030501000000c50400),
(88, 0xed026d030501000000c50400),
(89, 0xe7026c030801000000c50400),
(89, 0xe40272030801000000da0600),
(89, 0xe40273030801000000db0600),
(89, 0xe80272030801000000da0600),
(89, 0xe80273030801000000db0600),
(90, 0xeb026c030801000000c50400),
(90, 0xea0272030801000000da0600),
(90, 0xea0273030801000000db0600),
(90, 0xee0272030801000000da0600),
(90, 0xee0273030801000000db0600),
(91, 0xfe0265030701000000c30400),
(91, 0xfd026a030701000000c50400),
(91, 0xfe0268030701000000c30400),
(91, 0x000364030701000000da0600),
(91, 0x000365030701000000db0600),
(91, 0x000367030701000000da0600),
(91, 0x000368030701000000db0600),
(92, 0x050365030701000000c30400),
(92, 0x070364030701000000da0600),
(92, 0x070365030701000000db0600),
(92, 0x070367030701000000da0600),
(92, 0x04036a030701000000c50400),
(92, 0x050368030701000000c30400),
(92, 0x070368030701000000db0600),
(93, 0x25035f030701000000da0600),
(93, 0x1f0362030701000000c30400),
(93, 0x250360030701000000db0600),
(93, 0x250363030701000000da0600),
(93, 0x250364030701000000db0600),
(94, 0x14033b030701000000da0600),
(94, 0x19033b030701000000da0600),
(94, 0x14033c030701000000db0600),
(94, 0x19033c030701000000db0600),
(94, 0x170341030701000000c50400),
(95, 0x16034b030701000000c30400),
(95, 0x1b0348030701000000da0600),
(95, 0x1b0349030701000000db0600),
(95, 0x1b034c030701000000da0600),
(95, 0x1b034d030701000000db0600),
(96, 0x19034f030701000000da0600),
(96, 0x130352030701000000c30400),
(96, 0x190350030701000000db0600),
(96, 0x190353030701000000da0600),
(96, 0x190354030701000000db0600),
(97, 0x1b034f030701000000da0600),
(97, 0x1f034f030701000000da0600),
(97, 0x1b0350030701000000db0600),
(97, 0x1f0350030701000000db0600),
(97, 0x1d0355030701000000c50400),
(98, 0x1b0352030601000000c30400),
(98, 0x1f0353030601000000da0600),
(98, 0x1f0354030601000000db0600),
(99, 0x140353030601000000da0600),
(99, 0x190352030601000000c30400),
(99, 0x140354030601000000db0600),
(100, 0x170348030601000000da0600),
(100, 0x170349030601000000db0600),
(100, 0x1b0348030601000000da0600),
(100, 0x1b0349030601000000db0600),
(100, 0x1a034e030601000000c50400),
(101, 0xef0283030701000000c30400),
(101, 0xeb0285030701000000da0600),
(101, 0xeb0286030701000000db0600),
(102, 0xef0283030601000000c30400),
(102, 0xeb0285030601000000da0600),
(102, 0xeb0286030601000000db0600),
(103, 0x03037e030701000000c50400),
(103, 0x04037e030601000000c50400),
(103, 0x07037e030601000000c50400),
(103, 0x04037d030701000000c30400),
(103, 0x020380030601000000da0600),
(103, 0x020381030601000000db0600),
(103, 0x020380030801000000da0600),
(103, 0x020381030801000000db0600),
(103, 0x060380030601000000da0600),
(103, 0x060381030601000000db0600),
(103, 0x070382030701000000c50400),
(103, 0x070380030801000000da0600),
(103, 0x070381030801000000db0600),
(104, 0xfd027e030601000000c50400),
(104, 0xfc027e030701000000c50400),
(104, 0xfd027d030701000000c30400),
(104, 0xfb0280030601000000da0600),
(104, 0xfb0281030601000000db0600),
(104, 0xfb0280030801000000da0600),
(104, 0xfb0281030801000000db0600),
(104, 0xff0280030601000000da0600),
(104, 0xff0281030601000000db0600),
(104, 0xfd0281030701000000c30400),
(104, 0x00037e030601000000c50400),
(104, 0x000382030701000000c50400),
(104, 0x000380030801000000da0600),
(104, 0x000381030801000000db0600),
(105, 0xf7027e030601000000c50400),
(105, 0xf6027e030701000000c50400),
(105, 0xf7027d030701000000c30400),
(105, 0xf9027e030601000000c50400),
(105, 0xf50280030601000000da0600),
(105, 0xf50281030601000000db0600),
(105, 0xf70281030701000000c30400),
(105, 0xf50280030801000000da0600),
(105, 0xf50281030801000000db0600),
(105, 0xf90280030601000000da0600),
(105, 0xf90281030601000000db0600),
(105, 0xf90282030701000000c50400),
(105, 0xf90280030801000000da0600),
(105, 0xf90281030801000000db0600),
(106, 0xf60277030601000000c50400),
(106, 0xf70276030601000000c30400),
(106, 0xf60276030801000000c30400),
(106, 0xf90275030601000000da0600),
(106, 0xf90276030601000000db0600),
(106, 0xf90274030701000000c50400),
(106, 0xf90275030801000000da0600),
(106, 0xf90276030801000000db0600),
(106, 0xf6027a030801000000c30400),
(106, 0xf90279030601000000da0600),
(106, 0xf9027a030601000000db0600),
(106, 0xf90279030801000000da0600),
(106, 0xf9027a030801000000db0600),
(107, 0xfc0277030601000000c50400),
(107, 0xfd0276030601000000c30400),
(107, 0xfc0276030801000000c30400),
(107, 0xfc027a030801000000c30400),
(107, 0x000375030601000000da0600),
(107, 0x000376030601000000db0600),
(107, 0x000374030701000000c50400),
(107, 0x000375030801000000da0600),
(107, 0x000376030801000000db0600),
(107, 0x000379030601000000da0600),
(107, 0x00037a030601000000db0600),
(107, 0x000379030801000000da0600),
(107, 0x00037a030801000000db0600),
(108, 0x030377030601000000c50400),
(108, 0x030376030801000000c30400),
(108, 0x040376030601000000c30400),
(108, 0x070375030601000000da0600),
(108, 0x070376030601000000db0600),
(108, 0x070374030701000000c50400),
(108, 0x070375030801000000da0600),
(108, 0x070376030801000000db0600),
(108, 0x03037a030801000000c30400),
(108, 0x070379030601000000da0600),
(108, 0x07037a030601000000db0600),
(108, 0x070379030801000000da0600),
(108, 0x07037a030801000000db0600),
(109, 0x0d036e030701000000da0600),
(109, 0x0d036f030701000000db0600),
(109, 0x10036f030701000000c30400),
(109, 0x11036d030701000000c50400),
(110, 0x0d036e030601000000da0600),
(110, 0x0d036f030601000000db0600),
(110, 0x10036f030601000000c30400),
(110, 0x13036e030601000000c30400),
(110, 0x0f0372030601000000c30400),
(111, 0x1b0372030601000000c50400),
(111, 0x180372030701000000c30400),
(111, 0x1c0371030601000000c30400),
(111, 0x1e0370030601000000da0600),
(111, 0x1e0371030601000000db0600),
(111, 0x1f0372030701000000c30400),
(111, 0x1d0372030801000000c50400),
(111, 0x1e0370030801000000da0600),
(111, 0x1e0371030801000000db0600),
(112, 0x1e0377030601000000da0600),
(112, 0x1e0377030801000000da0600),
(112, 0x1b0379030601000000c50400),
(112, 0x180379030701000000c30400),
(112, 0x1c0378030601000000c30400),
(112, 0x1e0378030601000000db0600),
(112, 0x1f0379030701000000c30400),
(112, 0x1d0379030801000000c50400),
(112, 0x1e0378030801000000db0600),
(113, 0x110377030701000000c50400),
(113, 0x120375030701000000da0600),
(113, 0x120376030701000000db0600),
(113, 0x130379030701000000c30400),
(114, 0x110377030601000000c50400),
(114, 0x130375030601000000c30400),
(114, 0x120379030601000000da0600),
(114, 0x12037a030601000000db0600),
(115, 0x11037f030701000000c50400),
(115, 0x13037e030701000000c30400),
(115, 0x120380030701000000da0600),
(115, 0x120381030701000000db0600),
(116, 0x10037d030601000000c30400),
(116, 0x12037f030601000000c50400),
(116, 0x13037c030601000000c30400),
(116, 0x110380030601000000da0600),
(116, 0x110381030601000000db0600),
(117, 0x1b0383030601000000c50400),
(117, 0x180381030701000000c30400),
(117, 0x1d0381030601000000c30400),
(117, 0x1d0382030701000000c30400),
(117, 0x190386030601000000da0600),
(117, 0x190387030601000000db0600),
(117, 0x190384030701000000da0600),
(117, 0x190385030701000000db0600),
(117, 0x190386030701000000da0600),
(117, 0x190387030701000000db0600),
(117, 0x1c0387030701000000c30400),
(117, 0x200383030601000000c50400),
(117, 0x210381030601000000da0600),
(117, 0x210382030601000000db0600),
(117, 0x200383030701000000c50400),
(117, 0x210386030601000000da0600),
(117, 0x210387030601000000db0600),
(117, 0x210386030701000000da0600),
(117, 0x210387030701000000db0600),
(118, 0x020387030501000000da0600),
(118, 0x020387030701000000da0600),
(118, 0x080387030501000000da0600),
(118, 0x020388030501000000db0600),
(118, 0x020388030701000000db0600),
(118, 0x02038a030701000000da0600),
(118, 0x02038b030701000000db0600),
(118, 0x03038b030801000000da0600),
(118, 0x04038a030501000000c50400),
(118, 0x07038a030501000000c50400),
(118, 0x060388030701000000c30400),
(118, 0x06038b030701000000c30400),
(118, 0x05038b030801000000da0600),
(118, 0x060388030801000000c30400),
(118, 0x07038b030801000000da0600),
(118, 0x080388030501000000db0600),
(118, 0x080388030701000000c30400),
(118, 0x02038f030501000000da0600),
(118, 0x03038c030501000000c30400),
(118, 0x02038d030701000000da0600),
(118, 0x02038e030701000000db0600),
(118, 0x02038f030701000000da0600),
(118, 0x03038c030801000000db0600),
(118, 0x03038e030801000000da0600),
(118, 0x03038f030801000000db0600),
(118, 0x05038d030501000000c50400),
(118, 0x06038f030701000000c30400),
(118, 0x05038c030801000000db0600),
(118, 0x05038e030801000000da0600),
(118, 0x05038f030801000000db0600),
(118, 0x07038c030801000000db0600),
(118, 0x07038e030801000000da0600),
(118, 0x07038f030801000000db0600),
(118, 0x0a038d030501000000c50400),
(118, 0x0b038f030501000000da0600),
(118, 0x0c038d030701000000c30400),
(118, 0x020390030501000000db0600),
(118, 0x020390030701000000db0600),
(118, 0x0b0390030501000000db0600),
(119, 0x15038a030801000000da0600),
(119, 0x15038b030801000000db0600),
(119, 0x19038b030801000000c30400),
(119, 0x1c038a030801000000da0600),
(119, 0x1c038b030801000000db0600),
(119, 0x13038e030701000000c30400),
(119, 0x17038c030501000000da0600),
(119, 0x17038d030501000000db0600),
(119, 0x17038f030601000000c30400),
(119, 0x19038f030501000000c50400),
(119, 0x1b038f030501000000c50400),
(119, 0x19038e030701000000c50400),
(119, 0x19038e030801000000da0600),
(119, 0x19038f030801000000db0600),
(119, 0x1d038c030501000000da0600),
(119, 0x1d038d030501000000db0600),
(119, 0x1d038f030701000000da0600),
(119, 0x1c038e030801000000da0600),
(119, 0x1c038f030801000000db0600),
(119, 0x160392030501000000c50400),
(119, 0x160392030601000000c50400),
(119, 0x150391030801000000da0600),
(119, 0x150392030801000000db0600),
(119, 0x170391030801000000da0600),
(119, 0x170392030801000000db0600),
(119, 0x1b0392030501000000c50400),
(119, 0x1a0391030701000000c30400),
(119, 0x190391030801000000da0600),
(119, 0x190392030801000000db0600),
(119, 0x1b0391030801000000da0600),
(119, 0x1b0392030801000000db0600),
(119, 0x1c0391030501000000c30400),
(119, 0x1d0390030701000000db0600),
(119, 0x1d0393030701000000da0600),
(119, 0x140394030501000000da0600),
(119, 0x140395030501000000db0600),
(119, 0x170394030701000000c30400),
(119, 0x1a0394030701000000c30400),
(119, 0x1d0394030501000000da0600),
(119, 0x1d0395030501000000db0600),
(119, 0x1d0394030701000000db0600),
(120, 0x240396030501000000c30400),
(120, 0x230399030401000000da0600),
(120, 0x23039a030401000000db0600),
(120, 0x230399030601000000da0600),
(120, 0x23039a030601000000db0600),
(120, 0x270399030401000000da0600),
(120, 0x27039a030401000000db0600),
(120, 0x250398030601000000c50400),
(120, 0x270399030601000000da0600),
(120, 0x27039a030601000000db0600),
(120, 0x25039b030701000000c50400),
(121, 0x11039d030501000000da0600),
(121, 0x11039e030501000000db0600),
(121, 0x11039d030601000000da0600),
(121, 0x11039e030601000000db0600),
(121, 0x14039d030501000000da0600),
(121, 0x14039e030501000000db0600),
(121, 0x15039d030601000000da0600),
(121, 0x15039e030601000000db0600),
(121, 0x14039f030701000000c30400),
(121, 0x16039c030701000000c50400),
(121, 0x18039f030501000000c30400),
(121, 0x1103a0030501000000da0600),
(121, 0x1103a1030501000000db0600),
(121, 0x1203a1030601000000c50400),
(121, 0x1203a3030601000000c50400),
(121, 0x1103a1030701000000e00600),
(121, 0x1103a3030701000000e00600),
(121, 0x1203a1030701000000e10600),
(121, 0x1203a3030701000000e10600),
(121, 0x1403a0030501000000da0600),
(121, 0x1403a1030501000000db0600),
(121, 0x1603a1030601000000c50400),
(121, 0x1603a3030601000000c50400),
(121, 0x1403a2030701000000c30400),
(121, 0x1603a3030701000000c50400),
(121, 0x1a03a3030601000000c50400),
(121, 0x1103a6030601000000da0600),
(121, 0x1103a7030601000000db0600),
(121, 0x1103a5030701000000e00600),
(121, 0x1103a7030701000000e00600),
(121, 0x1203a5030701000000e10600),
(121, 0x1203a7030701000000e10600),
(121, 0x1503a6030601000000da0600),
(121, 0x1503a7030601000000db0600),
(121, 0x1903a6030601000000da0600),
(121, 0x1903a7030601000000db0600),
(121, 0x1a03a6030701000000da0600),
(121, 0x1a03a7030701000000db0600),
(122, 0xa701c6000701000000da0600),
(122, 0xa701c7000701000000db0600),
(122, 0xad01c6000701000000da0600),
(122, 0xad01c7000701000000db0600),
(122, 0xa701cb000701000000da0600),
(122, 0xaf01ca000701000000bc0400),
(122, 0xa701cc000701000000db0600),
(122, 0xb101cc000701000000ba0400),
(122, 0xb301cc000701000000ba0400),
(123, 0xba01c0000701000000da0600),
(123, 0xba01c1000701000000db0600),
(123, 0xbf01c2000701000000ba0400),
(123, 0xbc01c4000701000000bc0400),
(123, 0xbc01cc000701000000bc0400),
(123, 0xc801c0000701000000da0600),
(123, 0xc801c1000701000000db0600),
(123, 0xc801c2000701000000da0600),
(123, 0xc801c3000701000000db0600),
(124, 0xcf01c0000701000000da0600),
(124, 0xcf01c1000701000000db0600),
(124, 0xcf01c2000701000000da0600),
(124, 0xcf01c3000701000000db0600),
(124, 0xd501c2000701000000ba0400),
(124, 0xd601c5000701000000da0600),
(124, 0xd601c6000701000000db0600),
(124, 0xd801c4000701000000bc0400),
(124, 0xd801ce000701000000bc0400),
(125, 0xc501ca000701000000da0600),
(125, 0xc501cb000701000000db0600),
(125, 0xc801ca000701000000da0600),
(125, 0xc801cb000701000000db0600),
(125, 0xc701ce000701000000bc0400),
(125, 0xc101d0000701000000ba0400),
(125, 0xc401d0000701000000ba0400),
(126, 0xaf01d7000701000000bc0400),
(126, 0xad01da000701000000da0600),
(126, 0xad01db000701000000db0600),
(126, 0xb101d6000701000000ba0400),
(126, 0xb301d6000701000000ba0400),
(126, 0xb001da000701000000da0600),
(126, 0xb001db000701000000db0600),
(127, 0xb601dc000701000000bc0400),
(127, 0xb601df000701000000bc0400),
(127, 0xad01e0000701000000e00600),
(127, 0xad01e2000701000000e00600),
(127, 0xae01e0000701000000e10600),
(127, 0xae01e2000701000000e10600),
(127, 0xb401e1000701000000ba0400),
(128, 0xbc01e7000701000000bc0400),
(128, 0xb401eb000701000000e00600),
(128, 0xb501eb000701000000e10600),
(128, 0xbc01ea000701000000bc0400),
(128, 0xb401ed000701000000e00600),
(128, 0xb501ed000701000000e10600),
(128, 0xba01ec000701000000b90400),
(129, 0xc101e3000701000000ba0400),
(129, 0xc401e3000701000000ba0400),
(129, 0xc501e7000701000000da0600),
(129, 0xc701e4000701000000bc0400),
(129, 0xc901e7000701000000da0600),
(129, 0xc501e8000701000000db0600),
(129, 0xc901e8000701000000db0600),
(130, 0xc101d7000701000000ba0400),
(130, 0xc401d7000701000000ba0400),
(130, 0xc501db000701000000da0600),
(130, 0xc701d8000701000000bc0400),
(130, 0xc801db000701000000da0600),
(130, 0xc501dc000701000000db0600),
(130, 0xc801dc000701000000db0600),
(131, 0xd601d4000601000000e00600),
(131, 0xd601d6000601000000e00600),
(131, 0xd701d4000601000000e10600),
(131, 0xd701d6000601000000e10600),
(131, 0xd601d4000701000000da0600),
(131, 0xd601d5000701000000db0600),
(131, 0xda01d4000601000000e00600),
(131, 0xda01d6000601000000e00600),
(131, 0xdb01d4000601000000e10600),
(131, 0xdb01d6000601000000e10600),
(131, 0xd901d4000701000000da0600),
(131, 0xd901d5000701000000db0600),
(131, 0xdf01d4000601000000e00600),
(131, 0xdf01d6000601000000e00600),
(131, 0xdc01d4000701000000da0600),
(131, 0xdc01d5000701000000db0600),
(131, 0xdf01d4000701000000da0600),
(131, 0xdf01d5000701000000db0600),
(131, 0xd801d9000601000000bc0400),
(131, 0xd801d9000701000000bc0400),
(131, 0xd601de000601000000da0600),
(131, 0xd601df000601000000db0600),
(131, 0xdb01de000601000000da0600),
(131, 0xdb01df000601000000db0600),
(131, 0xe001d4000601000000e10600),
(131, 0xe001d6000601000000e10600),
(131, 0xe601da000701000000da0600),
(131, 0xe601db000701000000db0600),
(131, 0xe001de000601000000da0600),
(131, 0xe001df000601000000db0600),
(131, 0xe101de000701000000ba0400),
(131, 0xe601de000701000000da0600),
(131, 0xe601df000701000000db0600),
(131, 0xdb01e3000701000000ba0400),
(131, 0xd801e6000701000000bc0400),
(131, 0xd801ec000701000000bc0400),
(131, 0xe001e1000701000000da0600),
(131, 0xe001e2000701000000db0600),
(131, 0xe001e4000701000000da0600),
(131, 0xe001e5000701000000db0600),
(132, 0x8f01dc000701000000da0600),
(132, 0x8f01dd000701000000db0600),
(132, 0x9301db000701000000ba0400),
(133, 0xa201fe000701000000620600),
(133, 0xa40102010701000000da0600),
(133, 0xa40103010701000000db0600),
(133, 0xab0102010701000000ba0400),
(134, 0xcb010b010701000000da0600),
(134, 0xcb010c010701000000db0600),
(134, 0xd10106010701000000bc0400),
(135, 0xd401fe000701000000da0600),
(135, 0xd401ff000701000000db0600),
(135, 0xd901fc000701000000640600),
(135, 0xd70102010701000000bc0400),
(136, 0xe301f9000701000000bc0400),
(136, 0xe10101010701000000e00600),
(136, 0xe20101010701000000e10600),
(137, 0xf001ed000701000000da0600),
(137, 0xf001ee000701000000db0600),
(137, 0xea01f5000701000000bc0400),
(138, 0xf301d9000701000000da0600),
(138, 0xf301da000701000000db0600),
(138, 0xf301e0000701000000da0600),
(138, 0xf301e1000701000000db0600),
(138, 0xf801e0000701000000ba0400),
(139, 0xf101c4000701000000640600),
(139, 0xf201ce000701000000bc0400),
(139, 0xf501cc000701000000da0600),
(139, 0xf501cd000701000000db0600),
(140, 0xe401bd000701000000da0600),
(140, 0xe401be000701000000db0600),
(140, 0xe901c6000701000000bc0400),
(141, 0x9c01d1000601000000da0600),
(141, 0x9c01d2000601000000db0600),
(141, 0x9e01d1000601000000da0600),
(141, 0x9e01d2000601000000db0600),
(141, 0x9d01d5000601000000bc0400),
(141, 0x9f01db000601000000ba0400),
(142, 0xad01f1000501000000da0600),
(142, 0xad01f2000501000000db0600),
(142, 0xad01f1000601000000da0600),
(142, 0xad01f2000601000000db0600),
(142, 0xb001f1000501000000ba0400),
(142, 0xb301f2000501000000bc0400),
(142, 0xb001f1000601000000ba0400),
(142, 0xb201f0000601000000bc0400),
(142, 0xb201f2000601000000bc0400),
(142, 0xb101f6000501000000da0600),
(142, 0xb101f7000501000000db0600),
(142, 0xb101f6000601000000da0600),
(142, 0xb101f7000601000000db0600),
(142, 0xb401f6000501000000da0600),
(142, 0xb401f7000501000000db0600),
(142, 0xb401f6000601000000da0600),
(142, 0xb401f7000601000000db0600),
(143, 0xca01f2000601000000ba0400),
(143, 0xcf01f7000501000000da0600),
(143, 0xcf01f7000601000000da0600),
(143, 0xcf01f8000501000000db0600),
(143, 0xcf01f8000601000000db0600),
(143, 0xd401f3000601000000ba0400),
(143, 0xd001f5000501000000bc0400),
(143, 0xd301f7000501000000da0600),
(143, 0xd001f5000601000000bc0400),
(143, 0xd301f7000601000000da0600),
(143, 0xd301f8000501000000db0600),
(143, 0xd301f8000601000000db0600),
(144, 0xe701e9000601000000bc0400),
(144, 0xe201ee000601000000bc0400),
(144, 0xe101f0000601000000e00600),
(144, 0xe201f0000601000000e10600),
(145, 0xea01d8000601000000e00600),
(145, 0xeb01d8000601000000e10600),
(145, 0xec01d8000601000000e00600),
(145, 0xec01da000601000000bc0400),
(145, 0xed01d8000601000000e10600),
(145, 0xec01e1000601000000bc0400),
(146, 0xce01df000401000000da0600),
(146, 0xce01df000501000000da0600),
(146, 0xd401df000401000000da0600),
(146, 0xd601de000501000000bc0400),
(146, 0xce01e0000401000000db0600),
(146, 0xce01e0000501000000db0600),
(146, 0xcf01e5000401000000ba0400),
(146, 0xcf01e5000501000000ba0400),
(146, 0xca01e9000401000000e00600),
(146, 0xca01eb000401000000e00600),
(146, 0xcb01e9000401000000e10600),
(146, 0xcb01eb000401000000e10600),
(146, 0xca01e9000501000000e00600),
(146, 0xca01eb000501000000e00600),
(146, 0xcb01e9000501000000e10600),
(146, 0xcb01eb000501000000e10600),
(146, 0xd101e3000401000000bc0400),
(146, 0xd401e0000401000000db0600),
(146, 0xd101e8000401000000bc0400),
(146, 0xd101e8000501000000bc0400),
(147, 0xab01dd000401000000e00600),
(147, 0xac01dd000401000000e10600),
(147, 0xae01dc000501000000bc0400),
(147, 0xab01e0000401000000e00600),
(147, 0xab01e3000401000000e00600),
(147, 0xac01e0000401000000e10600),
(147, 0xac01e3000401000000e10600),
(147, 0xb101e0000401000000ba0400),
(147, 0xb401e0000501000000bc0400),
(147, 0xb401e4000401000000bc0400),
(147, 0xb401e4000501000000bc0400),
(147, 0xb201e8000401000000e00600),
(147, 0xb301e8000401000000e10600),
(147, 0xb201e8000501000000e00600),
(147, 0xb301e8000501000000e10600),
(147, 0xb601e8000401000000e00600),
(147, 0xb701e8000401000000e10600),
(147, 0xb601e8000501000000e00600),
(147, 0xb701e8000501000000e10600),
(148, 0xce01cf000401000000ba0400),
(148, 0xd301ce000401000000bc0400),
(149, 0x1e02ca010501000000061400),
(149, 0x2602ca010501000000061400),
(149, 0x2802cc010501000000ff1300),
(150, 0xcd0030000601000000c30400),
(150, 0xcc0033000701000000c50400),
(150, 0xca0035000601000000c30400),
(150, 0xcc0035000701000000c50400),
(150, 0xcd0039000601000000c30400),
(150, 0xd00033000601000000c50400),
(150, 0xd00033000701000000c50400),
(150, 0xd50032000501000000c50400),
(150, 0xd40033000601000000c50400),
(150, 0xd40033000701000000c50400),
(150, 0xd80032000501000000c50400),
(150, 0xd80033000601000000c50400),
(150, 0xd80033000701000000c50400),
(150, 0xd00036000601000000c50400),
(150, 0xd00035000701000000c50400),
(150, 0xd40036000601000000c50400),
(150, 0xd40035000701000000c50400),
(150, 0xd80035000501000000c50400),
(150, 0xd80036000601000000c50400),
(150, 0xd80035000701000000c50400),
(151, 0x7c03e1070601000000731b00),
(151, 0x7d03e2070601000000f71a00),
(151, 0x7c03e1070701000000731b00),
(151, 0x7f03e1070701000000731b00),
(151, 0x7c03e7070601000000731b00),
(151, 0x7c03e7070701000000731b00),
(151, 0x7f03e7070701000000731b00),
(151, 0x8003e3070601000000741b00),
(151, 0x8003e6070601000000741b00),
(151, 0x8003e4070701000000f71a00),
(151, 0x8003e6070701000000741b00),
(152, 0xa60064000701000000da0600),
(152, 0xa60065000701000000db0600),
(152, 0xac0066000701000000a41400),
(153, 0xad005b000701000000da0600),
(153, 0xad005c000701000000db0600),
(153, 0xb3005d000701000000a41400),
(154, 0xbd005b000701000000da0600),
(154, 0xb7005d000701000000a41400),
(154, 0xbd005c000701000000db0600),
(155, 0xbe0066000701000000a41400),
(155, 0xc40066000701000000da0600),
(155, 0xc40067000701000000db0600),
(156, 0xaf006c000701000000a61400),
(156, 0xb2006d000701000000da0600),
(156, 0xb2006e000701000000db0600),
(157, 0xa60064000601000000da0600),
(157, 0xa60065000601000000db0600),
(157, 0xac0066000601000000a41400),
(158, 0xad005b000601000000da0600),
(158, 0xad005c000601000000db0600),
(158, 0xb3005d000601000000a41400),
(159, 0xbd005b000601000000da0600),
(159, 0xb7005d000601000000a41400),
(159, 0xbd005c000601000000db0600),
(160, 0xbe0066000601000000a41400),
(160, 0xc40064000601000000da0600),
(160, 0xc40065000601000000db0600),
(161, 0xaf006c000601000000a61400),
(161, 0xb2006d000601000000da0600),
(161, 0xb2006e000601000000db0600),
(162, 0xa60064000501000000da0600),
(162, 0xa60065000501000000db0600),
(162, 0xac0066000501000000a41400),
(163, 0xad005b000501000000da0600),
(163, 0xad005c000501000000db0600),
(163, 0xb3005d000501000000a41400),
(164, 0xbd005b000501000000da0600),
(164, 0xb7005d000501000000a41400),
(164, 0xbd005c000501000000db0600),
(165, 0xbe0066000501000000a41400),
(165, 0xc40064000501000000da0600),
(165, 0xc40065000501000000db0600),
(166, 0xad006d000501000000da0600),
(166, 0xad006e000501000000db0600),
(166, 0xb2006c000501000000a61400),
(167, 0xb30066000501000000a41400),
(167, 0xb70066000501000000da0600),
(167, 0xb70067000501000000db0600),
(168, 0x8803e3070701000000741b00),
(168, 0x8803e5070701000000f71a00),
(168, 0x8803e7070701000000741b00),
(168, 0x8e03e5070701000000741b00),
(168, 0x8c03e8070701000000731b00),
(169, 0x9303e4070701000000731b00),
(169, 0x9503e4070701000000ee1a00),
(169, 0x9103e8070701000000741b00),
(169, 0x9403e9070601000000f71a00),
(169, 0x9703e8070701000000741b00),
(170, 0x9703d2070701000000741b00),
(170, 0x9d03d2070701000000741b00),
(170, 0x9a03d4070701000000ee1a00),
(170, 0x9b03d4070701000000731b00),
(171, 0x9103cd070701000000731b00),
(171, 0x8e03d0070701000000f71a00),
(171, 0x8e03d2070701000000741b00),
(171, 0x9103d4070701000000731b00),
(172, 0x8003c6070701000000741b00),
(172, 0x8703c6070701000000741b00),
(172, 0x8303c8070701000000ee1a00),
(172, 0x8503c8070701000000731b00),
(173, 0x7f03be070701000000741b00),
(173, 0x8203bb070701000000731b00),
(173, 0x8503be070701000000f71a00),
(173, 0x8203c0070701000000731b00),
(174, 0x7903be070701000000731b00),
(174, 0x7c03be070701000000731b00),
(174, 0x7703c1070701000000741b00),
(174, 0x7d03c2070701000000f71a00),
(174, 0x7903c4070701000000731b00),
(174, 0x7c03c4070701000000731b00),
(175, 0x7a03c6070701000000731b00),
(175, 0x7703ca070701000000741b00),
(175, 0x7d03ca070701000000741b00),
(175, 0x7a03cc070701000000ee1a00),
(175, 0x7b03cc070701000000731b00),
(176, 0x6e03c7070701000000741b00),
(176, 0x7403c7070701000000741b00),
(176, 0x7103ca070701000000ee1a00),
(177, 0x6703ca070701000000731b00),
(177, 0x6403cd070701000000741b00),
(177, 0x6a03cd070601000000741b00),
(177, 0x6a03cd070701000000741b00),
(177, 0x6703d0070701000000ee1a00),
(178, 0x6e03ce070701000000731b00),
(178, 0x6c03d1070701000000741b00),
(178, 0x6e03d4070701000000731b00),
(178, 0x7203d1070701000000f71a00),
(178, 0x7203d3070701000000741b00),
(178, 0x7103d4070701000000731b00),
(179, 0x7803cf070701000000731b00),
(179, 0x7603d2070701000000741b00),
(179, 0x7c03d2070701000000741b00),
(179, 0x7903d5070701000000ee1a00),
(179, 0x7a03d5070701000000731b00),
(180, 0x6f03d7070701000000731b00),
(180, 0x6d03da070701000000741b00),
(180, 0x7203d7070701000000731b00),
(180, 0x7203da070601000000ee1a00),
(180, 0x7303da070701000000741b00),
(180, 0x7303db070701000000f71a00),
(181, 0x6603d4070701000000731b00),
(181, 0x6903d7070701000000f71a00),
(181, 0x6603da070701000000731b00),
(181, 0x6903d8070701000000741b00),
(182, 0x6803de070701000000731b00),
(182, 0x6903de070701000000ee1a00),
(182, 0x6603e2070701000000741b00),
(182, 0x6c03e2070701000000741b00),
(182, 0x6903e4070701000000731b00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_forum`
--

CREATE TABLE `z_forum` (
  `id` int(11) NOT NULL,
  `first_post` int(11) NOT NULL DEFAULT 0,
  `last_post` int(11) NOT NULL DEFAULT 0,
  `section` int(3) NOT NULL DEFAULT 0,
  `replies` int(20) NOT NULL DEFAULT 0,
  `views` int(20) NOT NULL DEFAULT 0,
  `author_aid` int(20) NOT NULL DEFAULT 0,
  `author_guid` int(20) NOT NULL DEFAULT 0,
  `post_text` text NOT NULL,
  `post_topic` varchar(255) NOT NULL,
  `post_smile` tinyint(1) NOT NULL DEFAULT 0,
  `post_date` int(20) NOT NULL DEFAULT 0,
  `last_edit_aid` int(20) NOT NULL DEFAULT 0,
  `edit_date` int(20) NOT NULL DEFAULT 0,
  `post_ip` varchar(15) NOT NULL DEFAULT '0.0.0.0',
  `icon_id` int(11) NOT NULL,
  `news_icon` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_network_box`
--

CREATE TABLE `z_network_box` (
  `id` int(11) NOT NULL,
  `network_name` varchar(10) NOT NULL,
  `network_link` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_news_tickers`
--

CREATE TABLE `z_news_tickers` (
  `date` int(11) NOT NULL DEFAULT 1,
  `author` int(11) NOT NULL,
  `image_id` int(3) NOT NULL DEFAULT 0,
  `text` text NOT NULL,
  `hide_ticker` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_ots_comunication`
--

CREATE TABLE `z_ots_comunication` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `param1` varchar(255) NOT NULL,
  `param2` varchar(255) NOT NULL,
  `param3` varchar(255) NOT NULL,
  `param4` varchar(255) NOT NULL,
  `param5` varchar(255) NOT NULL,
  `param6` varchar(255) NOT NULL,
  `param7` varchar(255) NOT NULL,
  `delete_it` int(2) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_ots_guildcomunication`
--

CREATE TABLE `z_ots_guildcomunication` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `param1` varchar(255) NOT NULL,
  `param2` varchar(255) NOT NULL,
  `param3` varchar(255) NOT NULL,
  `param4` varchar(255) NOT NULL,
  `param5` varchar(255) NOT NULL,
  `param6` varchar(255) NOT NULL,
  `param7` varchar(255) NOT NULL,
  `delete_it` int(2) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_polls`
--

CREATE TABLE `z_polls` (
  `id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `end` int(11) NOT NULL,
  `start` int(11) NOT NULL,
  `answers` int(11) NOT NULL,
  `votes_all` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_polls_answers`
--

CREATE TABLE `z_polls_answers` (
  `poll_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `answer` varchar(255) NOT NULL,
  `votes` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_replay`
--

CREATE TABLE `z_replay` (
  `title` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_shop_category`
--

CREATE TABLE `z_shop_category` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `desc` varchar(255) NOT NULL,
  `button` varchar(50) NOT NULL,
  `hide` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_shop_donates`
--

CREATE TABLE `z_shop_donates` (
  `id` int(11) NOT NULL,
  `date` bigint(20) NOT NULL,
  `reference` varchar(50) NOT NULL,
  `account_name` varchar(50) NOT NULL,
  `method` varchar(50) NOT NULL,
  `price` varchar(20) NOT NULL,
  `coins` int(11) NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_shop_donate_confirm`
--

CREATE TABLE `z_shop_donate_confirm` (
  `id` int(11) NOT NULL,
  `date` bigint(20) NOT NULL,
  `account_name` varchar(50) NOT NULL,
  `donate_id` int(11) NOT NULL,
  `msg` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_shop_history_item`
--

CREATE TABLE `z_shop_history_item` (
  `id` int(11) NOT NULL,
  `to_name` varchar(255) NOT NULL DEFAULT '0',
  `to_account` int(11) NOT NULL DEFAULT 0,
  `from_nick` varchar(255) NOT NULL,
  `from_account` int(11) NOT NULL DEFAULT 0,
  `price` int(11) NOT NULL DEFAULT 0,
  `offer_id` varchar(255) NOT NULL DEFAULT '',
  `trans_state` varchar(255) NOT NULL,
  `trans_start` int(11) NOT NULL DEFAULT 0,
  `trans_real` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_shop_offer`
--

CREATE TABLE `z_shop_offer` (
  `id` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  `coins` int(11) NOT NULL DEFAULT 0,
  `price` varchar(50) NOT NULL,
  `itemid` int(11) NOT NULL DEFAULT 0,
  `mount_id` varchar(100) NOT NULL,
  `addon_name` varchar(100) NOT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  `offer_type` varchar(255) DEFAULT NULL,
  `offer_description` text NOT NULL,
  `offer_name` varchar(255) NOT NULL,
  `offer_date` int(11) NOT NULL,
  `default_image` varchar(50) NOT NULL,
  `hide` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `z_shop_payment`
--

CREATE TABLE `z_shop_payment` (
  `id` int(11) NOT NULL,
  `ref` varchar(10) NOT NULL,
  `account_name` varchar(50) NOT NULL,
  `service_id` int(11) NOT NULL,
  `service_category_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `price` varchar(50) NOT NULL,
  `coins` int(11) UNSIGNED NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'waiting',
  `date` int(11) NOT NULL,
  `gift` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `name_2` (`name`),
  ADD UNIQUE KEY `name_3` (`name`),
  ADD UNIQUE KEY `name_4` (`name`);

--
-- Índices de tabela `accounts_storage`
--
ALTER TABLE `accounts_storage`
  ADD PRIMARY KEY (`account_id`,`key`);

--
-- Índices de tabela `account_bans`
--
ALTER TABLE `account_bans`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Índices de tabela `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `banned_by` (`banned_by`),
  ADD KEY `account_id_2` (`account_id`),
  ADD KEY `account_id_3` (`account_id`),
  ADD KEY `account_id_4` (`account_id`),
  ADD KEY `account_id_5` (`account_id`),
  ADD KEY `account_id_6` (`account_id`);

--
-- Índices de tabela `account_character_sale`
--
ALTER TABLE `account_character_sale`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_player_UNIQUE` (`id_player`),
  ADD KEY `account_character_sale_ibfk_2` (`id_account`);

--
-- Índices de tabela `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD UNIQUE KEY `account_player_index` (`account_id`,`player_id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `auto_loot_list`
--
ALTER TABLE `auto_loot_list`
  ADD PRIMARY KEY (`player_id`,`item_id`);

--
-- Índices de tabela `blessings_history`
--
ALTER TABLE `blessings_history`
  ADD KEY `blessings_history_ibfk_1` (`player_id`);

--
-- Índices de tabela `daily_reward_history`
--
ALTER TABLE `daily_reward_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `free_pass`
--
ALTER TABLE `free_pass`
  ADD KEY `free_pass_ibfk_1` (`player_id`);

--
-- Índices de tabela `global_storage`
--
ALTER TABLE `global_storage`
  ADD UNIQUE KEY `key` (`key`);

--
-- Índices de tabela `guilds`
--
ALTER TABLE `guilds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `ownerid` (`ownerid`);

--
-- Índices de tabela `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warid` (`warid`);

--
-- Índices de tabela `guild_actions_h`
--
ALTER TABLE `guild_actions_h`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD PRIMARY KEY (`player_id`,`guild_id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Índices de tabela `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `guild_id` (`guild_id`),
  ADD KEY `rank_id` (`rank_id`);

--
-- Índices de tabela `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Índices de tabela `guild_transfer_h`
--
ALTER TABLE `guild_transfer_h`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `guild_wars`
--
ALTER TABLE `guild_wars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild1` (`guild1`),
  ADD KEY `guild2` (`guild2`);

--
-- Índices de tabela `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`),
  ADD KEY `town_id` (`town_id`);

--
-- Índices de tabela `house_lists`
--
ALTER TABLE `house_lists`
  ADD KEY `house_id` (`house_id`);

--
-- Índices de tabela `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD PRIMARY KEY (`ip`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Índices de tabela `live_casts`
--
ALTER TABLE `live_casts`
  ADD UNIQUE KEY `player_id_2` (`player_id`);

--
-- Índices de tabela `market_history`
--
ALTER TABLE `market_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`,`sale`);

--
-- Índices de tabela `market_offers`
--
ALTER TABLE `market_offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale` (`sale`,`itemtype`),
  ADD KEY `created` (`created`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `newsticker`
--
ALTER TABLE `newsticker`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `pagseguro_transactions`
--
ALTER TABLE `pagseguro_transactions`
  ADD UNIQUE KEY `transaction_code` (`transaction_code`,`status`),
  ADD KEY `name` (`name`),
  ADD KEY `status` (`status`);

--
-- Índices de tabela `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `vocation` (`vocation`);

--
-- Índices de tabela `players_online`
--
ALTER TABLE `players_online`
  ADD PRIMARY KEY (`player_id`);

--
-- Índices de tabela `player_binary_items`
--
ALTER TABLE `player_binary_items`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`type`);

--
-- Índices de tabela `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `killed_by` (`killed_by`),
  ADD KEY `mostdamage_by` (`mostdamage_by`);

--
-- Índices de tabela `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Índices de tabela `player_former_names`
--
ALTER TABLE `player_former_names`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `player_hirelings`
--
ALTER TABLE `player_hirelings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `player_inboxitems`
--
ALTER TABLE `player_inboxitems`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Índices de tabela `player_items`
--
ALTER TABLE `player_items`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `sid` (`sid`);

--
-- Índices de tabela `player_kills`
--
ALTER TABLE `player_kills`
  ADD KEY `player_kills_ibfk_1` (`player_id`),
  ADD KEY `player_kills_ibfk_2` (`target`);

--
-- Índices de tabela `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `namelocked_by` (`namelocked_by`);

--
-- Índices de tabela `player_preydata`
--
ALTER TABLE `player_preydata`
  ADD PRIMARY KEY (`player_id`);

--
-- Índices de tabela `player_rewards`
--
ALTER TABLE `player_rewards`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Índices de tabela `player_spells`
--
ALTER TABLE `player_spells`
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `player_storage`
--
ALTER TABLE `player_storage`
  ADD PRIMARY KEY (`player_id`,`key`);

--
-- Índices de tabela `prey_slots`
--
ALTER TABLE `prey_slots`
  ADD KEY `player_id` (`player_id`);

--
-- Índices de tabela `sellchar`
--
ALTER TABLE `sellchar`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `sell_players`
--
ALTER TABLE `sell_players`
  ADD PRIMARY KEY (`player_id`);

--
-- Índices de tabela `sell_players_history`
--
ALTER TABLE `sell_players_history`
  ADD PRIMARY KEY (`player_id`,`buytime`) USING BTREE;

--
-- Índices de tabela `server_config`
--
ALTER TABLE `server_config`
  ADD PRIMARY KEY (`config`);

--
-- Índices de tabela `snowballwar`
--
ALTER TABLE `snowballwar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`);

--
-- Índices de tabela `store_history`
--
ALTER TABLE `store_history`
  ADD KEY `store_history_ibfk_1` (`accountid`);

--
-- Índices de tabela `store_history_old`
--
ALTER TABLE `store_history_old`
  ADD KEY `account_id` (`account_id`);

--
-- Índices de tabela `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`ticket_id`),
  ADD KEY `tickets_ibfk_1` (`ticket_author_acc_id`);

--
-- Índices de tabela `tickets_reply`
--
ALTER TABLE `tickets_reply`
  ADD PRIMARY KEY (`reply_id`),
  ADD KEY `tickets_reply_ibfk_1` (`ticket_id`);

--
-- Índices de tabela `tile_store`
--
ALTER TABLE `tile_store`
  ADD KEY `house_id` (`house_id`);

--
-- Índices de tabela `z_forum`
--
ALTER TABLE `z_forum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `section` (`section`);

--
-- Índices de tabela `z_ots_comunication`
--
ALTER TABLE `z_ots_comunication`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `z_ots_guildcomunication`
--
ALTER TABLE `z_ots_guildcomunication`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `z_shop_category`
--
ALTER TABLE `z_shop_category`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `z_shop_donates`
--
ALTER TABLE `z_shop_donates`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `z_shop_donate_confirm`
--
ALTER TABLE `z_shop_donate_confirm`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `z_shop_offer`
--
ALTER TABLE `z_shop_offer`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `z_shop_payment`
--
ALTER TABLE `z_shop_payment`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8421;

--
-- AUTO_INCREMENT de tabela `account_ban_history`
--
ALTER TABLE `account_ban_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de tabela `account_character_sale`
--
ALTER TABLE `account_character_sale`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=563;

--
-- AUTO_INCREMENT de tabela `daily_reward_history`
--
ALTER TABLE `daily_reward_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75041;

--
-- AUTO_INCREMENT de tabela `guilds`
--
ALTER TABLE `guilds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de tabela `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=667;

--
-- AUTO_INCREMENT de tabela `guild_actions_h`
--
ALTER TABLE `guild_actions_h`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guild_ranks`
--
ALTER TABLE `guild_ranks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=269;

--
-- AUTO_INCREMENT de tabela `guild_transfer_h`
--
ALTER TABLE `guild_transfer_h`
  MODIFY `id` int(6) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guild_wars`
--
ALTER TABLE `guild_wars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de tabela `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2501;

--
-- AUTO_INCREMENT de tabela `market_history`
--
ALTER TABLE `market_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201750;

--
-- AUTO_INCREMENT de tabela `market_offers`
--
ALTER TABLE `market_offers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63544;

--
-- AUTO_INCREMENT de tabela `newsticker`
--
ALTER TABLE `newsticker`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de tabela `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11910;

--
-- AUTO_INCREMENT de tabela `player_former_names`
--
ALTER TABLE `player_former_names`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `player_hirelings`
--
ALTER TABLE `player_hirelings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `sellchar`
--
ALTER TABLE `sellchar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `snowballwar`
--
ALTER TABLE `snowballwar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tickets`
--
ALTER TABLE `tickets`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=443;

--
-- AUTO_INCREMENT de tabela `tickets_reply`
--
ALTER TABLE `tickets_reply`
  MODIFY `reply_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=408;

--
-- AUTO_INCREMENT de tabela `z_forum`
--
ALTER TABLE `z_forum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de tabela `z_ots_comunication`
--
ALTER TABLE `z_ots_comunication`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `z_ots_guildcomunication`
--
ALTER TABLE `z_ots_guildcomunication`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `z_shop_category`
--
ALTER TABLE `z_shop_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `z_shop_donates`
--
ALTER TABLE `z_shop_donates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=878;

--
-- AUTO_INCREMENT de tabela `z_shop_donate_confirm`
--
ALTER TABLE `z_shop_donate_confirm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=239;

--
-- AUTO_INCREMENT de tabela `z_shop_offer`
--
ALTER TABLE `z_shop_offer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `z_shop_payment`
--
ALTER TABLE `z_shop_payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `accounts_storage`
--
ALTER TABLE `accounts_storage`
  ADD CONSTRAINT `accounts_storage_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `account_bans`
--
ALTER TABLE `account_bans`
  ADD CONSTRAINT `account_bans_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_bans_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD CONSTRAINT `account_ban_history_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_ban_history_ibfk_3` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_ban_history_ibfk_4` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_ban_history_ibfk_5` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_ban_history_ibfk_6` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_ban_history_ibfk_7` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `account_character_sale`
--
ALTER TABLE `account_character_sale`
  ADD CONSTRAINT `account_character_sale_ibfk_1` FOREIGN KEY (`id_player`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_character_sale_ibfk_2` FOREIGN KEY (`id_account`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD CONSTRAINT `account_viplist_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_viplist_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `auto_loot_list`
--
ALTER TABLE `auto_loot_list`
  ADD CONSTRAINT `auto_loot_list_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `blessings_history`
--
ALTER TABLE `blessings_history`
  ADD CONSTRAINT `blessings_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `free_pass`
--
ALTER TABLE `free_pass`
  ADD CONSTRAINT `free_pass_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guilds`
--
ALTER TABLE `guilds`
  ADD CONSTRAINT `guilds_ibfk_1` FOREIGN KEY (`ownerid`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD CONSTRAINT `guildwar_kills_ibfk_1` FOREIGN KEY (`warid`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD CONSTRAINT `guild_invites_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_invites_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD CONSTRAINT `guild_membership_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_ibfk_3` FOREIGN KEY (`rank_id`) REFERENCES `guild_ranks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD CONSTRAINT `guild_ranks_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `house_lists`
--
ALTER TABLE `house_lists`
  ADD CONSTRAINT `house_lists_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD CONSTRAINT `ip_bans_ibfk_1` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `live_casts`
--
ALTER TABLE `live_casts`
  ADD CONSTRAINT `live_casts_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `market_history`
--
ALTER TABLE `market_history`
  ADD CONSTRAINT `market_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `market_offers`
--
ALTER TABLE `market_offers`
  ADD CONSTRAINT `market_offers_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_binary_items`
--
ALTER TABLE `player_binary_items`
  ADD CONSTRAINT `player_binary_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD CONSTRAINT `player_deaths_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD CONSTRAINT `player_depotitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_hirelings`
--
ALTER TABLE `player_hirelings`
  ADD CONSTRAINT `player_hirelings_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_inboxitems`
--
ALTER TABLE `player_inboxitems`
  ADD CONSTRAINT `player_inboxitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_items`
--
ALTER TABLE `player_items`
  ADD CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_kills`
--
ALTER TABLE `player_kills`
  ADD CONSTRAINT `player_kills_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `player_kills_ibfk_2` FOREIGN KEY (`target`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD CONSTRAINT `player_namelocks_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `player_namelocks_ibfk_2` FOREIGN KEY (`namelocked_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `player_preydata`
--
ALTER TABLE `player_preydata`
  ADD CONSTRAINT `player_preydata_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `player_rewards`
--
ALTER TABLE `player_rewards`
  ADD CONSTRAINT `player_rewards_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_spells`
--
ALTER TABLE `player_spells`
  ADD CONSTRAINT `player_spells_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `player_storage`
--
ALTER TABLE `player_storage`
  ADD CONSTRAINT `player_storage_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `prey_slots`
--
ALTER TABLE `prey_slots`
  ADD CONSTRAINT `prey_slots_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `sellchar`
--
ALTER TABLE `sellchar`
  ADD CONSTRAINT `sellchar_ibfk_1` FOREIGN KEY (`id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `sell_players`
--
ALTER TABLE `sell_players`
  ADD CONSTRAINT `sell_players_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `sell_players_history`
--
ALTER TABLE `sell_players_history`
  ADD CONSTRAINT `sell_players_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `store_history`
--
ALTER TABLE `store_history`
  ADD CONSTRAINT `store_history_ibfk_1` FOREIGN KEY (`accountid`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `store_history_old`
--
ALTER TABLE `store_history_old`
  ADD CONSTRAINT `store_history_old_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Restrições para tabelas `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_ibfk_1` FOREIGN KEY (`ticket_author_acc_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `tickets_reply`
--
ALTER TABLE `tickets_reply`
  ADD CONSTRAINT `tickets_reply_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`ticket_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Restrições para tabelas `tile_store`
--
ALTER TABLE `tile_store`
  ADD CONSTRAINT `tile_store_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
