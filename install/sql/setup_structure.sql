-- MySQL Script generated by MySQL Workbench
-- 04/11/17 17:09:28
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema melisv2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `melis_cms_page_tree`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `melis_cms_page_tree` ;

CREATE TABLE IF NOT EXISTS `melis_cms_page_tree` (
  `tree_page_id` INT(11) NOT NULL,
  `tree_father_page_id` INT(11) NOT NULL DEFAULT '-1',
  `tree_page_order` INT(11) NOT NULL,
  PRIMARY KEY (`tree_page_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'List of Melis pages, and their parents';


-- -----------------------------------------------------
-- Table `melis_cms_lang`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `melis_cms_lang` ;

CREATE TABLE IF NOT EXISTS `melis_cms_lang` (
  `lang_cms_id` INT NOT NULL AUTO_INCREMENT,
  `lang_cms_locale` VARCHAR(10) NOT NULL,
  `lang_cms_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`lang_cms_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `melis_cms_page_lang`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `melis_cms_page_lang` ;

CREATE TABLE IF NOT EXISTS `melis_cms_page_lang` (
  `plang_id` INT(11) NOT NULL AUTO_INCREMENT,
  `plang_page_id` INT(11) NOT NULL,
  `plang_lang_id` INT(11) NOT NULL,
  `plang_page_id_initial` INT(11) NOT NULL,
  PRIMARY KEY (`plang_id`),
  INDEX `lang_page_id_idx` (`plang_page_id` ASC),
  INDEX `lang_page_id_initial_idx` (`plang_page_id_initial` ASC),
  INDEX `lang_lang_id_idx` (`plang_lang_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Relation between pages and lang';


-- -----------------------------------------------------
-- Table `melis_cms_site`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `melis_cms_site` ;

CREATE TABLE IF NOT EXISTS `melis_cms_site` (
  `site_id` INT(11) NOT NULL AUTO_INCREMENT,
  `site_name` VARCHAR(45) NOT NULL,
  `site_main_page_id` INT(11) NOT NULL,
  PRIMARY KEY (`site_id`),
  INDEX `site_main_page_id_idx` (`site_main_page_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'List of melis websites declared';


-- -----------------------------------------------------
-- Table `melis_cms_template`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `melis_cms_template` ;

CREATE TABLE IF NOT EXISTS `melis_cms_template` (
  `tpl_id` INT(11) NOT NULL,
  `tpl_site_id` INT(11) NOT NULL,
  `tpl_name` VARCHAR(255) NOT NULL,
  `tpl_type` ENUM('PHP','ZF2') NOT NULL DEFAULT 'ZF2',
  `tpl_zf2_website_folder` VARCHAR(50) NULL DEFAULT NULL,
  `tpl_zf2_layout` VARCHAR(50) NULL DEFAULT NULL,
  `tpl_zf2_controller` VARCHAR(50) NULL DEFAULT NULL,
  `tpl_zf2_action` VARCHAR(50) NULL DEFAULT NULL,
  `tpl_php_path` VARCHAR(150) NULL DEFAULT NULL,
  `tpl_creation_date` DATETIME NULL,
  `tpl_last_user_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`tpl_id`),
  INDEX `tpl_site_id_idx` (`tpl_site_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'List of Melis Templates used by the pages';


-- -----------------------------------------------------
-- Table `melis_cms_page_published`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `melis_cms_page_published` ;

CREATE TABLE IF NOT EXISTS `melis_cms_page_published` (
  `page_id` INT(11) NOT NULL,
  `page_type` ENUM('SITE','FOLDER','PAGE') NOT NULL DEFAULT 'PAGE',
  `page_status` TINYINT(4) NOT NULL DEFAULT '1',
  `page_menu` ENUM('LINK','NOLINK','NONE') NOT NULL DEFAULT 'LINK',
  `page_name` VARCHAR(255) NOT NULL,
  `page_tpl_id` INT(11) NOT NULL,
  `page_content` LONGTEXT NULL DEFAULT NULL,
  `page_taxonomy` TEXT NULL,
  `page_creation_date` DATETIME NULL DEFAULT NULL,
  `page_edit_date` DATETIME NULL DEFAULT NULL,
  `page_last_user_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`page_id`),
  INDEX `pub_page_tpl_id_idx` (`page_tpl_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'List of published pages';


-- -----------------------------------------------------
-- Table `melis_cms_page_saved`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `melis_cms_page_saved` ;

CREATE TABLE IF NOT EXISTS `melis_cms_page_saved` (
  `page_id` INT(11) NOT NULL,
  `page_type` ENUM('SITE','FOLDER','PAGE') NOT NULL DEFAULT 'PAGE',
  `page_status` TINYINT(4) NOT NULL DEFAULT '1',
  `page_menu` ENUM('LINK','NOLINK','NONE') NOT NULL DEFAULT 'LINK',
  `page_name` VARCHAR(255) NOT NULL,
  `page_tpl_id` INT(11) NOT NULL,
  `page_content` LONGTEXT NULL DEFAULT NULL,
  `page_taxonomy` TEXT NULL,
  `page_creation_date` DATETIME NULL,
  `page_edit_date` DATETIME NULL,
  `page_last_user_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`page_id`),
  INDEX `save_page_tpl_id_idx` (`page_tpl_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'List of saved pages';


-- -----------------------------------------------------
-- Table `melis_cms_page_seo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `melis_cms_page_seo` ;

CREATE TABLE IF NOT EXISTS `melis_cms_page_seo` (
  `pseo_id` INT(11) NOT NULL,
  `pseo_url` VARCHAR(255) NULL,
  `pseo_url_redirect` VARCHAR(255) NULL,
  `pseo_url_301` VARCHAR(255) NULL,
  `pseo_meta_title` VARCHAR(255) NULL,
  `pseo_meta_description` VARCHAR(255) NULL,
  PRIMARY KEY (`pseo_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'SEO datas for pages';


-- -----------------------------------------------------
-- Table `melis_cms_platform_ids`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `melis_cms_platform_ids` ;

CREATE TABLE IF NOT EXISTS `melis_cms_platform_ids` (
  `pids_id` INT(11) NOT NULL AUTO_INCREMENT,
  `pids_page_id_start` INT(11) NOT NULL,
  `pids_page_id_current` INT(11) NOT NULL,
  `pids_page_id_end` INT(11) NOT NULL,
  `pids_tpl_id_start` INT(11) NOT NULL,
  `pids_tpl_id_current` INT(11) NOT NULL,
  `pids_tpl_id_end` INT(11) NOT NULL,
  PRIMARY KEY (`pids_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Saves ids intervals for each environment so that no duplicate id can occur between platforms';


-- -----------------------------------------------------
-- Table `melis_cms_site_404`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `melis_cms_site_404` ;

CREATE TABLE IF NOT EXISTS `melis_cms_site_404` (
  `s404_id` INT(11) NOT NULL AUTO_INCREMENT,
  `s404_site_id` INT(11) NOT NULL,
  `s404_page_id` INT(11) NOT NULL,
  PRIMARY KEY (`s404_id`),
  INDEX `404_site_id_idx` (`s404_site_id` ASC),
  INDEX `404_page_id_idx` (`s404_page_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'List of 404 pages per site';


-- -----------------------------------------------------
-- Table `melis_cms_site_domain`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `melis_cms_site_domain` ;

CREATE TABLE IF NOT EXISTS `melis_cms_site_domain` (
  `sdom_id` INT(11) NOT NULL AUTO_INCREMENT,
  `sdom_site_id` INT(11) NOT NULL,
  `sdom_env` VARCHAR(50) NOT NULL,
  `sdom_scheme` VARCHAR(10) NOT NULL,
  `sdom_domain` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`sdom_id`),
  INDEX `dom_site_id_idx` (`sdom_site_id` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'List of domains per site and per environments';


-- -----------------------------------------------------
-- Table `melis_cms_site_301`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `melis_cms_site_301` ;

CREATE TABLE IF NOT EXISTS `melis_cms_site_301` (
  `s301_id` INT NOT NULL AUTO_INCREMENT COMMENT 'site redirect id',
  `s301_old_url` VARCHAR(255) NOT NULL COMMENT 'Old Site url',
  `s301_new_url` VARCHAR(255) NOT NULL COMMENT 'New Site url',
  PRIMARY KEY (`s301_id`))
ENGINE = InnoDB
COMMENT = 'Site redirect';


-- -----------------------------------------------------
-- Table `melis_cms_page_default_urls`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `melis_cms_page_default_urls` ;

CREATE TABLE IF NOT EXISTS `melis_cms_page_default_urls` (
  `purl_page_id` INT NOT NULL AUTO_INCREMENT,
  `purl_page_url` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`purl_page_id`))
ENGINE = InnoDB
COMMENT = 'This table saves the URLs of all pages, avoiding generation on demand by juste requesting it';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `melis_cms_lang`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `melis_cms_lang` (`lang_cms_id`, `lang_cms_locale`, `lang_cms_name`) VALUES (1, 'en_EN', 'English');
INSERT INTO `melis_cms_lang` (`lang_cms_id`, `lang_cms_locale`, `lang_cms_name`) VALUES (2, 'fr_FR', 'Français');

COMMIT;


-- -----------------------------------------------------
-- Data for table `melis_cms_site_404`
-- -----------------------------------------------------
START TRANSACTION;
INSERT INTO `melis_cms_site_404` (`s404_id`, `s404_site_id`, `s404_page_id`) VALUES (1, -1, 1);

COMMIT;

