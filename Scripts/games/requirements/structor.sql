CREATE TABLE games.requirements (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	id_oc int NOT NULL,
	id_games int NOT NULL,
	recommended boolean NOT NULL,
	processor varchar NOT NULL,
	video_cart varchar NOT NULL,
	ram int NOT NULL,
	CONSTRAINT requirements_pk PRIMARY KEY (id),
	CONSTRAINT requirements_fk1 FOREIGN KEY (id_oc) REFERENCES libs."oc"(id),
	CONSTRAINT requirements_fk2 FOREIGN KEY (id_games) REFERENCES games."games"(id)
);