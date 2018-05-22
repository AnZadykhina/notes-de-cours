SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema erasmus
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `erasmus` ;

-- -----------------------------------------------------
-- Schema erasmus
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `erasmus` DEFAULT CHARACTER SET utf8 ;
USE `erasmus` ;

-- -----------------------------------------------------
-- Table `erasmus`.`edition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erasmus`.`edition` ;

CREATE TABLE IF NOT EXISTS `erasmus`.`edition` (
  `edition_id` INT NOT NULL AUTO_INCREMENT,
  `edition_short_title` Text NULL,
  `edition_title` TEXT NULL,
  `edition_uniform_title` TEXT NULL,
  `edition_parallel_title` TEXT NULL,
  `edition_author_first` Text NOT NULL,
  `edition_author_second` Varchar(40) default 'inconnu',
  `edition_publisher` Text NULL,
  `edition_translator` Text NULL,
  `edition_dateInferred` Text NULL,
  `edition_displayDate` Text NULL,
  `edition_cleanDate` INT(4) NULL,
  `edition_languages` Text NULL,
  `edition_placeInferred` Text NULL,
  `edition_place` Text NULL,
  `edition_placeClean` Text NULL,
  `edition_country` Text NULL,
  `edition_collator_format` INT NULL,
  `edition_collator_formatNotes` INT NULL,
  `edition_imprint` Text NULL,
  `edition_collator_signatures` TEXT NULL,
  `edition_collator_PpFf` TEXT NULL,
  `edition_collator_pages` INT NULL,
  `edition_collator_remarks` TEXT NULL,
  `edition_collator_colophon` TEXT NULL,
  `edition_collator_illustrated` BIT,
  `edition_collator_typographicMaterial` TEXT NULL,
  `edition_collator_sheets` TEXT NULL,
  `edition_collator_typeNotes` TEXT NULL,
  `edition_collator_stcNotes` TEXT NULL,
  `edition_collator_fb` INT NULL,
  `edition_collator_nb` INT NULL,
  `edition_collator_ib` INT NULL,
  `edition_collator_correct` BIT,
  `edition_collator_locFingerprints` TEXT NULL,
  `edition_collator_stcnFingerprints` TEXT NULL,
  `edition_notes` Text NULL,
  `edition_class0` Text NULL,
  `edition_class1` Text NULL,
  `edition_class2` Text NULL,
  `edition_digital` INT NULL,
  `edition_fulltext` INT NULL,
  `edition_tpimage` INT NULL,
  `edition_privelege` INT NULL,
  `edition_dedication` INT NULL,
  `edition_permission` INT NULL,
  `edition_reference` INT NULL,
  `edition_location` INT NULL,
  `edition_citation` INT NULL,
  PRIMARY KEY (`edition_id`))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `erasmus`.`authorite`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erasmus`.`authorite` ;

CREATE TABLE IF NOT EXISTS `erasmus`.`authorite` (
  `authorite_id` INT NOT NULL AUTO_INCREMENT,
  `authorite_forme_retenue` Text NOT NULL,
  `authorite_forme_rejetee` Text NULL,
  `authorite_edition_id` INT NULL,
  
  PRIMARY KEY (`authorite_id`))
  
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `erasmus`.`bibiliothecae`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erasmus`.`bibliothecae` ;

CREATE TABLE IF NOT EXISTS `erasmus`.`bibliothecae` (
  `bibliothecae_id` VARCHAR(4) NOT NULL,
  `bibliothecae_library` Text NULL,
  `bibliothecae_web` Text NULL,
  `bibliothecae_weighting` Text NULL,
  
  PRIMARY KEY (`bibliothecae_id`))
  
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `erasmus`.`exemplaire`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erasmus`.`exemplaire` ;

CREATE TABLE IF NOT EXISTS `erasmus`.`exemplaire` (
  `exemplaire_id` INT NOT NULL AUTO_INCREMENT,
  `exemplaire_sn` INT NULL,
  `exemplaire_library_code` VARCHAR(4)  NOT NULL,
  `exemplaire_library_code_text` TEXT NULL,
  `exemplaire_pressmark` TEXT NULL,
  `exemplaire_size` TEXT NULL,
  `exemplaire_exemp_status` TEXT NULL,
  `exemplaire_digitalURL` TEXT NULL,
  `exemplaire_provider` TEXT NULL,
  `exemplaire_collator_PpFf` TEXT NULL,
  `exemplaire_notes` TEXT NULL,
  `exemplaire_locFingerprint` TEXT NULL,
  `exemplaire_stcnFingerprint` TEXT NULL,
  `exemplaire_statusLevel` TEXT NULL,
  `exemplaire_in` TEXT NULL,
  `exemplaire_dateSeen` TEXT NULL,
  `exemplaire_edition_id` INT NULL,
  
  PRIMARY KEY (`exemplaire_id`),
  INDEX `fk_exemplaire_1_idx` (`exemplaire_edition_id` ASC),
  INDEX `fk_exemplaire_2_idx` (`exemplaire_library_code` ASC),
  CONSTRAINT `fk_exemplaire_1`
  FOREIGN KEY (`exemplaire_edition_id`) REFERENCES `erasmus`.`edition`(`edition_id`)ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exemplaire_2`
  FOREIGN KEY (`exemplaire_library_code`) REFERENCES `erasmus`.`bibiliothecae`(`bibliothecae_id`)ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `erasmus`.`reliure`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erasmus`.`reliure` ;

CREATE TABLE IF NOT EXISTS `erasmus`.`reliure` (
  `reliure_id` INT NOT NULL AUTO_INCREMENT,
  `reliure_material` TEXT NULL,
  `reliure_description_det` TEXT NULL,
  `reliure_attribution` TEXT NULL,
  `reliure_century` Text NULL,
  `reliure_place` TEXT NULL,
  `reliure_exemplaire_id` INT NOT NULL,
  
  PRIMARY KEY (`reliure_id`),
  INDEX `fk_reliure_1_idx` (`reliure_exemplaire_id` ASC),
  CONSTRAINT `fk_reliure_1`
  FOREIGN KEY (`reliure_exemplaire_id`) REFERENCES `erasmus`.`exemplaire`(`exemplaire_id`)ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `erasmus`.`exemp_reliure`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erasmus`.`edit_author` ;

CREATE TABLE IF NOT EXISTS `erasmus`.`edit_author` (
  `edit_author_id` INT NOT NULL AUTO_INCREMENT,
  `edit_author_edition_id` INT NOT NULL,
  `edit_author_authorite_id` INT NOT NULL,
  
   PRIMARY KEY (`edit_author_id`),
  INDEX `fk_edit_author_1_idx` (`edit_author_edition_id` ASC),
  INDEX `fk_edit_author_2_idx` (`edit_author_authorite_id` ASC),
  CONSTRAINT `fk_edit_author_1`
    FOREIGN KEY (`edit_author_edition_id`)
    REFERENCES `erasmus`.`edition` (`edition_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_edit_author_2`
    FOREIGN KEY (`edit_author_authorite_id`)
    REFERENCES `erasmus`.`authorite` (`authorite_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `erasmus`.`collator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erasmus`.`collator` ;

CREATE TABLE IF NOT EXISTS `erasmus`.`collator` (
  `collator_id` INT NOT NULL AUTO_INCREMENT,
  `collator_sn` INT NOT NULL,
  `collator_format` INT NULL,
  `collator_cleanFormat` INT NULL,
  `collator_signatures` TEXT NULL,
  `collator_PpFf` TEXT NULL,
  `collator_pages` INT NULL,
  `collator_remarks` TEXT NULL,
  `collator_colophon` TEXT NULL,
  `collator_date` TEXT NULL,
  `collator_displayDate` TEXT NULL,
  `collator_cleanDate` TEXT NULL,
  `collator_notes` TEXT NULL,
  `collator_illustrated` BIT,
  `collator_typographicMaterial` TEXT NULL,
  `collator_sheets` TEXT NULL,
  `collator_typeNotes` TEXT NULL,
  `collator_stcNotes` TEXT NULL,
  `collator_fb` INT NULL,
  `collator_nb` INT NULL,
  `collator_ib` INT NULL,
  `collator_correct` BIT,
  `collator_locFingerprints` TEXT NULL,
  `collator_stcnFingerprints` TEXT NULL,
  `collator_dimensions` TEXT NULL,
  `collator_digitaLink` TEXT NULL,
  `collator_tpt` TEXT NULL,
  `collator_shortTitle` Text NULL,
  `collator_titleNotes` TEXT NULL,
  `collator_languages` TEXT NULL,
  `collator_UstcLanguages` TEXT NULL,
  `collator_place` TEXT NULL,
  `collator_country` TEXT NULL,
  `collator_countryCode` Text NULL,
  `collator_imprint` TEXT NULL,
  `collator_class1` TEXT NULL,
  `collator_class2` TEXT NULL,
  `collator_edition_id` INT NULL,
   PRIMARY KEY (`collator_id`),
   INDEX `fk_collator_1_idx` (`collator_edition_id` ASC),
   CONSTRAINT `fk_collator_1`
    FOREIGN KEY (`collator_edition_id`)
    REFERENCES `erasmus`.`edition` (`edition_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `erasmus`.`reference`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erasmus`.`reference` ;

CREATE TABLE IF NOT EXISTS `erasmus`.`reference` (
  `reference_id` INT NOT NULL AUTO_INCREMENT,
  `reference_sn` INT NULL,
  `reference_refSequential` INT NULL,
  `reference_references` TEXT NULL,
  `reference_volume` TEXT NULL,
  `reference_page` Text NULL,
  `reference_recordNumber` TEXT NULL,
  `reference_note` TEXT NULL,
  `reference_bibliographie_id` INT NOT NULL,
  `reference_edition_id` INT NOT NULL,
  
  PRIMARY KEY (`reference_id`),
  INDEX `fk_reference_1_idx` (`reference_bibliographie_id` ASC),
  INDEX `fk_reference_2_idx` (`reference_edition_id` ASC),
  CONSTRAINT `fk_reference_1`
  FOREIGN KEY (`reference_bibliographie_id`) REFERENCES `erasmus`.`bibliographie`(`bibliographie_id`)ON DELETE NO ACTION
    ON UPDATE NO ACTION,
     CONSTRAINT `fk_reference_2`
  FOREIGN KEY (`reference_edition_id`) REFERENCES `erasmus`.`edition`(`edition_id`)ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `erasmus`.`bibiliographie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erasmus`.`bibliographie` ;

CREATE TABLE IF NOT EXISTS `erasmus`.`bibliographie` (
  `bibliographie_id` INT NOT NULL AUTO_INCREMENT,
  `bibliographie_ref_sequential` INT NULL,
  `bibliographie_code` Text NULL,
  `bibliographie_bibliReference` Text NULL,
  `bibliographie_author` Text NULL,
  `bibliographie_title` TEXT NULL,
  `bibliographie_URLLink` TEXT NULL,
  `bibliographie_imprint` TEXT NULL,
  
  
  PRIMARY KEY (`bibliographie_id`))
  
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `erasmus`.`citation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erasmus`.`citation` ;

CREATE TABLE IF NOT EXISTS `erasmus`.`citation` (
  `citation_id` INT NOT NULL AUTO_INCREMENT,
  `citation_dbname` TEXT NULL,
  `citation_dbnumber` TEXT NULL,
  `citation_numberOfDups` INT NULL,
  `citation_url` TEXT NULL,
  `citation_exemplaire_id` INT NULL,
  
  PRIMARY KEY (`citation_id`),
  INDEX `fk_citation_1_idx` (`citation_exemplaire_id` ASC),
  CONSTRAINT `fk_citation_1`
  FOREIGN KEY (`citation_exemplaire_id`) REFERENCES `erasmus`.`exemplaire`(`exemplaire_id`)ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `erasmus`.`digital`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erasmus`.`digital` ;

CREATE TABLE IF NOT EXISTS `erasmus`.`digital` (
  `digital_id` INT NOT NULL AUTO_INCREMENT,
  `digital_sn` INT NULL,
  `digital_url` TEXT NULL,
  `digital_provider` Text NOT NULL,
  `digital_exemplaire_id` INT NOT NULL,
  
  PRIMARY KEY (`digital_id`),
  INDEX `fk_digital_1_idx` (`digital_exemplaire_id` ASC),
  CONSTRAINT `fk_digital_1`
  FOREIGN KEY (`digital_exemplaire_id`) REFERENCES `erasmus`.`exemplaire`(`exemplaire_id`)ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `erasmus`.`digitization`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erasmus`.`digitization` ;

CREATE TABLE IF NOT EXISTS `erasmus`.`digitization` (
  `digitization_id` INT NOT NULL AUTO_INCREMENT,
  `digitization_provider` Text NULL,
  `digitization_fullName` TEXT NULL,
  `digitization_nationality` Text NULL,
  `digitization_status` Text NULL,
  `digitization_web` Text NULL,
  `digitization_address` Text NULL,
  `digitization_town` Text NULL,
  `digitization_country` Text NULL,
  `digitization_postcode` Text NULL,
  `digitization_telephone` Text NULL,
  `digitization_fax` Text NULL,
  `digitization_email` Text NULL,
  `digitization_notes` TEXT NULL,
  `digitization_digital_id` INT NOT NULL,
  
  PRIMARY KEY (`digitization_id`),
  INDEX `fk_digitization_1_idx` (`digitization_digital_id` ASC),
  CONSTRAINT `fk_digitization_1`
  FOREIGN KEY (`digitization_digital_id`) REFERENCES `erasmus`.`digital`(`digital_id`)ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `erasmus`.`provenance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erasmus`.`provenance` ;

CREATE TABLE IF NOT EXISTS `erasmus`.`provenance` (
  `provenance_id` INT NOT NULL AUTO_INCREMENT,
  `provenance_ex-libris` TEXT NULL,
  `provenance_ex-dono` TEXT NULL,
  `provenance_envoi` INT NULL,
  `provenance_notesManuscrites` TEXT NULL,
  `provenance_armesPeintes` TEXT NULL,
  `provenance_restitue` TEXT NULL,
  `provenance_mentionEntree` TEXT NULL,
  `provenance_estampillesCachets` TEXT NULL,
  `provenance_reliure_provenance` TEXT NULL,
  `provenance_exemplaire_id` INT NOT NULL,
  
  PRIMARY KEY (`provenance_id`),
  INDEX `fk_provenance_1_idx` (`provenance_exemplaire_id` ASC),
  CONSTRAINT `fk_provenance_1`
  FOREIGN KEY (`provenance_exemplaire_id`) REFERENCES `erasmus`.`exemplaire`(`exemplaire_id`)ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `erasmus`.`autres_bases`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `erasmus`.`autres_bases` ;

CREATE TABLE IF NOT EXISTS `erasmus`.`autres_bases` (
  `autres_bases_id` INT NOT NULL AUTO_INCREMENT,
  `autres_bases_nom` Text NULL,
  `autres_bases_numero` TEXT NULL,
  `autres_bases_lien` TEXT NULL,
  `autres_bases_exemplaire_id` INT NOT NULL,
  
  PRIMARY KEY (`autres_bases_id`),
  INDEX `fk_autres_bases_1_idx` (`autres_bases_exemplaire_id` ASC),
  CONSTRAINT `fk_autres_bases_1`
  FOREIGN KEY (`autres_bases_exemplaire_id`) REFERENCES `erasmus`.`exemplaire`(`exemplaire_id`)ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  
ENGINE = InnoDB;



SET SQL_MODE = '';
GRANT USAGE ON *.* TO erasmus_user;
 DROP USER erasmus_user;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'erasmus_user' IDENTIFIED BY 'password';

GRANT ALL ON `erasmus`.* TO 'erasmus_user';
GRANT SELECT ON TABLE `erasmus`.* TO 'erasmus_user';
GRANT SELECT, INSERT, TRIGGER ON TABLE `erasmus`.* TO 'erasmus_user';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE `erasmus`.* TO 'erasmus_user';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Datafor table `erasmus`.`edition`
-- -----------------------------------------------------

START TRANSACTION;
USE `erasmus`;
INSERT INTO `erasmus`.`edition` (`edition_id`, `edition_short_title`, `edition_author_first`, `edition_author_second`, `edition_publisher`, `edition_translator`, `edition_dateInferred`, `edition_displayDate`, `edition_cleanDate`, `edition_languages`, `edition_placeInferred`, `edition_place`, `edition_placeClean`, `edition_country`, `edition_imprint`, `edition_class0`, `edition_class1`, `edition_class2`, `edition_digital`, `edition_fulltext`, `edition_tpimage`, `edition_privelege`, `edition_dedication`, `edition_permission`, `edition_reference`, `edition_location`, `edition_citation`) VALUES (0, 'Essaie1', 'Erasmus', 'Desiderius', 'None', 'None', '12345', '123456', '1234567', 'fre', 'France', 'France2', 'Frabce4', 'France pays', 'None', 'None', 'None', 'None', 1, 1, 1, 1, 1, 1, 1, 1, 1);

COMMIT;

START TRANSACTION;
USE `erasmus`;
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (1,1,'Adams','','Adams, H. M.','Catalogue of books printed on the continent of Europe, 1501–1600 in Cambridge libraries','(Cambridge, Cambridge University Press, 1967)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (2,4,'Baudrier','','Baudrier, H.-L. & J. Baudrier','Bibliographie lyonnaise. Recherches sur les imprimeurs libraires, relieurs et fondeurs de lettres de Lyon au XVIe siècle','(Lyon: Louis Brun, 1895–1921)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (3,17,'Cartier, Des Tournes','','Cartier, A.','Bibliographie des éditions des de Tournes, imprimeurs lyonnais','(Paris, 1937–38)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (4,23,'Ghent','','Machiels, Jeroom','Catalogue van de boeken gedrukt voor 1600 aanwezig op de Centrale bibliotheek van de Rijksuniversiteit Gent','(Gent : Centrale bibliotheek, 1979)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (5,30,'Higman','','Higman, Francis','Piety and the people: Religious printing in French, 1511–1551','(St Andrews Studies in Reformation History, Aldershot: Ashgate, 1996)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (6,32,'IA','','','Index Aureliensis Catalogus Librorum Sedecimo Saeculo Impressorum','(Baden-Baden, 1962– 2004)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (7,45,'RB','','','Répertoire bibliographique des livres imprimés en France au seizième siècle','(Baden- Baden: Koerner, 1968–1980)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (8,47,'Rothschild','','Picot, E.','Catalogue des livres composant la bibliothèque de feu M. le Baron James de Rothschild','(Paris, 1884–1887)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (9,53,'Peach, Versailles','','Peach, Trevor','Catalogue descriptif des éditions françaises, néo-latines et autres 1501–1600 de la Bibliothèque Municipale de Versailles','(Paris: Editions Honore Champion, 1994)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (10,61,'Girard 2','','Girard, Alain','Catalogue collectif des livres imprimés à Paris de 1472 a 1600: conservés dans les bibliothèques publiques de Basse-Normandie','(Baden-Baden: Koerner, 1991)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (11,68,'Peach, Poitiers','','Peach, Trevor','Catalogue descriptif des éditions françaises, néo-latines et autres 1501–1600 de la Bibliothèque Municipale de Poitiers','(Genève: Slatkine, 2000)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (12,70,'Peach, Goujet','','Peach, Trevor','Le «Fonds Goujet» de la Bibliothèque Municipale de Versailles: textes littéraires des XVIe, XVIIe et XVIIIe siècles: catalogue alphabétique','(Genève: Slatkine, 1992)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (13,84,'Arsenal Verse','','Saunders, Alison & Dudley Wilson','Catalogue des Poésies Françaises de la Bibliothèque de l’Arsenal 1501–1600','(Paris: Éditions du Centre National de la Recherche Scientifique, 1985)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (14,87,'Renouard','','Renouard, Philippe','Imprimeurs et libraires parisiens du XVIe siècle','(Paris, 1964–91)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (15,90,'Cavellat','','Renouard, P.','Imprimeurs et libraires parisiens du XVIe siècle: Cavellat, Marnef et Cavellat','(Paris: Bibliothèque nationale, 1986)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (16,91,'Janot','','Rawles, Stephen','Denis Janot: Parisian printer and bookseller (fl 1529–1544): A bibliographical study','(PhD dissertation: University of Warwick, 1976)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (17,92,'Moreau','','Moreau, Brigitte','Inventaire Chronologique des Éditions Parisiennes du XVIe siècle','(Paris: Service des Travaux Historiques de la Ville de Paris, 1972–2010)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (18,102,'Mayer','','Mayer, C.A.','Bibliographie des Oeuvres de Clément Marot publiées au XVIe siècle','(Genève: Droz, 1954)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (19,104,'Dolet','','Longeon, Claude','Bibliographie des Oeuvres d’Etienne Dolet, écrivain, éditeur et imprimeur ','(Genève: Droz, 1980)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (20,106,'Guilleminot','','Guilleminot, Geneviève','Religion et politique à la veille des guerres civiles. Recherches sur les impressions françaises de l’année 1561','PhD dissertation, École des Chartes, 1977','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (21,109,'NUC','','','The National Union Catalog Pre-1956 Imprints: A Cumulative Author List Representing Library of Congress Printed Cards and Titles Reported by Other American Libraries','(Chicago : Mansell, 1968)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (22,116,'RISM','','Lesure, F.','Répertoire internationale des sources musicales. Recueils imprimés XVIe–XVIIe siècles','(München: G. Henle, 1960)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (23,169,'Guillo Lyon','','Guillo, L. ','Les Éditions Musicales de la Renaissance Lyonnaise','(Paris: Klincksieck, 1991)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (24,179,'Brunet','','Brunet, Jacques-Charles','Manuel du Libraire et de l’Amateur de Livres','(Paris: Firmin-Didot, 1860–65)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (25,181,'Gueltlingen','','Gültlingen, Sybille von','Bibliographie des livres imprimés à Lyon au seizième siècle','Baden-Baden: Koerner, 1992–2010','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (26,181,'Gueltlingen','','Gültlingen, Sybille von','Bibliographie des livres imprimés à Lyon au seizième siècle','Baden-Baden: Koerner, 1992–2010','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (27,185,'Nijhoff & Kronenberg','','Nijhoff, Wouter & Maria Elizabeth Kronenberg','Nederlandsche bibliographie van 1500 tot 1540','(’s-Gravenhage: Nijhoff, 1965–71; reprint of The Hague, 1919–1942)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (28,189,'Du Verdier','','Du Verdier, Antoine','La bibliothèque d’Antoine Du Verdier, contenant le catalogue de tous ceux qui ont escrit, ou traduit en françois ','(Lyon, 1587)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (29,190,'La Croix du Maine','','La Croix du Maine','Premier volume de la bibliotheque de la Croix du Maine','(Paris: Abel L’Angelier, 1584)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (30,199,'Abad Ibéricos','Martín Abad, Julián, Post-Incunables Ibéricos (Madrid, 2001)','Martín Abad, Julián','Post-Incunables Ibéricos','(Madrid, 2001)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (31,202,'Alcalá','Martín Abad, Julián, La Imprenta en Alcalá de Henares (1502-1600) (Madrid, 1991)','Martín Abad, Julián','La Imprenta en Alcalá de Henares (1502-1600)','(Madrid, 1991)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (32,203,'Aragonesa','Sánchez, Juan M., Bibliografia aragonesa del siglo XVI (1501-1600) (Madrid, 1991)','Sánchez, Juan M.','Bibliografia aragonesa del siglo XVI (1501-1600)','(Madrid, 1991)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (33,208,'Burgos','Fernández Valladares, Mercedes, La imprenta en Burgos (1501-1600) (Madrid, Arcos Libros, 2005), 2 vols.','Fernández Valladares, Mercedes','La imprenta en Burgos (1501-1600)','(Madrid, Arcos Libros, 2005)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (34,213,'Catálogo Colectivo','Catálogo Colectivo del Patrimonio Bibliográfico Español','','Catálogo Colectivo del Patrimonio Bibliográfico Español','','http://www.mcu.es/bibliotecas/MC/CCPB/index.html#');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (35,227,'GriffinCrombergers','Griffin, Clive, The Crombergers of Sevilla. The History of a Printing and  Merchant Dynasty (Oxford, 1998)','Griffin, Clive','The Crombergers of Sevilla. The History of a Printing and  Merchant Dynasty','(Oxford, 1998)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (36,229,'HPB','Hand Press Books (Eureka)','','Heritage of the Printed Book Database','','http://www.cerl.org/web/en/resources/hpb/main');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (37,230,'Joaquim Anselmo','Joaquim Anselmo, Antonio, Bibliografia das obras impressas em Portugal no século XVI (Lisboa, 1926, reprinted in 1977)','Joaquim Anselmo, Antonio','Bibliografia das obras impressas em Portugal no século XVI','(Lisboa, 1926, reprinted in 1977)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (38,238,'Modena','Soave, Valeriano, Il fondo antico spagnolo della Biblioteca Estense di Modena (Kassel, Reichenberger, 1985)','Soave, Valeriano','Il fondo antico spagnolo della Biblioteca Estense di Modena','(Kassel, Reichenberger, 1985)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (39,240,'Norton','Norton, F.J., A descriptive catalogue of printing in Spain and Portugal, 1501-1520 (Cambridge, 1978)','Norton, F.J.','A descriptive catalogue of printing in Spain and Portugal, 1501-1520','(Cambridge, 1978)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (40,241,'Palau','','Palau y Dulcet, Antonio','Manual del librero hispanoamericano : bibliografía general española e hispanoamericana desde la invención de la imprenta hasta nuestros tiempos con el valor comercial de los impresos descritos','(Barcelona : Palau, 1970)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (41,246,'Porbase','Portuguese collective catalogue','','Base Nacional de Dados Bibliográficos é o catálogo colectivo em linha das bibliotecas portuguesas','','http://porbase.bnportugal.pt/');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (42,252,'Sevillano','Dominguez Guzman, Aurora, El libro Sevillano durante la primera mitad del siglo XVI (Sevilla, 1975)','Dominguez Guzman, Aurora','El libro Sevillano durante la primera mitad del siglo XVI','(Sevilla, 1975)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (43,259,'ValenciaCat','http://parnaseo.uv.es/fmi/iwp/cgi?-db=imprenta%20en%20valencia%20sxvi_Server&-loadframes [Accessed 28.9.2009]','','REMOVE','','http://parnaseo.uv.es/fmi/iwp/cgi?-db=imprenta%20en%20valencia%20sxvi_Server&-loadframes [Accessed 28.9.2009]');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (44,260,'Valladolid','Marsá, María, Materiales para una historia de la imprenta en Valladolid (siglos XVI y XVII) (Universidad de León, 2007)','Marsá, María','Materiales para una historia de la imprenta en Valladolid (siglos XVI y XVII)','(Universidad de León, 2007)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (45,262,'Vega Gonzalez, Jesusa','Vega Gonzalez, Jesusa, La Imprenta en Toledo estampas del renacimiento 1500-1550 (Toledo, 1983)','Vega Gonzalez, Jesusa','La Imprenta en Toledo estampas del renacimiento 1500-1550','(Toledo, 1983)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (46,319,'BC','','Conrad Borschling & Bruno Claussen','Niederdeutsche Bibliographie. Gesamptverzeichnis der Niederdeutschen Drucke bis zum Jahre 1800','(Neumünster: Wachholtz, 1931-1936)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (47,320,'Benzing','','Benzing, Josef','Bibliographie Strasbourgeoise','(Baden-Baden: Koerner, 1981)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (48,322,'Ritter','','Ritter, Fr.','Repertoire bibliographique des livres du XVI qui se trouvent à la Bibliothèque National et Universitaire de Strasbourg','(Strasbourg: Heitz, 1937-1955)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (49,323,'Muller','','Muller, Jean','Bibliographie Strasbourgeoise, Tome II-III','(Baden-Baden: Koerner, 1985-86)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (50,323,'Muller','','Muller, Jean','Bibliographie Strasbourgeoise, Tome II-III','(Baden-Baden: Koerner, 1985-86)','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (51,347,'Schmidt','','','','','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (52,349,'eRMK','','','Elektronikus Régi Magyar Könyvtár','','');
INSERT INTO `erasmus`.`bibliographie` (`bibliographie_id`,`bibliographie_ref_sequential`,`bibliographie_code`,`bibliographie_bibliReference`,`bibliographie_author`,`bibliographie_title`,`bibliographie_imprint`,`bibliographie_URLLink`) VALUES (53,354,'Aguiló y Fustér, Catalana','','Aguiló y Fustér, Mariano','Catálogo de obras en lengua Catalana impresas desde 1474 hasta 1860','(Madrid, 1923)','');

COMMIT;

START TRANSACTION;
USE `erasmus`;
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A01','Avignon (Fr), Bibliothèque municipale Livrée Ceccano','http://www.avignon.fr/fr/pratique/biblio/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A02','Arles (Fr), Médiathèque municipale Espace Van Gogh','http://www.ville-arles.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A05','Amsterdam (Nl), Universiteitsbibliotheek Vrije Universiteit','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A06','Aberdeen (UK), University Library','http://www.abdn.ac.uk/diss/library/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A07','Angers (Fr), Bibliothèque municipale','http://www.angers.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A08','Alençon (Fr), Médiathèque de la Communauté Urbaine d\'Alençon','http://www.ville-alencon.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A09','Avranches (Fr), Bibliothèque municipale Edouard Le Héricher','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A104','Alessandria (It), Biblioteca del Seminario vescovile','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A105','Acqui Terme (It), Biblioteca del Seminario vescovile','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A107','Asti (It), Biblioteca del Seminario vescovile','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A12','Antwerpen (Be), Museum Plantin-Moretus','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A13','Aix-en-Provence (Fr), Bibliothèque Méjanes','http://www.mairie-aixenprovence.fr/article.php3?id_article=221',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A15','Atlanta, GA (USA), Emory University Library','http://www.emory.edu/LIBRARIES/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A155','Anderlecht (Be), Erasmushuis','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A16','Amiens (Fr), Bibliothèque d\'Amiens Métropole','http://www.bm-amiens.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A17','Arras (Fr), Médiathèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A177','Averbode (Be), Praemonstr. Abdij','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A178','Amsterdam (Nl), Bibliotheek van de Remonstrantse Kerk (in Amsterdam, Universiteitsbibliotheek Universiteit)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A18','Auxerre (Fr), Bibliothèque municipale','http://www.bm-auxerre.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A186','Alessandria (It), Biblioteca civica Francesca Calvo','http://www.comune.alessandria.it/flex/cm/pages/ServeBLOB.php/L/IT/IDPagina/1315',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A19','Aarau (Ch), Kantonsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A190','Assisi (It), Biblioteca Porziuncola','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A203','Avignon (Fr), Musée Calvet','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A212','Augsburg (De), Kloster St. Stephan','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A215','Alba Julia (Ro), Biblioteca Centralã de Stat, filiala Batthyaneum \\n \\n Alba Iulia,    \\n \\n Alba Iulia (Ro), Biblioteca Centralã de Stat, filiala Batthyaneum \\n\\nBiblioteca Centralã de Stat, filiala Batthyaneum   \\n \\nAlba Iulia (Ro), Biblioteca Centralã','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A22','Abbeville (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A23','Antwerpen (Be), Ruusbroecgenootschap','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A25','Augsburg (De), Staats- und Stadtbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A27','Antwerpen (Be), Stadsbibliotheek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A29','Aurillac (Fr), Médiathèque communautaire François Mitterrand','http://www.agglo-aurillac.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A31','Autun (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A32','Auch (Fr), Bibliothèque-musicothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A38','Aberystwyth (UK), National Library of Wales','http://www.llgc.org.uk/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A43','','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A46','Augsburg (De), Universitätsbibliothek','http://www.bibliothek.uni-augsburg.de/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A62','Angoulême (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A63','Astorga (Sp), Seminario Diocesano de Astorga','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A66','Amberg (De), Staatliche Bibliothek (Provinzialbibliothek)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A72','Arbois (Fr), Bibliothèque intercommunale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A79','Ansbach (De), Staatliche Bibliothek (Schlossbibliothek)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A90','Aachen (De), Stadtbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('A92','Antwerpen (Be), Archief van de Vlaams-Belgische provincie der kapucijnen','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B01','Bordeaux (Fr), Bibliothèque municipale','http://www.bordeaux.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B02','Bruxelles (Be), Bibliothèque royale/ Koninklijke Bibliotheek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B03','Besançon (Fr), Bibliothèque municipale','http://www.besancon.com/biblio/francais/bm1.htm',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B04','Beaune (Fr), Bibliothèque municipale','http://ccfr.bnf.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B05','Berlin (De), Staatsbibliothek Preußischer Kulturbesitz','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B07','Blois (Fr), Bibliothèque Abbé Grégoire','http://www.ville-blois.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B08','Bayeux (Fr), Médiathèque municipale, Centre Guillaume Le Conquérant','http://ccfr.bnf.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B106','Bergen (No), Universitetsbiblioteket','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B109','Brussels (Be), Bibliothèque royale/ Koninklijke Bibliotheek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B110','Brno (Cz), Moravská zemská knihovna (Moravian Library)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B111','Bruxelles (Be), Bibliothèque de la Société des Bollandistes','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B113','Budapest (Hu), Budapesti Corvinus Egyetem Központi Könyvtár (Corvinus University)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B121','Bergamo (It), Biblioteca civica Angelo Mai','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B124','Budapest (Hu), Magyar Tudományos Akadémia Könyvtár (Hungarian Academy of Sciences Library)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B126','Burgos (Sp), Biblioteca Pública del Estado','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B13','Basel (Ch), Universitätsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B130','Biella (It), Biblioteca civica','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B135','Bourges (Fr), Société d\'archéologie','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B15','Bourg-en-Bresse (Fr), Médiathèque municipale Elizabeth et Roger Vailland','www.bm-bourgenbresse.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B151','Bielefeld (De), Universitätsbibliothek','http://www.ub.uni-bielefeld.de/biblio/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B156','Birmingham (UK), University Library','http://www.is.bham.ac.uk/mainlib/index.htm',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B162','Bruxelles (Be), Erasmus House','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B171','Brindisi (It), Biblioteca arcivescovile Annibale De Leo','http://www.provincia.brindisi.it/provbr/biblioteche.nsf/Bibl%20De%20Leo?OpenPage',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B172','Bergamo (It), Biblioteca monsignor Giacomo Maria Radini Tedeschi','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B19','Barcelona (Sp), Biblioteca de Cataluña','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B209','Bari (It), Biblioteca nazionale Sagarriga Visconti-Volpi','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B21','Bern (Ch), Stadt- und Universitätsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B213','Bergamo (It), Biblioteca del Sacro Cuore di San Alessandro','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B218','Berlin (De), Nationalbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B22','Bamberg (De), Staatsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B221','Bilbao (Es), Biblioteca de la Universidad de Deusto','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B227','Bologna (It), Biblioteca dello Studentato delle Missioni','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B229','Bologna (It), Biblioteca provinciale dei Cappuccini','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B23','Budapest (Hu), Országos Széchényi Könyvtár (National Széchényi Library)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B247','Burgos (Es), Biblioteca Pública del Estado','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B25','Bonn (De), Universitäts- und Landesbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B256','Dilbeek (Be), Cultura Fonds','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B265','Bucharest (Ro), Biblioteca Nationala','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B269','Bornheim (De), Abdij','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B271','Bobbio (It), Biblioteca ausiliaria degli Archivi storici diocesani. Sede di Bobbio','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B272','Bologna (It), Biblioteca d\'arte e di storia di San Giorgio in Poggiale','http://www.fondazionecarisbo.it/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B276','Bologna (It), Biblioteca del Seminario arcivescovile','http://www.bologna.chiesacattolica.it/seminario',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B28','Belfort (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B280','Bologna (It), Biblioteca patriarcale di S. Domenico','http://www.comune.bologna.it/iperbole/biblsand',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B281','Bologna (It), Biblioteca provinciale dei Frati minori dell\'Emilia. Sezione Biblioteca dell\'Osservanza','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B285','Bra (It), Biblioteca civica','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B29','Bologna (It), Biblioteca universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B31','Brigham Young University Library, Provo, UT (USA)','http://sc.lib.byu.edu',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B339','Braşov (Ro), Arhiva ºi biblioteca comunitãþii bisericii evanghelice de confesiune augustanã „Honterus”','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B34','Bayonne (Fr), Bibliothèque-médiathèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B44','Baltimore, MD (USA), Johns Hopkins University Library','http://www.library.jhu.edu',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B53','Brugge (Be), Grootseminarie','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B61','Barcelona (Es), Universidad de Barcelona, Biblioteca General','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B62','Burgos (Es), Biblioteca de Castilla y León (Diputación Provincial)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B63','Bernay (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B74','Bristol (UK), Public Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B75','Brugge (Be), Stadsbibliotheek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B80','Bologna (It), Biblioteca comunale dell\'Archiginnasio','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('B87','Beauvais (Fr), Archives départementales','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C01','Cambridge (UK), University Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C02','Cáceres (Sp), Biblioteca Pública del Estado \"A. Rodríguez Moñino y María Brey\"\"\"','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C03','Cambridge (UK), Emmanuel College Library','http://www.emma.cam.ac.uk/teaching/library/index.cfm?itemid=303',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C04','Caen (Fr), Bibliothèque universitaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C05','Caen (Fr), Bibliothèque municipale','http://www.bm.ville-caen.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C08','Cagliari (It), Biblioteca universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C09','Cahors (Fr), Médiathèque municipale du pays de Cahors','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C10','Coutances (Fr), Médiathèque du canton de Coutances','http://ccfr.bnf.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C107','Carcassonne (Fr), Archives départementales','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C11','Cherbourg-Octeville (Fr), Bibliothèque municipale Jacques Prévert','http://www.ville-cherbourg.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C111','Cesena (It), Biblioteca comunale Malatestiana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C114','Córdoba (Sp), Biblioteca Pública del Estado / Biblioteca Provincial','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C126','Cremona (It), Biblioteca statale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C133','Cuenca (Sp), Seminario Mayor o Conciliar de San Julián','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C145','Casale Monferrato (It), Biblioteca civica Giovanni Canna','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C148','Clausthal-Zellerfeld (De), Calvörsche Bibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C15','Chalon-sur-Saône (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C157','Cape Town (ZA), University Library','http://www.lib.uct.ac.za/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C16','Chambéry (Fr), Médiathèque Jean-Jacques Rousseau','http://www.bm-chambery.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C160','Cuneo (It), Biblioteca civica','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C161','Crescentino (It), Biblioteca civica de Gregoriana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C163','Cassino (It), Biblioteca statale del monumento nazionale di Montecassino','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C174','Cambridge (UK), British and Foreign Bible Society Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C195','Cherasco (It), Biblioteca civica Giovanni Battista Adriani','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C196','Chester (UK), Cathedral Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C199','Chichester (UK), Cathedral Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C20','Colmar (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C204','Città della Pieve (It), Biblioteca comunale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C21','Cambridge (UK), St John\'s College Library','http://www.joh.cam.ac.uk/Library/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C226','Correggio (It), Biblioteca comunale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C23','Chantilly (Fr), Musée Condé','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C247','Catanzaro (It), Biblioteca comunale Filippo De Nobili','http://www.bibliodenobili.cz.it',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C248','Chieri (It), Biblioteca storica del Liceo classico Casare Balbo','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C25','Clermont-Ferrand (Fr), Bibliothèque communautaire et interuniversitaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C250','Cosenza (It), Biblioteca civica','http://www.bibliotecacivica.cs.it/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C254','Chiavari (It), Biblioteca della Società economica','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C26','Châlons-en-Champagne (Fr), Bibliothèque municipale','http://www.chalons-en-champagne.net/bmvr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C27','Cambrai (Fr), Médiathèque municipale','http://www.media.cambrai.com',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C28','Canterbury (UK), Cathedral Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C29','Cambridge (UK), University Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C29?','','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C30','Chicago, IL (USA), Chicago University Library','http://www.lib.uchicago.edu/e/index.html',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C33','Cambridge, MA (USA), Houghton Library, Harvard University','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C34','Cornell University Library, Ithaca, NY (USA)','http://campusgw.library.cornell.edu/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C36','Cambridge (UK), King\'s College Library','http://www.kings.cam.ac.uk/library/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C43','Chantilly (Fr), Médiathèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C44','Coburg (De), Landesbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C47','Cambridge (UK), Magdalene College (Pepys Library)','http://www.magd.cam.ac.uk/pepys/library.html',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C48','Cambridge (UK), Queens College Library','http://www.quns.cam.ac.uk/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C49','Cambridge (UK), Sidney Sussex College Library','http://www.sid.cam.ac.uk/indepth/lib/library.html',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C50','Cambridge (UK), Gonville and Caius College Library','http://www.cai.cam.ac.uk/college/library/index.php',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C51','Cambridge (UK), Christ\'s College Library','http://www.christs.cam.ac.uk/info/library/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C52','Cambridge (UK), Fitzwilliam Museum','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C55','Cambridge (UK), Jesus College Library','http://www.jesus.cam.ac.uk/college/infservices/library.html',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C57','Carlisle (UK), Cathedral Library','http://www.carlislecathedral.org.uk/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C64','Cambridge (UK), Pembroke College Library','http://www.pem.cam.ac.uk/library/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C65','Cambridge (UK), Peterhouse','http://www.pet.cam.ac.uk/library/index.html',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C71','Cambridge (UK), St Catharine\'s College Library','http://www.caths.cam.ac.uk/library/index.html',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C75','Cambridge (UK), Corpus Christi College Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C77','Chicago, IL (USA), Newberry Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C78','Clermont (Fr), Bibliothèque municipale.','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C81','Châteauroux (Fr), Médiathèque Equinoxe','http://195.25.223.13/default9.htm',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C85','Coulommiers (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C86','Charleville-Mézières (Fr), Bibliothèque municipale','http://www.bm-charlevillemezieres.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C90','Carcassonne (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C91','Chartres (Fr), Archives départementales','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C92','Chartres (Fr), Bibliothèque centrale André Malraux','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('C98','Colección privada','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D01','Dublin (Ie), Trinity College','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D02','Dublin (Ie), Marsh\'s Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D03','Dieppe (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D04','Dijon (Fr), Bibliothèque municipale','http://www.bm-dijon.fr/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D05','Dole (Fr), Bibliothèque municipale','http://www.dole.org/SiteDole/mediatheque',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D08','Darmstadt (De), Landesbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D09','Dresden (De), Sächsische Landesbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D10','Douai (Fr), Bibliothèque municipale','http://www.ville-douai.fr/intcult.htm',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D11','Durham (UK), University Library','http://www.dur.ac.uk/library/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D12','Durham, NC (USA), Duke University Library','http://www.lib.duke.edu/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D14','Durham (UK), Cathedral Library','http://www.dur.ac.uk/cathedral.library/contacts.htm',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D15','Düsseldorf (De), Universitäts- und Landesbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D32','Dinan (Fr), Bibliothèque municipale','http://perso.wanadoo.fr/bmdinan/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D37','Dillingen (De), Studienbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D38','Draguignan (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D43','Delft (Nl), Stedelijk Museum het Prinsenhof','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D48','Dublin (Ie), National Library of Ireland','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D70','Delft (Nl), Gemeentearchief','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('D72','Deventer (Nl), Stads- of Atheneumbibliotheek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('E01','Edinburgh (UK), National Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('E02','Edinburgh (UK), University Library','http://www.lib.ed.ac.uk/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('E03','Edinburgh (UK), New College Library','http://www.div.ed.ac.uk/contact',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('E04','Evora (Pt), Biblioteca Publica','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('E05','Epernay (Fr), Médiathèque municipale','http://www.mediatheque-epernay.com',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('E06','Exeter (UK), Cathedral Library','http://www.exeter-cathedral.org.uk/Admin/Library.html',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('E07','Erlangen (De), Universitätsbibliothek','http://www.ub.uni-erlangen.de/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('E11','Evreux (Fr), Bibliothèque municipale','http://www.evreux.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('E16','Ely (UK), Cathedral Library [collection now dispersed]','http://www.cathedral.ely.anglican.org/info/info.htm',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('E17','Évora (Po), Biblioteca Publica','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('E18','Eichstätt (De), Universitätsbibliothek Eichstätt-Ingolstadt','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('E21','Eton College (UK)','http://www.etoncollege.com/default.asp',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('E49','Emmerich (De), Bibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('E53','Edam (Nl), Sint-Nicolaaskerk','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F01','Folger Shakespeare Library, Washington, DC (USA)','http://www.folger.edu/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F03','Firenze (It), Biblioteca nazionale centrale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F04','Fribourg (Ch), Bibliothèque cantonale et universitaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F05','Flers (Fr), Médiathèque du pays de Flers','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F07','Frankfurt am Main (De), Stadt- und Universitätsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F12','Falaise (Fr), Bibliothèque intercommunale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F22','Forlì (It), Biblioteca comunale Aurelio Saffi','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F28','Freiburg/Breisgau (De), Universitätsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F30','Faenza (It), Biblioteca comunale Manfrediana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F33','Frauenfeld (Ch), Kantonsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F34','Fossano (It), Biblioteca Civica di Fossano - Castello Principi d\'Acaja','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F35','Firenze (It), Biblioteca Marucelliana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F36','Fermo (It), Biblioteca comunale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F37','Firenze (It), Biblioteca Medicea Laurenziana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F43','Fano (It), Biblioteca comunale Federiciana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F45','Firenze (It), Biblioteca Umanistica (Biblioteca della Facoltà di Lettere e Filosofia)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F58','Firenze (It), Villa I Tatti, Biblioteca Berenson','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F71','Faenza (It), Biblioteca cardinale Gaetano Cicognani','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F76','Ferrara (It), Biblioteca del Seminario arcivescovile','http://www.ibisweb.it/seFe',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F77','Fidenza (It), Biblioteca del Seminario vescovile minore','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F80','Foggia (It), Biblioteca provinciale La Magna Capitana','http://www.bibliotecaprovinciale.foggia.it',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F81','Foligno (It), Biblioteca comunale','http://www.comune.foligno.pg.it/canale.asp?id=175',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F82','Forlì (It), Biblioteca del Seminario vescovile','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('F83','Fossombrone (It), Biblioteca civica Benedetto Passionei','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G01','Genève (Ch), Bibliothèque de Genève (formerly Bibliothèque publique et universitaire)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G03','Gent (Be), Centrale Bibliotheek van de Universiteit Gent','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G04','Göttingen (De), Niedersächsische Staats- und Universitätsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G05','Gotha (De), Forschungsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G06','Glasgow (UK), University Library','http://www.lib.gla.ac.uk/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G07','Grenoble (Fr), Bibliothèques municipales','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G11','Gent (Be), Centrale Bibliotheek van de Universiteit Gent','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G110','Gaesdonck (De), Collegium Augustinianum','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G115','Guastalla (It), Biblioteca Maldotti','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G116','Guastalla (It), Biblioteca S. Giovanni Crisostomo del Seminario','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G12','Groningen (Nl), Bibliotheek der Rijksuniversiteit','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G126','Girona (Es), Library of the Diocese of Girona','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G16','Gloucester (UK), Cathedral Library','http://www.gloucestercathedral.org.uk',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G26','Greifswald (De), Universitätsbibliothek','http://www.ub.uni greifswald.de/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G27','Göttingen (Gw), Niedersächsische Staats- und Universitätsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G28','Giessen (De), Universitätsbibliothek','http://www.uni-giessen.de/ub/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G33','Gouda (Nl), Streekarchief Midden-Holland (formerly Stadslibrije)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G47','Guer (Fr), Ecoles de Coëtquidan','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G49','Guadalajara (Mx), Biblioteca Pública del Estado','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G55','Genova (It), Biblioteca provinciale dei Cappuccini liguri','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G58','Gent (Be), Bisschoppelijk Seminaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G59','Gent (Be), Ongeschoeide Karmelieten','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('G98','Gouda (Nl), Gemeentearchief','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H01','Houghton Library, Harvard University, Cambridge, MA (USA)','http://hcl.harvard.edu/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H02','Hereford (UK), Cathedral Library','http://www.herefordcathedral.org/contact.asp',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H04','Hamilton, Ontario (Ca), McMaster University','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H09','Halle (De), Universitäts- und Landesbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H10','Huntington Library, San Marino, CA (USA)','http://www.huntington.org/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H11','Hamburg (De), Staats- und Universitätsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H12','Heidelberg (De), Universitätsbibliothek','http://www.ub.uni-heidelberg.de/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H18','Haarlem (Nl), Stadsbibliotheek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H21','Huesca (Es), Biblioteca Pública del Estado','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H32','Den Haag (Nl), Museum Meermanno','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H33','Hartford, CT (USA), Watkinson Library, Trinity College','http://www.trincoll.edu/depts/library/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H39','Hannover (De), Niedersächsische Landesbibliothek (Gottfried Wilhelm Leibniz Bibliothek)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H54','Den Haag (Nl), Nederlands Muziek Instituut','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H58','Harvard University, Widener Library, Cambridge, MA (USA)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H65','Hof (De), Rasbibliothek/ Stadtarchiv','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H66','Hamilton, Ontario (Ca), McMaster University','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H76','Halle (De), Bibliothek des Waisenhaus','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H88','\'s-Hertogenbosch (Nl), Rijksarchief','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('H89','Heeswijk (Nl), Bibliotheek Abdij Berne','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('I01','Illinois University Library, Urbana, IL (USA)','http://urbanafreelibrary.org',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('I03','Indiana University Library, Bloomington, IN (USA)','http://www.libraries.iub.edu/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('I06','Innsbruck (At), Universitätsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('J01','Jena (De), Universitätsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('J02','Jesi (It), Biblioteca comunale Planettiana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('K03','Karlsruhe (De), Badische Landesbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('K04','Kassel (De), Hessische Landesbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('K07','København (Dk), Det Kongelige Bibliotek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('K08','Kraków (Pl), Biblioteka Jagiellonska','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('K11','Kortrijk (Be), Stadsbibliotheek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('K15','Klosterneuburg (At), Stiftsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('K19','Köln (De), Universitäts- und Stadtbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('K44','Kaliningrad (Ru), Rossiyskiy gosudarstvennyy universitet imeni Immanuila Kanta','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('K50','Kežmarok (Sk), Evanjelická cirkevná knižnica (Késmárk, evangélikus lyceum)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L01','London (UK), British Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L02','La Habana (Cu), Biblioteca Nacional','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L03','Lausanne (Ch), Bibliothèque cantonale et universitaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L04','Leiden (Nl), Universiteitsbibliotheek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L05','Leuven (Be), Katholieke Universiteit, Centrale Bibliotheek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L07','La Vid (Sp), Monasterio de Santa María de la Vid. PP. Agustinos','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L10','Loches (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L103','Lyon (Fr), Musée de l\'imprimerie','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L105','Lüneburg (De), Ratsbücherei','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L107','Lille (Fr), Institut Catholique','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L11','Leiden (Nl), Bibliotheca Thysiana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L112','Lund (Se), Universitetsbibliotek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L118','Lille (Fr), Bibliothèque des Amici Thomae Mori','http://www.amici-thomae-mori.com',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L12','Lisieux (Fr), Bibliothèque municipale','http://www.bmlisieux.com',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L126','Lyon (Fr), Bibliothèque de l\'Université Catholique','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L13','Luxembourg (Lu), Bibliothèque nationale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L14','Lille (Fr), Médiathèque municipale Jean Lévy','http://ccfr.bnf.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L142','London (UK), Sion College Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L149','Lyon (Fr), Archives départementales','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L150','Lyon (Fr), Bibliothèque inter-universitaire de lettres et sciences humaines','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L158','Lanhydrock House, Bodmin (UK)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L16','Le Havre (Fr), Bibliothèque municipale Armand Salacrou','http://www.ville-lehavre.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L163','London (UK), St Bride Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L164','Leiden (Nl), Maatschappij der Nederlandse Letterkunde','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L170','Leuven (Be), Katholieke Universiteit, Bibliotheek Faculteit Rechtsgeleerdheid','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L172','Leuven (Be), Abdij van Park','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L175','Livorno (It), Biblioteca comunale Labronica Francesco Domenico Guerrazzi','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L18','Liège (Be), Bibliothèque universitaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L181','Leuven (Be), Stedelijk Museum Vander Kelen-Mertens','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L19','Lille (Fr), Bibliothèque universitaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L20','London (UK), St Paul\'s Cathedral Library','http://www.stpauls.co.uk',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L208','Lisboa (Pt), Assemblea Nacional','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L22','Laon (Fr), Bibliothèque municipale Suzanne Martinet','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L23','Lincoln (UK), Cathedral Library','http://www.lincolncathedral.com/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L24','Lübeck (De), Bibliothek der Hansestadt','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L242','Leeuwarden (Nl), Provinciale Bibliotheek Friesland','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L249','La Spezia (It), Biblioteca civica Ubaldo Mazzini. Fondi antichi','http://www.laspeziacultura.it/biblioteche/mazzini_sede.htm?l=it',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L251','Lecce (It), Biblioteca provinciale Nicola Bernardini','http://www.mediatechelecce.it/mediateca_provinciale/biblioteca.asp',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L252','Livorno (It), Biblioteca comunale Labronica Francesco Domenico Guerrazzi. Sezione dei Bottini dell\'olio','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L26','Liège (Be), Bibliothèque du grand séminaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L28','London (UK), Lambeth Palace Library','http://www.lambethpalacelibrary.org/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L29','Liverpool (UK), Cathedral Library','http://www.liverpoolcathedral.org.uk/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L30','Luzern (Ch), Zentralbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L32','Louviers (Fr), Médiathèque Boris Vian','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L33','Laval (Fr), Bibliothèque municipale Albert Legendre','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L37','Leipzig (De), Universitätsbibliothek','www.ub.uni-leipzig.de/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L38','Liège (Be), Bibliothèque publique centrale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L39','London (UK), Wellcome Library','http://www.wellcome.ac.uk/library/.',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L43','Limoges (Fr), Bibliothèque francophone multimédia','http://www.bm-limoges.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L44','Leuven (Be), Katholieke Universiteit, Bibliotheek Faculteit der Godgeleerdheid','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L47','London (UK), University College Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L53','Lisboa (Po), Biblioteca de Ajuda','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L56','Lisboa (Po), Biblioteca Nacional de Portugal','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L58','Lagny-sur-Marne (Fr), Bibliothèque municipale Gérard Billy','http://www.esaupe77.com',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L59','Ljubljana (Si), Narodna in univerzitetna knjiznica','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L62','Lisboa (Pt), Biblioteca Nacional de Portugal','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L70','London (UK), Guildhall Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L76','London (UK), British Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L87','Lavaur (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('L91','Leeds (UK), University Library','http://www.leeds.ac.uk/library/contact/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M01','Montpellier (Fr), Médiathèque centrale d\'agglomération Emile Zola','http://www.ville-montpellier.fr/bm/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M02','Montauban (Fr), Bibliothèque municipale Antonin Perbosc','http://www.montauban.com/infos/biblio.asp',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M03','München (De), Bayerische Staatsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M06','Le Mans (Fr), Médiathèque Louis Aragon','http://www.mediatheque.ville-lemans.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M07','Metz (Fr), Médiathèque du Pontiffroy','http://bm.mairie-metz.fr/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M08','Marseille (Fr), Bibliothèque municipale L\' Alcazar','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M10','München (De), Universitätsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M105','Martin (Sk), Slovenská národná knižnica (Slovak National Library)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M109','México (Mx), Biblioteca Nacional de México','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M118','Mercogliano (It), Biblioteca pubblica statale annessa al Monumento nazionale dell\'Abbazia di Montevergine','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M121','Milano (It), Biblioteca delle Facoltà di Giurisprudenza e Lettere e filosofia','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M124','Milano (It), Biblioteca delle Facoltà di Giurisprudenza e Lettere e filosofia','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M130','Montpellier (Fr), Université de médecine','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M142','Michelstadt (De), Kirchenbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M145','Modena (It), Biblioteca Estense Universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M146','Milano (It), Biblioteca comunale Palazzo Sormani','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M148','Mondovì (It), Biblioteca del Seminario vescovile','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M154','Madrid (Es), Archivo Municipal','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M156','Montserrat (Sp), Biblioteca de la Abadía Benedictina','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M16','Moulins (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M161','München (Gw), Bayerische Staatsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M18','Madrid (Sp), Biblioteca del Palacio Real','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M20','Meaux (Fr), Médiathèque Luxembourg','http://www.esaupe77.com',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M21','Madrid (Sp), Biblioteca Nacional','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M22','Madrid (Es), Biblioteca Nacional de España','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M221','Messina (It), Biblioteca regionale universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M24','Mainz (De), Stadtbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M241','Milano (It), Istituto Leone XIII','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M248','Montefiascone (It), Biblioteca del Seminario vescovile Barbarigo','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M266','Megen (Nl), Minderbroedersklooster','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M27','Marburg (De), Universitätsbibliothek','http://www.uni-marburg.de/bis/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M270','Marburg (De), Staatsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M280','Matera (It), Biblioteca provinciale Tommaso Stigliani','http://www.biblioteca.matera.it',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M284','Milano (It), Biblioteca del Dipartimento di scienze dell\'antichità dell\'Università degli studi di Milano','www.sba.unimi.it/biblioantichitaefilologiamoderna',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M29','Maredsous (Be), Abbaye Bénédictine','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M290','Montevarchi (It), Biblioteca dell\'Accademia valdarnese del Poggio','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M304','Mount Angel Abbey Library, St Benedict, OR (USA)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M31','Mons (Be), Université de Mons-Hainaut','http://w3.umh.ac.be/Bibli/index.html',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M32','Montbrison (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M33','Madrid (Sp), D. Bartolomé March','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M42','Moskva (Ru), Russian State Library (formerly Lenin Library)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M50','Madrid (Es), Museo Lazaro Galdiano','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M51','Madrid (Es), Biblioteca del Palacio Real','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M58','Modena (It), Biblioteca Estense Universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M62','Madrid (Sp), Real Academia de la Historia','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M63','Mariemont (Be), Musée','http://www.musee-mariemont.be/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M67','Milano (It), Archivio storico civico e Biblioteca Trivulziana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M68','Mâcon (Fr), Bibliothèque municipale','http://www.biblio.ville-macon.fr/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M72','Madrid (Sp), Universidad Complutense, Biblioteca Histórica Marqués de Valdecilla','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M75','Mantova (It), Biblioteca comunale Teresiana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M78','Mahón / Maó (Sp), Biblioteca Pública del Estado','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M83','Maastricht (Nl), Stadsbibliotheek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M92','Mannheim (De), Stadtbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('M96','Münster (De), Universitätsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N01','Newberry Library, Chicago, IL (USA)','http://www.newberry.org',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N02','Nîmes (Fr), Bibliothèque Carré d\'art','http://bibliotheque.nimes.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N04','Nantes (Fr), Bibliothèque municipale','http://www.bm.nantes.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N05','Nantes (Fr), Musée Dobrée','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N06','Namur (Be), Bibliothèque universitaire Moretus Plantin','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N08','New York, NY (USA), New York Public Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N100','Napoli (It), Biblioteca della Società napoletana di storia patria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N102','Napoli (It), Biblioteca dell\'Istituto italiano per gli studi storici Benedetto Croce','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N104','Narni (It), Biblioteca diocesana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N107','Napoli (It), Biblioteca universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N12','Niort (Fr), Médiathèque de la communauté d\'agglomération','http://www.vivre-a-niort.com/abv/framesetportail.asp',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N123','Nardò (It), Biblioteca comunale Achille Vergari','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N124','Novellara (It), Biblioteca comunale Giuseppe Malagoli','http://www.rcs.re.it/novellara',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N125','Napoli (It), Biblioteca dell\'Istituto Pontano','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N128','Navarra (Es), Universidad','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N13','New Haven, CT (USA), Yale University, Beinecke Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N15','Nancy (Fr), Bibliothèque municipale','http://www.mairie-nancy.fr/wdbctx/mn/docs/culture_sport_loisirs/002_fs_bib_muni.htm',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N17','Nürnberg (De), Landeskirchenarchiv','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N18','New York, NY (USA), Hispanic Society','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N23','Neuburg an der Donau (De), Staatliche Bibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N24','Nürnberg (De), Stadtbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N25','Namur (Be), Bibliothèque du grand séminaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N30','Neuchâtel (Ch), Bibliothèque des Pasteurs','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N31','Nevers (Fr), Médiathèque Jean Jaurès','http://mediatheque.ville-nevers.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N32','Nanterre (Fr), Bibliothèque André Desguine','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N33','No se conoce ejemplar en la actualidad','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N37','Nice (Fr), Bibliothèque patrimoniale Romain Gary','http://www.bmvr-nice.com.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N43','Navarra (Es), Biblioteca General','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N46','Nanterre (Fr), Archives départementales','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N49','Nijmegen (Nl), Universiteitsbibliotheek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N55','Norwich (UK), Cathedral Library','http://www.cathedral.org.uk/pages/html/libraries.html',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N64','New York, NY (USA), Union Theological Seminary Library','http://www.uts.columbia.edu/burke_library/www.uts.columbia.edu/burke_library/index.html',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N66','Namur (Be), Centre de Documentation et de Recherche Religieuses','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N77','Nitra (Sk), Ústredná polnohospodárska knižnica (piarista rendház)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N84','Nogent-le-Rotrou (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N85','Nardò (It), Biblioteca Antonio Sanfelice della Curia vescovile','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N89','New York, NY (USA), General Theological Seminary Library of the Protestant Episcopal Church','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('N98','Namur (Be), Bibliothèque des Facultés Notre Dame de la Paix','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O01','Oxford (UK), Bodleian Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O03','Orléans (Fr), Médiathèque municipale','http://www.bm-orleans.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O05','Oxford (UK), Wadham College Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O06','Oxford (UK), Keble College Library','http://www.keble.ox.ac.uk/life/library/index.php',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O08','Oxford (UK), Merton College Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O09','Oxford (UK), Codrington Library (All Souls)','http://www.all-souls.ox.ac.uk/library/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O10','Oxford (UK), Christ Church Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O103','Oxford (UK), St Edmund Hall Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O11','Oxford (UK), Taylorian Institute Library','http://www.taslib.ox.ac.uk/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O12','Oxford (UK), Worcester College Library','http://www.worc.ox.ac.uk/Library/index.html',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O13','Oxford (UK), Magdalen College Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O15','Oxford (UK), Corpus Christi College Library','http://www.ccc.ox.ac.uk/library/library.htm',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O17','Oxford (UK), St John\'s College Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O18','Oxford (UK), Jesus College Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O19','Oxford (UK), Queen\'s College Library','http://www.queens.ox.ac.uk/library/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O21','Oxford (UK), New College Library','http://www.bodley.ox.ac.uk/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O22','Oxford (UK), Balliol College Library','http://web.balliol.ox.ac.uk/library/index.asp',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O23','Oxford (UK), Oriel College Library','http://www.oriel.ox.ac.uk',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O27','Oviedo (Es), Biblioteca Universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O29','Oxford (UK), Brasenose College Library','http://www.bnc.ox.ac.uk/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O30','Oxford (UK), Exeter College Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O31','Oxford (UK), Bodleian Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O38','Oxford (UK), Lincoln College Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O40','Oxford (UK), Manchester College Library','http://www.hmc.ox.ac.uk/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O43','Oxford (UK), Pusey House','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O44','Oxford (UK), Regent\'s Park College Library','http://www.rpc.ox.ac.uk',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O50','Oxford (UK), Trinity College Library','http://www.trinity.ox.ac.uk/college/library/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O51','Oxford (UK), University College Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O60','Ottobeuren (De), Benediktinerabtei','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O93','Oosterhout (Nl), S. Paulus abdij','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('O95','Ostra Vetere (It), Biblioteca comunale Giuseppe Tanfani','http://www.comune.ostravetere.an.it/servizipubblici.php#serviziculturali',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P01','Paris (Fr), Bibliothèque nationale de France','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P02','Paris (Fr), Bibliothèque de l\'Arsenal','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P03','Paris (Fr), Bibliothèque Mazarine','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P04','Paris (Fr), Bibliothèque de la société de l\'histoire du protestantisme français','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P05','Paris (Fr), Bibliothèque Sainte Geneviève','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P09','Paris (Fr), Université de Paris, Bibliothèque interuniversitaire de la Sorbonne','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P10','Pau (Fr), Bibliothèque intercommunale Pau-Pyrénées','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P108','Padova (It), Biblioteca civica','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P109','Pesaro (It), Biblioteca Oliveriana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P11','Poitiers (Fr), Médiathèque municipale François Mitterrand','http://www.bm-poitiers.fr/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P113','','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P119','Praha (Cz), Universitní knihovna','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P12','Poitiers (Fr), Bibliothèque universitaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P120','Padova (It), Biblioteca del Seminario maggiore','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P128','Pavia (It), Biblioteca del Seminario vescovile','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P13','Princeton, NJ (USA), University Library','http://libweb.princeton.edu/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P131','Passau (De), Staatliche Bibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P14','Princeton, NJ (USA), Theological Seminary','http://www.ptsem.edu/grow/Library/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P149','Pamplona (Es), Biblioteca General de Navarra','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P15','Philadelphia, PA (USA), Pennsylvania University Library','http://www.library.upenn.edu/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P158','Padova (It), Biblioteca del Dipartimento di farmacologia E. Meneghetti dell\'Università','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P18','Palma de Mallorca (Sp), Biblioteca Pública del Estado','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P180','Paola (It), Biblioteca Charitas','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P19','Paris (Fr), Bibliothèque universitaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P20','Private collections','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P21','Peterborough (UK), Cathedral Library (on deposit in Cambridge University Library)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P212','Paris (Fr), Bibliothèque de la société bibliographique','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P214','Padova (It), Biblioteca capitolare','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P22','Pamplona (Sp), Biblioteca Capitular de Pamplona (Catedral)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P222','Piacenza (It), Biblioteca del Collegio cardinale Giulio Alberoni','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P223','Piacenza (It), Biblioteca del Seminario vescovile','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P224','Piacenza (It), Biblioteca dell\'Istituto Cristoforo Colombo dei Missionari Scalabriniani di S. Carlo Borromeo','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P231','Pistoia (It), Biblioteca Leoniana','http://biblio.comune.pistoia.it/easyweb/new/leon.html',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P233','Padova (It), Biblioteca del Seminario Vescovile della Facoltà Teologica del Triveneto dell’Istituto Filosofico Aloisianum','http://www.seminariopadova.it',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P24','Padova (It), Biblioteca universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P249','Paris (Fr), Conservatoire national des arts et métiers','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P26','Parma (It), Biblioteca Palatina','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P36','Paris (Fr), Bibliothèque Mazarine','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P37','Paris (Fr), Bibliothèque nationale de France','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P38','Perpignan (Fr), Médiathèque municipale','http://www.bm-perpignan.com',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P40','Paderborn (De), Erzbischöfliche Akademische Bibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P43','Périgueux (Fr), Bibliothèque municipale','http://82.127.69.131/clientBookLine/home.asp',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P44','Pommersfelden (De), Schlossbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P49','Provins (Fr), Bibliothèque municipale Alain Peyrefitte','http://www.esaupe77.com',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P52','Privas (Fr), Médiathèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P53','Palma de Mallorca (Es), Biblioteca Provincial','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P56','Perugia (It), Biblioteca comunale Augusta','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P60','Perigueux (Fr), Archives départementales','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P63','Poznañ (Pl), Biblioteka Uniwersytecka','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P64','Pinerolo (It), Biblioteca comunale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P68','Pont-à-Mousson (Fr), Médiathèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P69','Paris (Fr), Bibliothèque inter-universitaire de Médecine','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P72','Piacenza (It), Biblioteca comunale Passerini-Landi','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P78','Paris (Fr), Bibliothèque de l\'Ecole Normale Supérieure','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P79','Porto (Po), Biblioteca Pública Municipal','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P91','Pau (Fr), Bibliothèque du château','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('P99','Palaiseau (Fr), Bibliothèque centrale de l\'école polytechnique','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('Q02','Quimper (Fr), Bibliothèques Quimper communauté','http://bibliotheques.quimper-communaute.fr/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R01','Rouen (Fr), Bibliothèque municipale','http://bibliotheque.rouen.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R02','Rouen (Fr), Bibliothèque universitaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R03','La Rochelle (Fr), Bibliothèque municipale','http://ccfr.bnf.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R04','Rennes (Fr), Bibliothèque municipale','http://www.bm-rennes.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R05','Reims (Fr), Bibliothèque municipale','http://www.bm-reims.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R06','Roma (VA), Biblioteca Apostolica vaticana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R10','Roanne (Fr), Médiathèque municipale','http://andrea.nfrance.com/~eq33744/mediatheque.htm',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R11','Rostock (De), Universitätsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R110','Reggio nell\'Emilia (It), Biblioteca del Capitolo della Cattedrale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R111','Reggio nell\'Emilia (It), Biblioteca del Santuario della Ghiara','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R112','Reggio nell\'Emilia (It), Biblioteca del Seminario urbano','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R113','Rimini (It), Biblioteca del Seminario vescovile - San Fortunato','http://www.diocesi.rimini.it/diocesi/biblioteca.htm',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R115','Roma (It), Biblioteca del Dipartimento di matematica Guido Castelnuovo dell\'Università degli studi di Roma La Sapienza','http://library.mat.uniroma1.it',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R118','Roma (It), Biblioteca del Dipartimento di storia moderna e contemporanea dell\'Università degli studi di Roma La Sapienza','http://w3.uniroma1.it/dsmc/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R12','Roma (It), Biblioteca Angelica','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R13','Roma (It), Biblioteca nazionale centrale Vittorio Emanuele II','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R14','Roma (It), Biblioteca Vallicelliana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R16','Regensburg (De), Staatliche Bibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R17','Ripon (UK), Cathedral Library','http://www.riponcathedral.org.uk',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R18','Roma (It), Biblioteca Casanatense','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R20','Rodez (Fr), Médiathèque municipale','http://ccfr.bnf.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R21','Roma (It), Biblioteca della Facoltà Valdese di Teologia','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R31','Roma (It), Biblioteca dell\'Accademia dei Lincei e Corsiniana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R41','Roma (Vat), Biblioteca Apostolica Vaticana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R43','Reggio nell’Emilia (It), Biblioteca municipale Antonio Panizzi','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R45','Rotterdam (Nl), Bibliotheek Rotterdam (Gemeentebibliotheek)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R54','Riom (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R56','Roma (It), Biblioteca della Fondazione Marco Besso','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R59','Rotterdam (Nl), Bibliotheek Erasmus Universiteit','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R62','Roma (It), Biblioteca Lancisiana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R76','Roma (It), Biblioteca universitaria Alessandrina','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R79','Rieti (It), Biblioteca comunale Paroniana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('R93','Rochester (UK), Cathedral Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S01','Strasbourg (Fr), Bibliothèque publique et universitaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S02','Saint-Lô (Fr), Médiathèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S04','Saint-Omer (Fr), Bibliothèque d\'agglomération de Saint-Omer','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S06','Saint-Etienne (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S07','Stockholm (Se), Kungliga biblioteket','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S10','Strasbourg (Fr), Bibliothèque du grand séminaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S105','Sint-Truiden (Be), Kleinseminarie','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S108','St Petersburg (Ru), University Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S11','Salamanca (Sp), Universidad de Salamanca','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S112','Sigmaringen (De), Hofbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S116','San Millán de la Cogolla (Es), Monasterio de San Millán de la Cogolla de Yuso','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S119','Saint-Cyr (Fr), Bibliothèque de l\'école spéciale militaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S128','Schlatt (Ch), Eisenbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S13','Stuttgart (De), Württembergische Landesbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S135','Santander (Es), Biblioteca de Menéndez y Pelayo','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S138','Sassari (It), Biblioteca universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S140','Sevilla (Es), Biblioteca Universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S141','Spoleto (It), Biblioteca comunale Giosuè Carducci','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S142','Sint-Truiden (Be), Provincie Limburg - Documentatiecentrum','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S144','Salamanca (Es), Biblioteca de la Universidad Pontifica','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S147','Salamanca (Es), Convento de Dominicas Dueñas','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S15','St Petersburg (Ru), National Library of Russia (Saltykov-Shchedrin State Public Library)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S16','Strängnäs (Se), Domkyrkans Bibliotek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S19','Santiago de Compostela (Es), Biblioteca Universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S20','Sevilla (Es), Biblioteca Capitular Y Colombina','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S207','Subiaco (It), Biblioteca Pio VI','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S21','Soissons (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S222','Sarsina (It), Biblioteca del Seminario vescovile','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S226','Subiaco (It), Biblioteca Pio VI','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S235','Southwell (UK), Southwell Minster','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S24','St Gallen (Ch), Kantonsbibliothek Vadiana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S25','San Lorenzo de El Escorial (Sp), Real Monasterio','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S258','Sibiu (Ro), Arhivele Statului','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S259','Sibiu (Ro), Biblioteca centralã episcopalã a bisericii evanghelice (Bischöfliche Zentralbücherei der Evangelischen Kirche des Augsburger Bekenntnisses','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S261','Sighişoara (Ro), Biblioteca municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S28','Salisbury (UK), Cathedral Library','http://www.salisburycathedral.org.uk/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S30','Schaffhausen (Ch), Stadtbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S31','Sélestat (Fr), Médiathèque intercommunale','http://www.ville-selestat.fr/bhselestat/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S38','Strasbourg (Fr), Bibliothèque municipale','http://www.sdv.fr/strbg/F/culture/bibliotheque.html',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S42','Salins-les-Bains (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S44','Santiago de Compostela (Sp), Universidad de Santiago de Compostela, Biblioteca General','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S53','Saint-Calais (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S54','Salamanca (Es), Biblioteca Universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S62','Saint-Brieuc (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S67','Sibiu (Ro), Biblioteca Muzeului Brukenthal (Bruckenthal Museum)','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S75','Sevilla (Sp), Universidad de Sevilla','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S78','St Asaph (UK), Cathedral Library','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S88','Sydney (Au), State Library of New South Wales','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S94','St Louis, MO (USA), Concordia Seminary Library','http://www.csl.edu/library/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('S96','Siena (It), Biblioteca comunale degli Intronati','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T01','Toulouse (Fr), Médiathèque José Cabanis','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T02','Toulouse (Fr), Bibliothèque universitaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T03','Troyes (Fr), Médiathèque de l\'Agglomération Troyenne','http://www.mediatheque-agglo-troyes.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T04','Tours (Fr), Bibliothèque municipale','http://www.bm-tours.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T05','Tournai (Be), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T06','Tours (Fr), Bibliothèque universitaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T10','Terrebasse (Fr), Château','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T100','Torino (It), Biblioteca dell\'Accademia delle scienze','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T101','Torino (It), Biblioteca civica centrale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T103','Torino (It), Biblioteca dell\'Istituto internazionale Don Bosco','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T106','Tortona (It), Biblioteca del Seminario vescovile','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T107','Torino (It), Biblioteca dell\'Istituto sociale dei padri gesuiti','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T111','Torino (It), Biblioteca del Seminario arcivescovile','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T124','Todi (It), Biblioteca comunale Lorenzo Leoni','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T13','Trier (De), Stadtbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T132','Torino (It), Biblioteca del Centro teologico','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T14','Toronto (Ca), Thomas Fisher Rare Book Library of the University of Toronto','http://www.library.utoronto.ca',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T143','Treia (It), Accademia Georgica','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T157','Torino (It), Biblioteca del Dipartimento di filologia, linguistica e tradizione classica dell\'Università degli studi di Torino','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T159','Torino (It), Biblioteca provinciale di filosofia San Tommaso d\'Aquino','http://www.domenicani.it/biblioteche/biblioteche.htm',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T160','Torre Pellice (It), Biblioteca della Fondazione Centro culturale valdese','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T22','Tübingen (De), Universitätsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T30','Tours (Fr), Centre d\'Études Supérieures de la Renaissance','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T31','Torino (It), Biblioteca nazionale universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T39','Toledo (Es), Biblioteca Provincial','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T45','Torino (It), Biblioteca Reale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T53','Toronto (Ca), Victoria University Library','http://gateway.uvic.ca/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T73','Tournai (Be), Bibliothèque du Grand-Séminaire','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T78','Trier (De), Universitätsbibliothek','www.ub.uni-trier.de/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T85','Torino (It), Biblioteca dei Cappuccini','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T87','Terni (It), Biblioteca comunale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T92','Tilburg (Nl), Universiteitsbibliotheek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T93','Torino (It), Biblioteca storica della Provincia di Torino','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T94','Treviso (It), Biblioteca comunale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('T98','Torino (It), Biblioteca della Fondazione Luigi Firpo','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('U01','Utrecht (Nl), Universiteitsbibliotheek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('U02','Urbino (It), Biblioteca universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('U03','Uppsala (Se), Universitetsbibliotek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('U07','Utrecht (Nl), Museum Catharijneconvent','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('U11','Urbino (It), Biblioteca centrale dell\'Area umanistica dell\'Università degli studi di Urbino','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('U14','Utrecht (Nl), Universiteitsmuseum','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('U16','Urbania (It), Biblioteca comunale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('U17','Urbino (It), Biblioteca di giurisprudenza e scienze politiche dell\'Università degli studi di Urbino','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('U26','Uppsala (Se), Astronomiska Observatoriet','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('U29','Udine (It), Biblioteca Pietro Bertolla','www.archiviodiocesano.it',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('U30','Udine (It), Biblioteca arcivescovile','http://www.archiviodiocesano.it',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V02','Versailles (Fr), Bibliothèque municipale','http://www.bibliotheques.versailles.fr/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V03','Valognes (Fr), Bibliothèque municipale','http://ccfr.bnf.fr',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V08','Verdun (Fr), Bibliothèque-discothèque intercommunale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V10','Venezia (It), Biblioteca nazionale Marciana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V12','Vesoul (Fr), Bibliothèque municipale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V121','Viterbo (It), Biblioteca archivio S. Francesco alla Rocca','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V15','','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V16','Vendôme (Fr), Bibliothèque intercommunale du Pays de Vendôme','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V19','Valencia / València (Sp), Universidad de Valencia. Biblioteca Histórica','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V20','La Vid (Es), Biblioteca del Monasterio de Santa María de la Vid. PP. Agustinos','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V23','Valladolid (Sp), Catedral','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V30','Vicenza (It), Biblioteca civica Bertoliana','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V35','Valladolid (Sp), Universitaria y de Santa Cruz','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V41','Viterbo (It), Biblioteca consorziale','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V48','Venezia (It), Biblioteca S. Francesco della Vigna','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V55','Venezia (It), Biblioteca Querini Stampalia','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V58','Valencia (Es), Biblioteca Universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V59','Veroli (It), Biblioteca statale del Monumento nationale di Casamari','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V60','Valladolid (Es), Biblioteca Universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V61','Vigevano (It), Biblioteca del Seminario vescovile','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('V93','Venezia (It), Biblioteca della Congregazione armena mechitarista','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W01','Wolfenbüttel (De), Herzog August Bibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W02','Washington, DC (USA), Library of Congress','http://www.loc.gov/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W04','Wrocław (Pl), Biblioteka Uniwersytecka','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W05','Wrocław (Pl), Biblioteka Ossolineum','http://www.oss.wroc.pl/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W06','Wien (At), Österreichische Nationalbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W07','Warszawa (Pl), Biblioteka Narodowa','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W10','','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W14','Wien (At), Stadt- und Landesbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W15','Worcester (UK), Cathedral Library','http://www.cofe-worcester.org.uk/cathedral/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W17','Winchester (UK), Cathedral Library','http://www.winchester-cathedral.org.uk/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W20','Wien (Au), Österreichische Nationalbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W25','Wolfenbüttel (Gw), Herzog August Bibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W28','Würzburg (De), Universitätsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W29','Warszawa (Pl), Biblioteka Uniwersytecka','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W31','Wells (UK), Cathedral Library','http://www.wellscathedral.org.uk/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W39','Winchester College (UK)','http://www.winchestercollege.co.uk',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W42','Wiener Neustadt (At), Zisterzienserstift Neukloster','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W45','Weimar (De), Herzogin Anna Amalia Bibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('W76','Woerden (Nl), Minderbroedersklooster','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('X01','Xanten (De), Stiftsbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('X03','{NO KNOWN SURVIVING COPY}','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('Y01','Yzeure (Fr), Archives départementales','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('Y02','York (UK), York Minster','http://www.yorkminster.org',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('Y03','Yale University, Beinecke Library, New Haven, CT (USA)','http://www.library.yale.edu/',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('Y06','Yale Medical Historical Library, New Haven, CT (USA)','http://info.med.yale.edu',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('Z01','Zürich (Ch), Zentralbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('Z03','Zaragoza (Es), Biblioteca Universitaria','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('Z05','Zwickau (De), Ratschulbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('Z15','Zaragoza (Sp), Colegio de los Padres Escolapios, Biblioteca','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('Z21','Zaragoza (Sp), Universidad de Zaragoza','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('Z23','Zürich (Sz), Zentralbibliothek','',NULL);
INSERT INTO `erasmus`.`bibliothecae` (`bibliothecae_id`,`bibliothecae_library`,`bibliothecae_web`,`bibliothecae_weighting`) VALUES ('Z34','Zutphen (Nl), Librye der St Walburgskerk','',NULL);

COMMIT;
