CREATE TABLE games.games_platform (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	id_games int NOT NULL,
	id_platform int NOT NULL,
	CONSTRAINT platform_pk PRIMARY KEY (id),
);