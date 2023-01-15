CREATE TABLE car.model (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	id_stamp int not null,
	"name" varchar NOT NULL,
	description varchar NULL,
	CONSTRAINT model_pk PRIMARY KEY (id),
	CONSTRAINT model_name_pk_un UNIQUE ("name"),
	CONSTRAINT stamp_fk FOREIGN KEY (id_smarp) REFERENCES car.stamp(id)
);