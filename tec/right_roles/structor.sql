CREATE TABLE tec.right_roles (
	id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	id_right int4 NOT NULL,
	id_roles int4 NOT NULL,
	CONSTRAINT right_roles_pk PRIMARY KEY (id),
	CONSTRAINT right_roles_fk FOREIGN KEY (id_right) REFERENCES tec."right"(id),
	CONSTRAINT right_roles_fk_1 FOREIGN KEY (id_roles) REFERENCES tec.roles(id)
);