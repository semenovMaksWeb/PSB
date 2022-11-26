CREATE TABLE tec.roles (
	id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	"name" varchar NOT NULL,
	description text NULL,
	active bool NOT NULL DEFAULT true,
	CONSTRAINT roles_pk PRIMARY KEY (id)
);
CREATE UNIQUE INDEX roles_name_idx ON tec.roles USING btree (name);