CREATE TABLE games.genres (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	"name" varchar NOT NULL,
	date date NOT NULL,
	description varchar NULL,
	CONSTRAINT genres_pk PRIMARY KEY (id),
	CONSTRAINT genres_name_un UNIQUE ("name")
);