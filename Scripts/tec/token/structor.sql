CREATE TABLE tec."token" (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	value text NULL,
	"date" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	active boolean NOT NULL DEFAULT true,
	date_end timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP + '1 day',
	id_user int NOT NULL,
	CONSTRAINT token_pk PRIMARY KEY (id),
	CONSTRAINT token_fk FOREIGN KEY (id_user) REFERENCES tec."user"(id)  ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE UNIQUE INDEX token_value_idx ON tec."token" (value);

COMMENT ON TABLE tec."token" IS 'Таблица для  токенов пользователей';

COMMENT ON COLUMN tec."token".id IS 'Первичный ключ';
COMMENT ON COLUMN tec."token".value IS 'Значение токена';
COMMENT ON COLUMN tec."token"."date" IS 'Время создание токена';
COMMENT ON COLUMN tec."token".active IS 'Активность токена';
COMMENT ON COLUMN tec."token".date_end IS 'Время жизни токена';
COMMENT ON COLUMN tec."token".id_user IS 'Внешний ключ пользователя';
