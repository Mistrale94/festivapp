-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 11 août 2022 à 02:37
-- Version du serveur : 5.7.36
-- Version de PHP : 8.0.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `festivapp`
--

-- --------------------------------------------------------

--
-- Structure de la table `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9474526C4B89032C` (`post_id`),
  KEY `IDX_9474526CA76ED395` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `comment`
--

INSERT INTO `comment` (`id`, `comment`, `post_id`, `user_id`) VALUES
(1, 'test', 1, 1),
(2, 'test', 1, 1),
(3, 'test2', 1, 1),
(4, 'test truc 2', 9, 1),
(5, 'test css', 9, 1),
(6, 'yes', 9, 2);

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20220729161021', '2022-07-29 16:10:38', 122),
('DoctrineMigrations\\Version20220729205234', '2022-07-29 20:52:51', 213),
('DoctrineMigrations\\Version20220729205748', '2022-07-29 20:57:55', 238),
('DoctrineMigrations\\Version20220729210452', '2022-07-29 21:05:01', 227),
('DoctrineMigrations\\Version20220730155718', '2022-07-30 15:57:36', 210),
('DoctrineMigrations\\Version20220805155429', '2022-08-05 15:54:39', 189),
('DoctrineMigrations\\Version20220805220236', '2022-08-05 22:02:44', 234),
('DoctrineMigrations\\Version20220805221400', '2022-08-05 22:14:08', 137),
('DoctrineMigrations\\Version20220805221555', '2022-08-05 22:17:15', 220),
('DoctrineMigrations\\Version20220809200741', '2022-08-09 20:08:13', 227),
('DoctrineMigrations\\Version20220809215654', '2022-08-09 21:57:02', 147),
('DoctrineMigrations\\Version20220810151547', '2022-08-10 15:15:53', 363),
('DoctrineMigrations\\Version20220810151750', '2022-08-10 15:17:56', 145),
('DoctrineMigrations\\Version20220810165119', '2022-08-10 16:51:25', 305);

-- --------------------------------------------------------

--
-- Structure de la table `like`
--

DROP TABLE IF EXISTS `like`;
CREATE TABLE IF NOT EXISTS `like` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `love` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_AC6340B3A76ED395` (`user_id`),
  KEY `IDX_AC6340B34B89032C` (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `like`
--

INSERT INTO `like` (`id`, `user_id`, `post_id`, `love`) VALUES
(7, 1, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `post`
--

DROP TABLE IF EXISTS `post`;
CREATE TABLE IF NOT EXISTS `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `likes` bigint(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_5A8A6C8DA76ED395` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `post`
--

INSERT INTO `post` (`id`, `image`, `description`, `user_id`, `likes`) VALUES
(1, '1.png', 'test', 2, NULL),
(9, 'circuit1-62eaa00b97f18545374066.png', '32', 1, NULL),
(10, 'circuit1-62f27b12757cb609833128.png', 'test', 1, NULL),
(11, '1-62f27b2858657037662599.png', 'test', 1, NULL),
(12, 'circuit1-62f27b3842b49645914963.png', 'test', 1, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `reset_password_request`
--

DROP TABLE IF EXISTS `reset_password_request`;
CREATE TABLE IF NOT EXISTS `reset_password_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `selector` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hashed_token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `expires_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_7CE748AA76ED395` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `username`, `description`, `avatar`) VALUES
(1, 'Quat94@gmail.com', '[\"ROLE_USER\"]', '$2y$13$612ecbFCBMrkOUBAcdr2kufZMqRyx9HtnYp3NeW590fIRo9SVBEtO', 'quentinlap', 'test de description modifié je voudrai voir si une description bien longue marcherai sur le profile', '1-62f27609ab6d0789626932.png'),
(2, 'quentin-lapujade@gmail.com', '[\"ROLE_USER\"]', '$2y$13$cfNNWr96v007Cs8J5Es0juEww9/g08zYhDpMMnszd2eCrOGvFtmeK', 'quentinlap3', NULL, NULL),
(3, 'Quat94300@gmail.com', '[\"ROLE_USER\"]', '$2y$13$iuZh.A1eP90GckoPcjW7E.ELAMBt66oYk8Tr.ylZS7CdHXYv/ncu.', 'steven', NULL, NULL),
(4, 'Quat94301@gmail.com', '[\"ROLE_USER\"]', '$2y$13$Y1Hy8/kPeGDLpB/dA9tADu2XRDFwxM4NFGYCxhLRmayGyZDuijhzG', 'nico', NULL, 'circuit1-62e83305020a1980635428.png'),
(5, 'Quat94302@gmail.com', '[\"ROLE_USER\"]', '$2y$13$FHEIAN1dKVhFf9Wcg3WvzuOs6jVUFgekVl769vwM8qpgNjplRE.ti', 'paul', NULL, '1-62e833626125a268945440.png'),
(6, 'Quat94303@gmail.com', '[\"ROLE_USER\"]', '$2y$13$nAMS6yTKcydBIC0rDFB7SOch58txm51pAqJWNPBp3nNm1pzAx.8Si', 'nicolas', NULL, '1-62e833a8646c7630627030.png'),
(7, 'Quat94304@gmail.com', '[\"ROLE_USER\"]', '$2y$13$HH0iNcoIpstdUY9jhCzAbuGsEd3Tnc7OmsRYXm8YlPN9nm46Aio6e', 'elie', NULL, '1-62e8351c59215458215360.png'),
(8, 'Quat94305@gmail.com', '[\"ROLE_USER\"]', '$2y$13$63ZZ8c39qxR0MWS1vkUp1OHX5mTnHioiojIEhqUKIIGBny7f0QSuy', 'clement', NULL, '1-62e835a557e62098510308.png'),
(9, 'Quat94306@gmail.com', '[\"ROLE_USER\"]', '$2y$13$.eFYuhrbZxeIsuc1O7AbweVVBIE.3KLer98T6s49mcAg6hfZvSBK.', 'rafou', NULL, '1-62e836961d05b694532557.png');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `FK_9474526C4B89032C` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
  ADD CONSTRAINT `FK_9474526CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `like`
--
ALTER TABLE `like`
  ADD CONSTRAINT `FK_AC6340B34B89032C` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
  ADD CONSTRAINT `FK_AC6340B3A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `FK_5A8A6C8DA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD CONSTRAINT `FK_7CE748AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
