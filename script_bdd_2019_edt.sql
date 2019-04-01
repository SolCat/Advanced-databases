-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8889
-- Généré le :  sam. 30 mars 2019 à 20:29
-- Version du serveur :  5.6.35
-- Version de PHP :  7.1.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Base de données :  `bdd_2019`
--

-- --------------------------------------------------------

--
-- Structure de la table `Activite`
--

CREATE TABLE `Activite` (
  `idActivite` int(11) NOT NULL,
  `nomActivite` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `Date`
--

CREATE TABLE `Date` (
  `idDate` int(11) NOT NULL,
  `annee` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `Foyer`
--

CREATE TABLE `Foyer` (
  `idFoyer` int(11) NOT NULL,
  `taille` int(11) NOT NULL,
  `lieuResidence` varchar(50) NOT NULL,
  `aOrdinateur` varchar(50) DEFAULT NULL,
  `aVehicule` varchar(50) DEFAULT NULL,
  `ageBenjamin` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `Pays`
--

CREATE TABLE `Pays` (
  `idPays` int(11) NOT NULL,
  `nomPays` varchar(100) NOT NULL,
  `region` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `Personne`
--

CREATE TABLE `Personne` (
  `idPersonne` int(11) NOT NULL,
  `age` int(11) NOT NULL,
  `sexe` varchar(50) NOT NULL,
  `sante` varchar(50) NOT NULL,
  `situationMaritale` varchar(50) NOT NULL,
  `estCitoyen` varchar(50) NOT NULL,
  `niveauEtudes` varchar(50) DEFAULT NULL,
  `aHandicap` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `SituationPro`
--

CREATE TABLE `SituationPro` (
  `idSituationPro` int(11) NOT NULL,
  `situation` varchar(100) DEFAULT NULL,
  `revenu` varchar(100) DEFAULT NULL,
  `secteur` varchar(100) DEFAULT NULL,
  `typeEmploi` varchar(100) DEFAULT NULL,
  `typeEmploiConjoint` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `tableFaits`
--

CREATE TABLE `tableFaits` (
  `idTableFaits` int(11) NOT NULL,
  `idPersonne` int(11) NOT NULL,
  `idFoyer` int(11) NOT NULL,
  `idActivite` int(11) NOT NULL,
  `idPays` int(11) NOT NULL,
  `idDate` int(11) NOT NULL,
  `tempsActiviteMinute` int(11) NOT NULL,
  `tempsActiviteHeure` int(11) DEFAULT NULL,
  `tempsActiviteMatin` int(11) DEFAULT NULL,
  `tempsActiviteApresMidi` int(11) DEFAULT NULL,
  `tempsActiviteSoir` int(11) DEFAULT NULL,
  `tempsActiviteNuit` int(11) DEFAULT NULL,
  `idSituationPro` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Activite`
--
ALTER TABLE `Activite`
  ADD PRIMARY KEY (`idActivite`);

--
-- Index pour la table `Date`
--
ALTER TABLE `Date`
  ADD PRIMARY KEY (`idDate`);

--
-- Index pour la table `Foyer`
--
ALTER TABLE `Foyer`
  ADD PRIMARY KEY (`idFoyer`);

--
-- Index pour la table `Pays`
--
ALTER TABLE `Pays`
  ADD PRIMARY KEY (`idPays`);

--
-- Index pour la table `Personne`
--
ALTER TABLE `Personne`
  ADD PRIMARY KEY (`idPersonne`);

--
-- Index pour la table `SituationPro`
--
ALTER TABLE `SituationPro`
  ADD PRIMARY KEY (`idSituationPro`);

--
-- Index pour la table `tableFaits`
--
ALTER TABLE `tableFaits`
  ADD PRIMARY KEY (`idTableFaits`),
  ADD KEY `fk_idPersonne` (`idPersonne`),
  ADD KEY `fk_idFoyer` (`idFoyer`),
  ADD KEY `fk_idActivite` (`idActivite`),
  ADD KEY `fk_idPays` (`idPays`),
  ADD KEY `fk_idDate` (`idDate`),
  ADD KEY `kf_idSituationPro` (`idSituationPro`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `tableFaits`
--
ALTER TABLE `tableFaits`
  MODIFY `idTableFaits` int(11) NOT NULL AUTO_INCREMENT;
--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `tableFaits`
--
ALTER TABLE `tableFaits`
  ADD CONSTRAINT `fk_idActivite` FOREIGN KEY (`idActivite`) REFERENCES `Activite` (`idActivite`),
  ADD CONSTRAINT `fk_idDate` FOREIGN KEY (`idDate`) REFERENCES `Date` (`idDate`),
  ADD CONSTRAINT `fk_idFoyer` FOREIGN KEY (`idFoyer`) REFERENCES `Foyer` (`idFoyer`),
  ADD CONSTRAINT `fk_idPays` FOREIGN KEY (`idPays`) REFERENCES `Pays` (`idPays`),
  ADD CONSTRAINT `fk_idPersonne` FOREIGN KEY (`idPersonne`) REFERENCES `Personne` (`idPersonne`),
  ADD CONSTRAINT `kf_idSituationPro` FOREIGN KEY (`idSituationPro`) REFERENCES `SituationPro` (`idSituationPro`);
