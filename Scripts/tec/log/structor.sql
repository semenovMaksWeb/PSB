CREATE TABLE tec.log (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	id_user int NULL,
	"text" text NULL,
	"date" timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT id_log PRIMARY KEY (id)
);

COMMENT ON TABLE tec.log IS 'Таблица для логов';

COMMENT ON COLUMN tec.log.id IS 'Первичный ключ';
COMMENT ON COLUMN tec.log.id_user IS 'Внешний ключ пользователя';
COMMENT ON COLUMN tec.log."text" IS 'Текст консоли';
COMMENT ON COLUMN tec.log."date" IS 'Дата создания записи';
