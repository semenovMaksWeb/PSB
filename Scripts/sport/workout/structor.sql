CREATE TABLE sport.workout (
	"id" int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	"id_user" integer NOT NULL,
	"date" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT "workout_pk" PRIMARY KEY ("id"),
   	CONSTRAINT workout_fk FOREIGN KEY (id_user) REFERENCES tec."user"(id)
);