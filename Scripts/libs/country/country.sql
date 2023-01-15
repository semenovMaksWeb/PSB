CREATE TABLE libs.country (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	"name" varchar NOT NULL,
	capital varchar NOT NULL,
	description varchar NULL,
	flag varchar NOT NULL,
	CONSTRAINT country_pk PRIMARY KEY (id),
	CONSTRAINT country_un UNIQUE ("name")
);