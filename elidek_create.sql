DROP SCHEMA IF EXISTS elidek;
CREATE SCHEMA elidek;
USE elidek;

CREATE TABLE organization (
	org_id int(10) NOT NULL,
	acronym varchar(15) NOT NULL,
	`name` varchar(100) NOT NULL,
	postal_code varchar(6) NOT NULL,
	street varchar(100) NOT NULL,
	city varchar(100) NOT NULL,
	PRIMARY KEY (org_id) 
);


CREATE TABLE researcher (
	res_id int(10) NOT NULL,
	`name` varchar(100) NOT NULL,
	gender varchar(15) NOT NULL,
	birthdate date NOT NULL,
	employing_org int(10) NOT NULL,
	employment_date date NOT NULL,
	FOREIGN KEY (employing_org) references organization(org_id),
	PRIMARY KEY (res_id)
);


CREATE TABLE program (
	prog_id int(10) NOT NULL,
	title varchar(100) NOT NULL,
	department varchar(100) NOT NULL,
	PRIMARY KEY (prog_id)
);


CREATE TABLE executive (
	exec_id int(10) NOT NULL,
	`name` varchar(100) NOT NULL,
     PRIMARY KEY (exec_id)
);


CREATE TABLE scientific_field (
	title varchar(100) NOT NULL,
	field_id int(10) NOT NULL,
	PRIMARY KEY (field_id)
);


CREATE TABLE project (
	proj_id int(10) NOT NULL,
	title varchar(100) NOT NULL,
	budget float(9,2) NOT NULL,
	started_on date NOT NULL,
	ends_on date NOT NULL,
	summary varchar(500) null,
	supervisor int(10) NOT NULL,
	assocd_prog int(10) NOT NULL,
	assocd_exec int(10) NOT NULL,
	assocd_org int(10) NOT NULL,
	FOREIGN KEY (supervisor) references researcher(res_id),
	FOREIGN KEY (assocd_prog) references program(prog_id),
	FOREIGN KEY (assocd_exec) references executive(exec_id),
	FOREIGN KEY (assocd_org) references organization(org_id),
	PRIMARY KEY (proj_id)
);


CREATE TABLE researcher_works_on_project (
	project int(10) NOT NULL,
	researcher int(10) NOT NULL,
	FOREIGN KEY (researcher) references researcher(res_id),
	FOREIGN KEY (project) references project(proj_id),
	PRIMARY KEY (project, researcher)
);


CREATE TABLE researcher_evaluates_project (
	project int(10) NOT NULL,
	researcher int(10) NOT NULL,
	grade int(3) NOT NULL,
	`date` date NOT NULL,
	FOREIGN KEY (project) references project(proj_id),
	FOREIGN KEY (researcher) references researcher(res_id),
	PRIMARY KEY (project, researcher)

);


CREATE TABLE scientific_field_of_project (
	project int(10) NOT NULL,
	field int(10) NOT NULL,
	FOREIGN KEY (project) references project(proj_id),
	FOREIGN KEY (field) references scientific_field(field_id),
	PRIMARY KEY (project, field)
);


CREATE TABLE project_task (
	project int(10) NOT NULL,
	title varchar(100) NOT NULL,
	summary varchar(500) null,
	due_date date NOT NULL,
	FOREIGN KEY (project) references project(proj_id),
	PRIMARY KEY (project, title)
);


CREATE TABLE org_company (
	organization int(10) NOT NULL,
	priv_funds float(9,2) NOT NULL,
	FOREIGN KEY (organization) references organization(org_id),
	PRIMARY KEY (organization)
);


CREATE TABLE org_research_center (
	organization int(10) NOT NULL,
	priv_funds float(9,2) NOT NULL,
	pub_funds float(9,2) NOT NULL,
	FOREIGN KEY (organization) references organization(org_id),
	PRIMARY KEY (organization)
);


CREATE TABLE org_university (
	organization int(10) NOT NULL,
	pub_funds float(9,2) NOT NULL,
	FOREIGN KEY (organization) references organization(org_id),
	PRIMARY KEY (organization)
);


CREATE TABLE org_phone_numbers (
	organization int(10) NOT NULL,
	ph_number varchar(15) NOT NULL,
	FOREIGN KEY (organization) references organization(org_id),
	PRIMARY KEY (ph_number)
);




