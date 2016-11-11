CREATE DATABASE IF NOT EXISTS Music;
USE Music;
CREATE TABLE IF NOT EXISTS BillboardHot100 (
  ID           INT AUTO_INCREMENT,
  currentRank  INT         NOT NULL,
  previousRank INT DEFAULT NULL
  COMMENT 'Previous rank updates every week',
  SongName     VARCHAR(45) NOT NULL,
  releaseDate  DATE        NOT NULL,
  artistName   VARCHAR(45) NOT NULL,
  albumName    VARCHAR(45) NOT NULL,
  genre        VARCHAR(45) NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE IF NOT EXISTS BillboardTop200 (
  ID            INT AUTO_INCREMENT,
  releaseDate   DATE        NOT NULL,
  artistName    VARCHAR(45) NOT NULL,
  albumName     VARCHAR(45) NOT NULL,
  genre         VARCHAR(45) NOT NULL,
  numberOfSongs INT         NOT NULL,
  currentRank   INT         NOT NULL,
  previousRank  INT DEFAULT NULL
  COMMENT 'Previous rank updates every week',
  PRIMARY KEY (ID)
);

CREATE TEMPORARY TABLE IF NOT EXISTS CopyOfBillboardHot100 LIKE BillboardHot100;
DROP TABLE BillboardHot100;

SHOW TABLES;
Describe BillboardTop200;