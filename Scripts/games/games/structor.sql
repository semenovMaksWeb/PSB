CREATE TABLE games.games (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	"name" varchar NOT NULL,
	date date NOT NULL,
	description varchar NULL,
	img varchar NOT NULL,
	CONSTRAINT games_pk PRIMARY KEY (id),
	CONSTRAINT games_name_un UNIQUE ("name")
);