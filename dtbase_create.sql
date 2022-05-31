DROP SCHEMA IF EXISTS elidek;
CREATE SCHEMA elidek;
use elidek;

CREATE TABLE organization (
	`Organization ID` INT(10) NOT NULL,
	Acronym varchar(15) NOT NULL,
	`Name` varchar(100) NOT NULL,
	`Postal Code` varchar(6) NOT NULL,
	Street varchar(100) NOT NULL,
	City varchar(100) NOT NULL,
	PRIMARY KEY (`Organization ID`)
);


CREATE TABLE researcher (
	`Researcher ID` INT(10) NOT NULL,
	`First Name` varchar(100) NOT NULL,
	`Last Name` varchar(100) NOT NULL,
	Gender varchar(15) NOT NULL,
	Birthdate DATE NOT NULL,
	Organization int(10) NOT NULL,
	`Employment Date` DATE NOT NULL,
	FOREIGN KEY (Organization) REFERENCES organization(`Organization ID`),
	PRIMARY KEY (`Researcher ID`)
);


CREATE TABLE program (
	`Program ID` INT(10) NOT NULL,
	`Name` varchar(100) NOT NULL,
	Department varchar(100) NOT NULL,
	PRIMARY KEY (`Program ID`)
);


CREATE TABLE executive (
	`Executive ID` INT(10) NOT NULL,
	`First Name` varchar(100) NOT NULL,
	`Last Name` VARCHAR(100) NOT NULL,
     PRIMARY KEY (`Executive ID`)
);


CREATE TABLE scientific_field (
	`Name` varchar(100) NOT NULL,
	`Field ID` int(10) NOT NULL,
	PRIMARY KEY (`Field ID`)
);


CREATE TABLE project (
	`Project ID` INT(10) NOT NULL,
	Title varchar(100) NOT NULL,
	Budget FLOAT(9,2) NOT NULL,
	`Start Date` DATE NOT NULL,
	`End Date` DATE NOT NULL,
	Summary varchar(500) NULL,
	Supervisor int(10) NOT NULL,
	Program int(10) NOT NULL,
	Executive int(10) NOT NULL,
	Organization int(10) NOT NULL,
	FOREIGN KEY (Supervisor) REFERENCES researcher(`Researcher ID`),
	FOREIGN KEY (Program) REFERENCES program(`Program ID`),
	FOREIGN KEY (Executive) REFERENCES executive(`Executive ID`),
	FOREIGN KEY (Organization) REFERENCES organization(`Organization ID`),
	PRIMARY KEY (`Project ID`)
);


CREATE TABLE researcher_works_on_project (
	Project int(10) NOT NULL,
	Researcher int(10) NOT NULL,
	FOREIGN KEY (Researcher) REFERENCES researcher(`Researcher ID`),
	FOREIGN KEY (Project) REFERENCES project(`Project ID`),
	PRIMARY KEY (Project, Researcher)
);


CREATE TABLE researcher_evaluates_project (
	Project int(10) NOT NULL,
	Researcher int(10) NOT NULL,
	Grade int(3) NOT NULL,
	`Date` DATE NOT NULL,
	FOREIGN KEY (Project) REFERENCES project(`Project ID`),
	FOREIGN KEY (Researcher) REFERENCES researcher(`Researcher ID`),
	PRIMARY KEY (Project, Researcher)

);


CREATE TABLE scientific_field_of_project (
	Project int(10) NOT NULL,
	Field int(10) NOT NULL,
	FOREIGN KEY (Project) REFERENCES project(`Project ID`),
	FOREIGN KEY (Field) REFERENCES scientific_field(`Field ID`),
	PRIMARY KEY (Project, Field)
);


CREATE TABLE project_task (
	Project int(10) NOT NULL,
	`Task Name` varchar(100) NOT NULL,
	Summary varchar(500) NULL,
	`Due Date` DATE NOT NULL,
	FOREIGN KEY (Project) REFERENCES project(`Project ID`),
	PRIMARY KEY (Project, `Task Name`, `Due Date`)
);


CREATE TABLE org_company (
	Organization int(10) NOT NULL,
	`Private Funds` float(9,2) NOT NULL,
	FOREIGN KEY (Organization) REFERENCES organization(`Organization ID`),
	PRIMARY KEY (Organization)
);


CREATE TABLE org_research_center (
	Organization int(10) NOT NULL,
	`Private Funds` float(9,2) NOT NULL,
	`Ministry of Education Funds` float(9,2) NOT NULL,
	FOREIGN KEY (Organization) REFERENCES organization(`Organization ID`),
	PRIMARY KEY (Organization)
);


CREATE TABLE org_university (
	Organization int(10) NOT NULL,
	`Ministry of Education Funds` float(9,2) NOT NULL,
	FOREIGN KEY (Organization) REFERENCES organization(`Organization ID`),
	PRIMARY KEY (Organization)
);


CREATE TABLE org_phone_numbers (
	Organization INT(10) NOT NULL,
	`Phone Number` varchar(15) NOT NULL,
	FOREIGN KEY (Organization) REFERENCES organization(`Organization ID`),
	PRIMARY KEY (`Phone Number`)
);




