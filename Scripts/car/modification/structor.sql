CREATE TABLE car.modification (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	id_country int not null,
	id_car int not null,
	"name" varchar NOT NULL,
	"date" Date NOT null,
	description varchar NULL,
	CONSTRAINT modification_pk PRIMARY KEY (id),
	CONSTRAINT country_modification_fk FOREIGN KEY (id_country) REFERENCES libs.country(id),
	CONSTRAINT car_modification_fk FOREIGN KEY (id_car) REFERENCES car.car(id)
);