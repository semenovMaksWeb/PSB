CREATE TABLE car.car (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	"name" varchar NOT NULL,
	"date" Date NOT null,
	description varchar NULL,
	id_car_class int not null,
	id_stamp int not null,
	id_model int not null,
	id_gen int not null,
	CONSTRAINT car_pk PRIMARY KEY (id),
	CONSTRAINT car_class_fk FOREIGN KEY (id_car_class) REFERENCES car.car_class(id),
	CONSTRAINT car_stamp_fk FOREIGN KEY (id_stamp) REFERENCES car.stamp(id),
	CONSTRAINT car_model_fk FOREIGN KEY (id_model) REFERENCES car.model(id),
	CONSTRAINT car_gen_fk FOREIGN KEY (id_gen) REFERENCES car.gen(id)
);