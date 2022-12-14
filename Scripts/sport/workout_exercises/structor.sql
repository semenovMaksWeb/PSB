CREATE TABLE sport.workout_exercises (
	"id" int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	"id_workourt" int4 NOT NULL,
	"id_exercises" int4 NOT NULL,
	"weight" int4 NULL,
	CONSTRAINT "workout_exercises_pk" PRIMARY KEY ("id"),
	CONSTRAINT workout_exercises_fk1 FOREIGN KEY (id_workourt) REFERENCES sport."workout"(id),
	CONSTRAINT workout_exercises_fk2 FOREIGN KEY (id_exercises) REFERENCES sport."exercises"(id)
);