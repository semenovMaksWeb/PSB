CREATE TABLE car.gen (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	id_model int not null,
	"name" varchar NOT NULL,
	description varchar NULL,
	date_start date NOT NULL,
	date_end date NOT NULL,
	CONSTRAINT gen_pk PRIMARY KEY (id),
	CONSTRAINT gen_name_pk_un UNIQUE ("name"),
	CONSTRAINT model_fk FOREIGN KEY (id_model) REFERENCES car.model(id)
);