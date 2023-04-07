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

COMMENT ON TABLE tec."right" IS 'Таблица для прав';

COMMENT ON COLUMN tec."right".id IS 'Первичный ключ';
COMMENT ON COLUMN tec."right"."name" IS 'Имя право';
COMMENT ON COLUMN tec."right".const_name IS 'Констант значения право';
COMMENT ON COLUMN tec."right".description IS 'Описание право';
COMMENT ON COLUMN tec."right".active IS 'Активность право';
COMMENT ON COLUMN tec."right"."date" IS 'Дата создания право';
