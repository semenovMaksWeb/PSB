CREATE TABLE tec."user" (
	id int4 NOT NULL GENERATED ALWAYS AS IDENTITY, -- первичный ключ
	nik varchar NOT NULL, -- уникальное имя пользователя
	email varchar NOT NULL, -- почта пользователя
	"password" text NOT NULL, -- пароль пользователя
	active bool NOT NULL DEFAULT true, -- проверка на возможность работать пользователю
	confirmed bool NOT NULL DEFAULT false, -- подвержденность пользователя
	"name" varchar NOT NULL, -- имя пользователя
	patronymic varchar NOT NULL, -- отчество пользователя
	surname varchar NOT NULL, -- фамилия пользователя
	"date" timestamp NULL DEFAULT CURRENT_TIMESTAMP, -- дата создания пользователя
	CONSTRAINT id_user PRIMARY KEY (id)
);

CREATE UNIQUE INDEX user_nik_idx ON tec."user" USING btree (nik);
CREATE UNIQUE INDEX user_email_idx ON tec."user" (email);

COMMENT ON COLUMN tec."user".id IS 'Первичный ключ';
COMMENT ON COLUMN tec."user".nik IS 'Уникальное имя пользователя';
COMMENT ON COLUMN tec."user".email IS 'Почта пользователя';
COMMENT ON COLUMN tec."user"."password" IS 'Пароль пользователя';
COMMENT ON COLUMN tec."user".active IS 'Проверка на возможность работать пользователю';
COMMENT ON COLUMN tec."user"."name" IS 'Подвержденность пользователя';
COMMENT ON COLUMN tec."user".patronymic IS 'Имя пользователя';
COMMENT ON COLUMN tec."user".surname IS 'Отчество пользователя';
COMMENT ON COLUMN tec."user"."date" IS 'Фамилия пользователя';
COMMENT ON COLUMN tec."user".confirmed IS 'Дата создания пользователя';


COMMENT ON TABLE tec."user" IS 'Таблица для  пользователей';
