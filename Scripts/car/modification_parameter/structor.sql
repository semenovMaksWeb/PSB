CREATE TABLE car.modification_parameter (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	id_modification int not NULL,
	id_tec_parameter int not NULL,
	"value" varchar NOT NULL,
	CONSTRAINT modification_parameter_pk PRIMARY KEY (id),
	CONSTRAINT modification_fk FOREIGN KEY (id_modification) REFERENCES car.modification(id),
	CONSTRAINT tec_parameter_fk FOREIGN KEY (id_tec_parameter) REFERENCES car.tec_parameter(id)
);