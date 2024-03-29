CREATE TABLE "config"."procedures" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" varchar NOT NULL,
  "connect" varchar NOT NULL,
  "id_right" int NULL,
  "result_array" boolean DEFAULT true,
  "call" varchar NOT NULL,
  	CONSTRAINT procedures_right_fk1 FOREIGN KEY (id_right) REFERENCES tec."right"(id)
);

CREATE UNIQUE INDEX procedures_name_idx ON config."procedures" ("name");

COMMENT ON TABLE "config"."procedures" IS 'Таблица для вызова хранимых процедур в бд';

COMMENT ON COLUMN config.procedures.id IS 'Первичный ключ';
COMMENT ON COLUMN config.procedures."name" IS 'Имя хранимой процедуры';
COMMENT ON COLUMN config.procedures."connect" IS 'Имя соединения к бд';
COMMENT ON COLUMN config.procedures."call" IS 'Sql код вызова хранимой процедуры';
COMMENT ON COLUMN config.procedures."result_array" IS 'Возвращается ли массив или объект';
COMMENT ON COLUMN config.procedures.id_right IS 'Внешний ключ право необходимое для вызова процедуры';
