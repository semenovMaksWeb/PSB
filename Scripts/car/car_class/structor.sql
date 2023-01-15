CREATE TABLE car.car_class (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	"name" varchar NOT NULL,
	description varchar NULL,
	CONSTRAINT car_class_pk PRIMARY KEY (id),
	CONSTRAINT car_class_un UNIQUE ("name")
);