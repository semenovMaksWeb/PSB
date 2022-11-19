CREATE TABLE tec."right" (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	"name" varchar NULL,
	const_name varchar NULL,
	description varchar NULL,
	active boolean NOT NULL DEFAULT true,
	"date" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT right_pk PRIMARY KEY (id)
);
CREATE UNIQUE INDEX right_const_name_idx ON tec."right" (const_name);
