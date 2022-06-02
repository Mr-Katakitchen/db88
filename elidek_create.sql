DROP SCHEMA IF EXISTS elidek;
CREATE SCHEMA elidek;
USE elidek;

CREATE TABLE organization (
	org_id int(10) NOT NULL,
	abbrev varchar(15),
	`name` varchar(100),
	postal_code varchar(6),
	street varchar(100),
	city varchar(100),
	PRIMARY KEY (org_id) 
);


CREATE TABLE researcher (
	res_id int(10) NOT NULL,
	first_name varchar(100),
	last_name varchar(100),
	gender varchar(15),
	birthdate date,
	empl_org int(10),
	empl_date date,
	FOREIGN KEY (empl_org) references organization(org_id),
	PRIMARY KEY (res_id) 
);


CREATE TABLE program (
	prog_id int(10) NOT NULL,
	title varchar(100),
	department varchar(100),
	PRIMARY KEY (prog_id) 
);


CREATE TABLE executive (
	exec_id int(10) NOT NULL,
	first_name varchar(100),
	last_name varchar(100),
    PRIMARY KEY (exec_id) 
);


CREATE TABLE scientific_field (
	title varchar(100) NOT NULL,
	field_id int(10),
	PRIMARY KEY (field_id) 
);


CREATE TABLE project (
	proj_id int(10) NOT NULL,
	title varchar(100),
	budget float(17,2),
	started_on date,
	ends_on date,
	summary varchar(500) null,
	superv_id int(10),
	ass_prog_id int(10),
	ass_exec_id int(10),
	ass_org_id int(10),
	FOREIGN KEY (superv_id) references researcher(res_id),
	FOREIGN KEY (ass_prog_id) references program(prog_id),
	FOREIGN KEY (ass_exec_id) references executive(exec_id),
	FOREIGN KEY (ass_org_id) references organization(org_id),
	PRIMARY KEY (proj_id) 
);


CREATE TABLE researcher_works_on_project (
	proj_id int(10) NOT NULL,
	res_id int(10) NOT NULL,
	FOREIGN KEY (res_id) references researcher(res_id),
	FOREIGN KEY (proj_id) references project(proj_id),
	PRIMARY KEY (proj_id, res_id) 
);


CREATE TABLE researcher_evaluates_project (
	proj_id int(10) NOT NULL,
	res_id int(10) NOT NULL,
	grade int(3),
	`date` date,
	FOREIGN KEY (proj_id) references project(proj_id),
	FOREIGN KEY (res_id) references researcher(res_id),
	PRIMARY KEY (proj_id, res_id) 

);


CREATE TABLE scientific_field_of_project (
	proj_id int(10) NOT NULL,
	field_id int(10) NOT NULL,
	FOREIGN KEY (proj_id) references project(proj_id),
	FOREIGN KEY (field_id) references scientific_field(field_id),
	PRIMARY KEY (proj_id, field_id) 
);


CREATE TABLE project_task (
	proj_id int(10) NOT NULL,
	task_id int(10) NOT NULL,
	title varchar(100),
	summary varchar(500) null,
	due_date date,
	FOREIGN KEY (proj_id) references project(proj_id),
	PRIMARY KEY (proj_id, task_id) 
);


CREATE TABLE org_company (
	org_id int(10) NOT NULL,
	priv_funds float(17,2),
	FOREIGN KEY (org_id) references organization(org_id),
	PRIMARY KEY (org_id) 
);


CREATE TABLE org_research_center (
	org_id int(10) NOT NULL,
	priv_funds float(17,2),
	pub_funds float(17,2),
	FOREIGN KEY (org_id) references organization(org_id),
	PRIMARY KEY (org_id) 
);


CREATE TABLE org_university (
	org_id int(10) NOT NULL,
	pub_funds float(17,2),
	FOREIGN KEY (org_id) references organization(org_id),
	PRIMARY KEY (org_id) 
);


CREATE TABLE org_phone_numbers (
	org_id int(10) NOT NULL,
	ph_number varchar(15) NOT NULL,
	FOREIGN KEY (org_id) references organization(org_id),
	PRIMARY KEY (ph_number) 
);




