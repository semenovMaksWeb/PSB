CREATE TABLE public.exercises (
	"id" int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	"name" varchar(255) NOT NULL,
	"id_user" int4 NOT NULL,
	CONSTRAINT "exercises_pk" PRIMARY KEY ("id"),
	CONSTRAINT exercises_fk FOREIGN KEY (id_user) REFERENCES public."user"(id)
) 
