CREATE DATABASE chataii;
USE chataii;
-- --------------------------------------------------------

--
-- Structure de la table `Character`
--

CREATE TABLE `Character` (
  `characterId` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `universeId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Conversation`
--

CREATE TABLE `Conversation` (
  `conversationId` int(11) NOT NULL,
  `characterId` int(11) DEFAULT NULL,
  `userId` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Message`
--

CREATE TABLE `Message` (
  `messageId` int(11) NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `conversationId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Universe`
--

CREATE TABLE `Universe` (
  `universeId` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `User`
--

CREATE TABLE `User` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `User`
--

INSERT INTO `User` (`username`, `password`) VALUES
('test', 'root');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Character`
--
ALTER TABLE `Character`
  ADD PRIMARY KEY (`characterId`),
  ADD KEY `universeId` (`universeId`);

--
-- Index pour la table `Conversation`
--
ALTER TABLE `Conversation`
  ADD PRIMARY KEY (`conversationId`),
  ADD KEY `characterId` (`characterId`),
  ADD KEY `userId` (`userId`);

--
-- Index pour la table `Message`
--
ALTER TABLE `Message`
  ADD PRIMARY KEY (`messageId`),
  ADD KEY `conversationId` (`conversationId`);

--
-- Index pour la table `Universe`
--
ALTER TABLE `Universe`
  ADD PRIMARY KEY (`universeId`);

--
-- Index pour la table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Character`
--
ALTER TABLE `Character`
  MODIFY `characterId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Conversation`
--
ALTER TABLE `Conversation`
  MODIFY `conversationId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Message`
--
ALTER TABLE `Message`
  MODIFY `messageId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Universe`
--
ALTER TABLE `Universe`
  MODIFY `universeId` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Character`
--
ALTER TABLE `Character`
  ADD CONSTRAINT `Character_ibfk_1` FOREIGN KEY (`universeId`) REFERENCES `Universe` (`universeId`);

--
-- Contraintes pour la table `Conversation`
--
ALTER TABLE `Conversation`
  ADD CONSTRAINT `Conversation_ibfk_1` FOREIGN KEY (`characterId`) REFERENCES `Character` (`characterId`),
  ADD CONSTRAINT `Conversation_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `User` (`username`);

--
-- Contraintes pour la table `Message`
--
ALTER TABLE `Message`
  ADD CONSTRAINT `Message_ibfk_1` FOREIGN KEY (`conversationId`) REFERENCES `Conversation` (`conversationId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
