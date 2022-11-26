CREATE TABLE tec.roles_user (
	id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	id_user int4 NOT NULL,
	id_roles int4 NOT NULL,
	CONSTRAINT roles_user_pk PRIMARY KEY (id),
	CONSTRAINT roles_user_fk FOREIGN KEY (id_user) REFERENCES tec."user"(id),
	CONSTRAINT roles_user_fk_1 FOREIGN KEY (id_roles) REFERENCES tec.roles(id)
);