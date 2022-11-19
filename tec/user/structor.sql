CREATE TABLE tec."user" (
	id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	nik varchar NOT NULL,
	email varchar NOT NULL,
	"password" text NOT NULL,
	active bool NOT NULL DEFAULT false,
	"name" varchar NOT NULL,
	patronymic varchar NOT NULL,
    surname varchar NOT NULL,
	"date" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT id_user PRIMARY KEY (id)
);