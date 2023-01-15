CREATE TABLE car.tec_group (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	"name" varchar NOT NULL,
	CONSTRAINT tec_group_pk PRIMARY KEY (id),
	CONSTRAINT tec_group_name_pk_un UNIQUE ("name")
);