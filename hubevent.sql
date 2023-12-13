-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : mer. 13 déc. 2023 à 20:45
-- Version du serveur : 8.0.30
-- Version de PHP : 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `hubevent`
--

-- --------------------------------------------------------

--
-- Structure de la table `events`
--

CREATE TABLE `events` (
  `EventID` int NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `date` date DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `UserID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `events`
--

INSERT INTO `events` (`EventID`, `title`, `description`, `date`, `category`, `UserID`) VALUES
(13, 'Node js', 'Le sujet Node.Js est associé aux sujets Développement Informatique et logiciels\r\n', '2023-11-30', 'Formation', 11),
(14, 'Python', 'Take your skills to a new level and join millions of users that have learned Python. Master your language with lessons, quizzes, and projects designed for real-life scenarios.', '2023-11-28', 'Formation', 12),
(24, 'course HTML', 'course html', '2023-12-20', 'Formation', 1);

-- --------------------------------------------------------

--
-- Structure de la table `participant`
--

CREATE TABLE `participant` (
  `idparticipant` int NOT NULL,
  `description` varchar(255) NOT NULL,
  `userID` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `participes`
--

CREATE TABLE `participes` (
  `EventID` int NOT NULL,
  `idParticipant` int NOT NULL,
  `DateParticipation` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `UserID` int NOT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `specialty` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `number` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`UserID`, `firstName`, `lastName`, `specialty`, `Email`, `password`, `number`) VALUES
(1, 'chayma', 'bounawara', 'hhhhhh', 'mostafachayma@gmail.com', 'yassine90', '58043132'),
(11, 'Sassi', 'Rayen', 'MDW', 'rayensassi@gmail.com', 'rayen90', '55098765'),
(12, 'Laaribi', 'Mohammed', 'DSI', 'laaribimohammed@gmail.com', 'laaribimohammed90', '56789456'),
(13, 'bounawara', 'walid', 'MDW', 'walidbounawara@gmail.com', 'walid90', '55321980'),
(14, 'farid', 'fourat', 'DSI', 'farid@gmail.com', 'farid90', '99808678');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`EventID`),
  ADD KEY `fk_user` (`UserID`);

--
-- Index pour la table `participant`
--
ALTER TABLE `participant`
  ADD PRIMARY KEY (`idparticipant`),
  ADD KEY `fk_participant_user` (`userID`);

--
-- Index pour la table `participes`
--
ALTER TABLE `participes`
  ADD PRIMARY KEY (`EventID`,`idParticipant`),
  ADD KEY `idParticipant` (`idParticipant`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `events`
--
ALTER TABLE `events`
  MODIFY `EventID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pour la table `participant`
--
ALTER TABLE `participant`
  MODIFY `idparticipant` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `events_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `fk_user` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE;

--
-- Contraintes pour la table `participant`
--
ALTER TABLE `participant`
  ADD CONSTRAINT `fk_participant_user` FOREIGN KEY (`userID`) REFERENCES `users` (`UserID`);

--
-- Contraintes pour la table `participes`
--
ALTER TABLE `participes`
  ADD CONSTRAINT `participes_ibfk_1` FOREIGN KEY (`EventID`) REFERENCES `events` (`EventID`),
  ADD CONSTRAINT `participes_ibfk_2` FOREIGN KEY (`idParticipant`) REFERENCES `participant` (`idparticipant`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
