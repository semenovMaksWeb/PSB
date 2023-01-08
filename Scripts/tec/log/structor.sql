CREATE TABLE tec.log (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	id_user int NULL,
	"text" text NULL,
	"date" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT id_log PRIMARY KEY (id)
);