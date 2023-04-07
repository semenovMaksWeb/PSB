CREATE TABLE tec.right_roles (
	id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	id_right int4 NOT NULL,
	id_roles int4 NOT NULL,
	CONSTRAINT right_roles_pk PRIMARY KEY (id),
	CONSTRAINT right_roles_fk FOREIGN KEY (id_right) REFERENCES tec."right"(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT right_roles_fk_1 FOREIGN KEY (id_roles) REFERENCES tec.roles(id) ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON TABLE tec.right_roles IS 'Таблица связь М/М права и роли';

COMMENT ON COLUMN tec.right_roles.id IS 'Первичный ключ';
COMMENT ON COLUMN tec.right_roles.id_right IS 'Внешний ключ право';
COMMENT ON COLUMN tec.right_roles.id_roles IS 'Внешний ключ роли';