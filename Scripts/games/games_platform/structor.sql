CREATE TABLE games.games_platform (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	id_games int NOT NULL,
	id_platform int NOT NULL,
	CONSTRAINT games_platform_pk PRIMARY KEY (id),
	CONSTRAINT games_platform_fk1 FOREIGN KEY (id_games) REFERENCES games."games"(id),
	CONSTRAINT games_platform_fk2 FOREIGN KEY (id_platform) REFERENCES games."platform"(id)
);