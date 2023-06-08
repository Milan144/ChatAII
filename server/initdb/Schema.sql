USE chataii;
-- --------------------------------------------------------

--
-- Structure de la table `character`
--

CREATE TABLE `characterai`
(
    characterId INT NOT NULL,
    name        VARCHAR(255),
    history     VARCHAR(6000),
    universeId  int DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = latin1;

-- --------------------------------------------------------

--
-- Structure de la table `conversation`
--

CREATE TABLE `conversation`
(
    `conversationId` int(11) NOT NULL,
    `characterId`    int(11)      DEFAULT NULL,
    `userId`         varchar(255) DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = latin1;

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

CREATE TABLE `message`
(
    `messageId`      int(11) NOT NULL,
    `conversationId` int(11)       DEFAULT NULL,
    `message`        varchar(6000) DEFAULT NULL,
    `response`       varchar(6000) DEFAULT NULL

) ENGINE = InnoDB
  DEFAULT CHARSET = latin1;

-- --------------------------------------------------------

--
-- Structure de la table `universe`
--

CREATE TABLE `universe`
(
    `universeId` int(11) NOT NULL,
    `name`       varchar(255) DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = latin1;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user`
(
    userId     INT          NOT NULL,
    `username` varchar(255) NOT NULL,
    `password` varchar(255) DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = latin1;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `character`
--
ALTER TABLE `characterai`
    ADD PRIMARY KEY (`characterId`),
    ADD KEY `universeId` (`universeId`);

--
-- Index pour la table `conversation`
--
ALTER TABLE `conversation`
    ADD PRIMARY KEY (`conversationId`),
    ADD KEY `characterId` (`characterId`),
    ADD KEY `userId` (`userId`);

--
-- Index pour la table `message`
--
ALTER TABLE `message`
    ADD PRIMARY KEY (`messageId`),
    ADD KEY `conversationId` (`conversationId`);

--
-- Index pour la table `universe`
--
ALTER TABLE `universe`
    ADD PRIMARY KEY (`universeId`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
    ADD PRIMARY KEY (`userId`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `character`
--
ALTER TABLE `characterai`
    MODIFY `characterId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `conversation`
--
ALTER TABLE `conversation`
    MODIFY `conversationId` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `user`
    MODIFY `userId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `message`
--
ALTER TABLE `message`
    MODIFY `messageId` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `universe`
--
ALTER TABLE `universe`
    MODIFY `universeId` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `character`
--
ALTER TABLE `characterai`
    ADD CONSTRAINT `character_ibfk_1` FOREIGN KEY (`universeId`) REFERENCES `universe` (`universeId`);

--
-- Contraintes pour la table `conversation`
--
ALTER TABLE `conversation`
    ADD CONSTRAINT `conversation_ibfk_1` FOREIGN KEY (`characterId`) REFERENCES `characterai` (`characterId`),
    ADD CONSTRAINT `conversation_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`username`);

--
-- Contraintes pour la table `message`
--
ALTER TABLE `message`
    ADD CONSTRAINT `message_ibfk_1` FOREIGN KEY (`conversationId`) REFERENCES `conversation` (`conversationId`);
COMMIT;


-- Creating test data

-- Insert test data into the `universe` table
INSERT INTO `universe` (`universeId`, `name`)
VALUES (1, 'League of Legends');

-- Insert test data into the `characterai` table
INSERT INTO `characterai` (`characterId`, `name`, `history`, `universeId`)
VALUES (1, 'Gangplank', 'A pirate from bilgewater', 1);

-- Insert test data into the `conversation` table
INSERT INTO `conversation` (`conversationId`, `characterId`, `userId`)
VALUES (1, 1, 1);

-- Insert test data into the `message` table
INSERT INTO `message` (`messageId`, `content`, `conversationId`)
VALUES (1, 'Test message', 1);

-- Insert test data into the `user` table
INSERT INTO `user` (`userId`, `username`, `password`)
VALUES (1, 'test', 'test');
