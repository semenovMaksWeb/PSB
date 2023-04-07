CREATE TABLE tec.roles (
	id int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	"name" varchar NOT NULL,
	description text NULL,
	active bool NOT NULL DEFAULT true,
	const_name varchar NOT NULL,
	CONSTRAINT roles_pk PRIMARY KEY (id)
);

CREATE UNIQUE INDEX roles_const_name_idx ON tec."roles" (const_name);

COMMENT ON TABLE tec.roles IS 'Таблица для ролей';

COMMENT ON COLUMN tec.roles.id IS 'Первичный ключ';
COMMENT ON COLUMN tec.roles."name" IS 'Имя роли';
COMMENT ON COLUMN tec.roles.description IS 'Описание роли';
COMMENT ON COLUMN tec.roles.active IS 'Активность роли';
COMMENT ON COLUMN tec.roles.const_name IS 'Констант значения роли';
