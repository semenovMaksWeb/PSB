CREATE TABLE car.stamp (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	id_country int not null,
	"name" varchar NOT NULL,
	logo varchar NOT null,
	date_foundation date,
	description varchar NULL,
	CONSTRAINT stamp_pk PRIMARY KEY (id),
	CONSTRAINT stamp_name_pk_un UNIQUE ("name"),
	CONSTRAINT country_fk FOREIGN KEY (id_country) REFERENCES libs.country(id)
);