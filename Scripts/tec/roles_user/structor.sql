CREATE TABLE tec.roles_user (
	id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	id_user int4 NOT NULL,
	id_roles int4 NOT NULL,
	CONSTRAINT roles_user_pk PRIMARY KEY (id),
	CONSTRAINT roles_user_fk FOREIGN KEY (id_user) REFERENCES tec."user"(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT roles_user_fk_1 FOREIGN KEY (id_roles) REFERENCES tec.roles(id) ON DELETE CASCADE ON UPDATE CASCADE
);

COMMENT ON TABLE tec.roles_user IS 'Таблица связь М/М  роли и пользователи';

COMMENT ON COLUMN tec.roles_user.id IS 'Первичный ключ';
COMMENT ON COLUMN tec.roles_user.id_user IS 'Внешний ключ пользователя';
COMMENT ON COLUMN tec.roles_user.id_roles IS 'Внешний ключ роли';