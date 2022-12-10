-------------- Práctica de SQL para KeepCoding de María Berraquero García --------------

-- Creo un nuevo esquema con el nombre "practica_mbg":

CREATE SCHEMA practica_mbg authorization oodhuafv;

-- 1. CREACIÓN DE TABLAS

-- Creo la tabla companies que recoge la información del grupo empresarial de la marca

CREATE TABLE practica_mbg.companies(
	id_company SERIAL UNIQUE, -- PK
	name_company varchar(50) NOT NULL,
	description varchar(100) NULL
);

-- Añado la PK de la tabla companies

ALTER TABLE practica_mbg.companies
	ADD CONSTRAINT companies_PK PRIMARY KEY (id_company);

-- Creo la tabla brands donde se recoge la información de las marcas de los coches

CREATE TABLE practica_mbg.brands(
	id_brand SERIAL UNIQUE, -- PK
	id_company integer NOT NULL, -- PK, FK1 (id_company -> companies)
	name_brand varchar(20) NOT NULL,
	description varchar(100) NULL
);

-- Añado las PKs y FKs de la tabla brands

ALTER TABLE practica_mbg.brands
	ADD CONSTRAINT brands_PK PRIMARY KEY (id_brand, id_company);
	
ALTER TABLE practica_mbg.brands
	ADD CONSTRAINT brands_companies_FK1 FOREIGN KEY (id_company) REFERENCES practica_mbg.companies (id_company);

-- Creo la tabla models que recoge la información de los modelos de coche

CREATE TABLE practica_mbg.models(
	id_model SERIAL UNIQUE, -- PK
	id_brand integer NOT NULL, -- PK, FK1 (id_brand -> brands)
	name_model varchar(20) NOT NULL,
	description varchar(100) NULL
);

-- Añado las PKs y FKs de la tabla models

ALTER TABLE practica_mbg.models
	ADD CONSTRAINT models_PK PRIMARY KEY (id_model, id_brand);

ALTER TABLE practica_mbg.models
	ADD CONSTRAINT models_brands_FK1 FOREIGN KEY (id_brand) REFERENCES practica_mbg.brands (id_brand);

-- Creo la tabla colors donde se recoge la información del color de los coches

CREATE TABLE practica_mbg.colors(
	id_color SERIAL UNIQUE, -- PK
	name_color varchar(30) NOT NULL,
	description varchar(100) NULL
);

-- Añado la PKs de la tabla colors

ALTER TABLE practica_mbg.colors
	ADD CONSTRAINT colors_PK PRIMARY KEY (id_color);

-- Creo la tabla cars que va a contener los atributos esenciales de los coches

CREATE TABLE practica_mbg.cars(
	id_car SERIAL UNIQUE, --PK
	id_model integer NOT NULL, -- FK (id_model -> models)
	id_color integer NOT NULL, -- FK (id_color -> colors)
	license_plate varchar(10) NOT NULL, 
	dt_purchase date NOT NULL DEFAULT '2000-05-05',
	kms integer NOT NULL,
	commentary varchar(100) NULL
);

-- Añado las PKs y FKs de la tabla cars

ALTER TABLE practica_mbg.cars
	ADD CONSTRAINT cars_PK PRIMARY KEY (id_car);

ALTER TABLE practica_mbg.cars
	ADD CONSTRAINT cars_models_FK1 FOREIGN KEY (id_model) REFERENCES practica_mbg.models (id_model);
ALTER TABLE practica_mbg.cars
	ADD CONSTRAINT cars_colors_FK2 FOREIGN KEY (id_color) REFERENCES practica_mbg.colors (id_color);

-- Creo la tabla insurance_companies que recoge la información de las compañías de seguro
	
CREATE TABLE practica_mbg.insurance_companies(
	id_ins_company SERIAL UNIQUE, -- PK
	name_ins_company varchar(20) NOT NULL,
	description varchar(100) NULL
);

-- Añado la PK de la tabla insurance_companies

ALTER TABLE practica_mbg.insurance_companies
	ADD CONSTRAINT ins_companies_PK PRIMARY KEY (id_ins_company);

-- Creo la tabla policies que recoge la informacion de la poliza de seguros

CREATE TABLE practica_mbg.policies(
	id_policy varchar(30) NOT NULL, -- PK
	id_car integer NOT NULL, -- PK, FK (id_car -> cars)
	id_ins_company integer NOT NULL, -- FK (id_ins_company -> insurance_companies)
	commentary varchar(100) NULL
);
	
-- Añado los PKs y FKs de la tabla policies

ALTER TABLE practica_mbg.policies
	ADD CONSTRAINT policies_PK PRIMARY KEY (id_policy, id_car);
	
	
ALTER TABLE practica_mbg.policies
	ADD CONSTRAINT policies_cars_FK1 FOREIGN KEY (id_car) REFERENCES practica_mbg.cars (id_car);
ALTER TABLE practica_mbg.policies
	ADD CONSTRAINT policies_insurance_FK2 FOREIGN KEY (id_ins_company) REFERENCES practica_mbg.insurance_companies (id_ins_company);

-- Creo la tabla currencies que recoge la información de las divisas de los pagos

CREATE TABLE practica_mbg.currencies(
	id_currency SERIAL UNIQUE, -- PK
	name_currency varchar(30) NOT NULL,
	description varchar(100) NULL 
);

-- Añado la PK de la tabla currencies

ALTER TABLE practica_mbg.currencies
	ADD CONSTRAINT currencies_PK PRIMARY KEY (id_currency);
	
-- Creo la tabla hist_inspections donde se recoge la información de las revisiones del coche

CREATE TABLE practica_mbg.hist_inspections(
	id_inspection SERIAL UNIQUE, -- PK
	id_car integer NOT NULL, -- PK, FK (id_car -> cars)
	dt_review date NOT NULL,
	kms integer NOT NULL,
	price numeric(12,2) NOT NULL,
	id_currency integer NOT NULL, -- FK (id_currency -> currencies)
	commentary varchar(50) NULL
);

-- Añado las PKs y FKs de la tabla hist_inspections

ALTER TABLE practica_mbg.hist_inspections
	ADD CONSTRAINT inspections_PK PRIMARY KEY (id_inspection, id_car);

ALTER TABLE practica_mbg.hist_inspections
	ADD CONSTRAINT inspections_cars_FK1 FOREIGN KEY (id_car) REFERENCES practica_mbg.cars (id_car);
ALTER TABLE practica_mbg.hist_inspections
	ADD CONSTRAINT inspections_currencies_FK2 FOREIGN KEY (id_currency) REFERENCES practica_mbg.currencies (id_currency);

-- 2. AÑADO LOS DATOS A LAS TABLAS

-- Añado los datos de la tabla companies

INSERT INTO practica_mbg.companies (name_company, description) VALUES ('BMW Group', '');
INSERT INTO practica_mbg.companies (name_company, description) VALUES ('Tesla', '');
INSERT INTO practica_mbg.companies (name_company, description) VALUES ('VinGroup', '');
INSERT INTO practica_mbg.companies (name_company, description) VALUES ('Tata Motors', '');
INSERT INTO practica_mbg.companies (name_company, description) VALUES ('Subaru Corp.', '');
INSERT INTO practica_mbg.companies (name_company, description) VALUES ('Mazda Motor Corp.', '');
INSERT INTO practica_mbg.companies (name_company, description) VALUES ('Hyundai Motor Group', '');
INSERT INTO practica_mbg.companies (name_company, description) VALUES ('Ford Motor Co.', '');
INSERT INTO practica_mbg.companies (name_company, description) VALUES ('Volkswagen AG', '');
INSERT INTO practica_mbg.companies (name_company, description) VALUES ('VinGroup', '');


-- Añado los datos de la tabla brands

INSERT INTO practica_mbg.brands (id_company, name_brand, description) VALUES (2, 'Tesla', '');
INSERT INTO practica_mbg.brands (id_company, name_brand, description) VALUES (7, 'Kia', '');
INSERT INTO practica_mbg.brands (id_company, name_brand, description) VALUES (7, 'Hyundai', '');
INSERT INTO practica_mbg.brands (id_company, name_brand, description) VALUES (5, 'Subaru', '');
INSERT INTO practica_mbg.brands (id_company, name_brand, description) VALUES (9, 'Audi', '');
INSERT INTO practica_mbg.brands (id_company, name_brand, description) VALUES (9, 'Bentley', '');
INSERT INTO practica_mbg.brands (id_company, name_brand, description) VALUES (9, 'Lamborghini', '');
INSERT INTO practica_mbg.brands (id_company, name_brand, description) VALUES (9, 'Porsche', '');
INSERT INTO practica_mbg.brands (id_company, name_brand, description) VALUES (9, 'Volkswagen', '');
INSERT INTO practica_mbg.brands (id_company, name_brand, description) VALUES (8, 'Ford', '');

-- Añado los datos de la tabla models 

INSERT INTO practica_mbg.models (id_brand, name_model, description) VALUES (1, 'Cybertruck', '');
INSERT INTO practica_mbg.models (id_brand, name_model, description) VALUES (1, 'Roadster', '');
INSERT INTO practica_mbg.models (id_brand, name_model, description) VALUES (2, 'Kia Stinger', '');
INSERT INTO practica_mbg.models (id_brand, name_model, description) VALUES (3, 'i30', '');
INSERT INTO practica_mbg.models (id_brand, name_model, description) VALUES (3, 'KONAN', '');
INSERT INTO practica_mbg.models (id_brand, name_model, description) VALUES (5, 'Audi A4', '');
INSERT INTO practica_mbg.models (id_brand, name_model, description) VALUES (6, 'Bentayga', '');
INSERT INTO practica_mbg.models (id_brand, name_model, description) VALUES (6, 'Flying Spur', '');
INSERT INTO practica_mbg.models (id_brand, name_model, description) VALUES (7, 'AVENTADOR SVJ', '');
INSERT INTO practica_mbg.models (id_brand, name_model, description) VALUES (9, 'T-Roc Cabrio', '');

-- Añado los datos de la tabla colors

INSERT INTO practica_mbg.colors (name_color, description) VALUES ('Paradise Blue', '');
INSERT INTO practica_mbg.colors (name_color, description) VALUES ('Plum Crazy Pearl', '');
INSERT INTO practica_mbg.colors (name_color, description) VALUES ('Artic Ice', '');
INSERT INTO practica_mbg.colors (name_color, description) VALUES ('Cosmic Carbon', '');
INSERT INTO practica_mbg.colors (name_color, description) VALUES ('Brilliant Black Pearl', '');

-- Añado los datos de la tabla cars

INSERT INTO practica_mbg.cars (id_model, id_color, license_plate, dt_purchase, kms, commentary) VALUES (1, 2, '3182MXS', default, 455080, '');
INSERT INTO practica_mbg.cars (id_model, id_color, license_plate, dt_purchase, kms, commentary) VALUES (2, 3, '9820QAI', default, 20000, '');
INSERT INTO practica_mbg.cars (id_model, id_color, license_plate, dt_purchase, kms, commentary) VALUES (1, 1, '4795GHU', default, 100000, '');
INSERT INTO practica_mbg.cars (id_model, id_color, license_plate, dt_purchase, kms, commentary) VALUES (3, 1, '4795GHU', default, 10000, '');
INSERT INTO practica_mbg.cars (id_model, id_color, license_plate, dt_purchase, kms, commentary) VALUES (4, 4, '0224RAB', default, 225000, '');
INSERT INTO practica_mbg.cars (id_model, id_color, license_plate, dt_purchase, kms, commentary) VALUES (5, 5, '4060EOB', default, 2500, '');
INSERT INTO practica_mbg.cars (id_model, id_color, license_plate, dt_purchase, kms, commentary) VALUES (6, 5, '3820BOO', default, 100000, '');
INSERT INTO practica_mbg.cars (id_model, id_color, license_plate, dt_purchase, kms, commentary) VALUES (7, 2, '0065GXQ', default, 250000, '');
INSERT INTO practica_mbg.cars (id_model, id_color, license_plate, dt_purchase, kms, commentary) VALUES (8, 5, '8000QDQ', '2021-09-03', 100000, '');
INSERT INTO practica_mbg.cars (id_model, id_color, license_plate, dt_purchase, kms, commentary) VALUES (9, 1, '6681ZYC', default, 300008, '');
INSERT INTO practica_mbg.cars (id_model, id_color, license_plate, dt_purchase, kms, commentary) VALUES (10, 3, '4658CPD', default, 225006, '');
INSERT INTO practica_mbg.cars (id_model, id_color, license_plate, dt_purchase, kms, commentary) VALUES (6, 4, '0437FWJ', default, 250090, '');
INSERT INTO practica_mbg.cars (id_model, id_color, license_plate, dt_purchase, kms, commentary) VALUES (3, 4, '6195EMY', default, 125896, '');

-- Añado los datos de la tabla insurance_companies

INSERT INTO practica_mbg.insurance_companies (name_ins_company, description) VALUES ('Geiko', '');
INSERT INTO practica_mbg.insurance_companies (name_ins_company, description) VALUES ('Nationwide', '');
INSERT INTO practica_mbg.insurance_companies (name_ins_company, description) VALUES ('State Farm', '');

-- Añado los datos de la tabla policies

INSERT INTO practica_mbg.policies (id_car, id_policy, id_ins_company, commentary) VALUES (1, 'KFBQ-EU54-VCUA-8LYU', 1, '');
INSERT INTO practica_mbg.policies (id_car, id_policy, id_ins_company, commentary) VALUES (2, '48CG-3J7L-TCHQ-QATJ', 2, '');
INSERT INTO practica_mbg.policies (id_car, id_policy, id_ins_company, commentary) VALUES (3, 'FVJH-4GQH-HRMA-5PFT', 3, '');
INSERT INTO practica_mbg.policies (id_car, id_policy, id_ins_company, commentary) VALUES (4, '858D-XATV-2SAV-2FEP', 1, '');
INSERT INTO practica_mbg.policies (id_car, id_policy, id_ins_company, commentary) VALUES (5, 'DKVE-VV87-GUGR-59CN', 2, '');
INSERT INTO practica_mbg.policies (id_car, id_policy, id_ins_company, commentary) VALUES (6, 'KEAW-866M-4K3U-8ESM', 3, '');
INSERT INTO practica_mbg.policies (id_car, id_policy, id_ins_company, commentary) VALUES (7, 'RLE4-FCU6-MKNN-3HWG', 1, '');
INSERT INTO practica_mbg.policies (id_car, id_policy, id_ins_company, commentary) VALUES (8, 'KU83-UZ5N-N5M6-7ZT3', 2, '');
INSERT INTO practica_mbg.policies (id_car, id_policy, id_ins_company, commentary) VALUES (9, 'CCG6-24K6-VMVL-4NZB', 3, '');
INSERT INTO practica_mbg.policies (id_car, id_policy, id_ins_company, commentary) VALUES (10, 'EHXP-2CVV-YHEQ-CG8F', 1, '');
INSERT INTO practica_mbg.policies (id_car, id_policy, id_ins_company, commentary) VALUES (11, 'WYRC-HN5R-ELSQ-CDEU', 2, '');
INSERT INTO practica_mbg.policies (id_car, id_policy, id_ins_company, commentary) VALUES (12, 'YMZ4-ZGJY-DASP-VN64', 2, '');
INSERT INTO practica_mbg.policies (id_car, id_policy, id_ins_company, commentary) VALUES (13, 'PN54-W5RN-Y4BE-JB85', 1, '');

-- Añado los datos de la tabla currencies

INSERT INTO practica_mbg.currencies (name_currency, description) VALUES ('EUR', '');
INSERT INTO practica_mbg.currencies (name_currency, description) VALUES ('USD', '');
INSERT INTO practica_mbg.currencies (name_currency, description) VALUES ('JPY', '');
INSERT INTO practica_mbg.currencies (name_currency, description) VALUES ('GBP', '');

-- Añado los datos de la tabla hist_inspections

INSERT INTO practica_mbg.hist_inspections (id_car, dt_review, kms, price, id_currency, commentary) VALUES (1, '2021-09-09', 15000, 350, 1, '');
INSERT INTO practica_mbg.hist_inspections (id_car, dt_review, kms, price, id_currency, commentary) VALUES (2, '2022-03-05', 18000, 355.50, 1, '');
INSERT INTO practica_mbg.hist_inspections (id_car, dt_review, kms, price, id_currency, commentary) VALUES (3, '2021-09-09', 19000, 300, 1, '');
INSERT INTO practica_mbg.hist_inspections (id_car, dt_review, kms, price, id_currency, commentary) VALUES (4, '2021-05-09', 12000, 400, 2, '');
INSERT INTO practica_mbg.hist_inspections (id_car, dt_review, kms, price, id_currency, commentary) VALUES (5, '2020-08-03', 11000, 200, 1, '');
INSERT INTO practica_mbg.hist_inspections (id_car, dt_review, kms, price, id_currency, commentary) VALUES (6, '2021-12-01', 15000, 500, 2, '');
INSERT INTO practica_mbg.hist_inspections (id_car, dt_review, kms, price, id_currency, commentary) VALUES (7, '2018-01-01', 18000, 300.75, 2, '');
INSERT INTO practica_mbg.hist_inspections (id_car, dt_review, kms, price, id_currency, commentary) VALUES (8, '2020-09-09', 19000, 350, 1, '');
INSERT INTO practica_mbg.hist_inspections (id_car, dt_review, kms, price, id_currency, commentary) VALUES (9, '2020-10-23', 156000, 500, 1, '');
INSERT INTO practica_mbg.hist_inspections (id_car, dt_review, kms, price, id_currency, commentary) VALUES (10, '2021-05-30', 15900, 450, 2, '');
INSERT INTO practica_mbg.hist_inspections (id_car, dt_review, kms, price, id_currency, commentary) VALUES (11, '2022-01-09', 18800, 350.50, 1, '');
INSERT INTO practica_mbg.hist_inspections (id_car, dt_review, kms, price, id_currency, commentary) VALUES (12, '2022-04-17', 19900, 350, 2, '');
INSERT INTO practica_mbg.hist_inspections (id_car, dt_review, kms, price, id_currency, commentary) VALUES (13, '2021-09-09', 20000, 300.25, 2, '');