CREATE TABLE games.platform (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	"name" varchar NOT NULL,
	description varchar NULL,
	CONSTRAINT platform_pk PRIMARY KEY (id),
	CONSTRAINT platform_un UNIQUE ("name")
);