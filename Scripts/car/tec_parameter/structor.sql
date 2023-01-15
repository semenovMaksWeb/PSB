CREATE TABLE car.tec_parameter (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	id_tec_group int NULL,
	"name" varchar NOT NULL,
	CONSTRAINT tec_parameter_pk PRIMARY KEY (id),
	CONSTRAINT tec_parameter_name_pk_un UNIQUE ("name"),
	CONSTRAINT tec_group_fk FOREIGN KEY (id_tec_group) REFERENCES car.tec_group(id)
);