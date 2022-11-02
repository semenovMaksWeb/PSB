CREATE TABLE public."token" (
	id int NOT NULL GENERATED ALWAYS AS IDENTITY,
	value text NULL,
	"date" date NOT NULL DEFAULT CURRENT_TIMESTAMP,
	active boolean NOT NULL DEFAULT true,
	date_end date NOT NULL DEFAULT CURRENT_TIMESTAMP +'1 day',
	id_user int NOT NULL,
	CONSTRAINT token_pk PRIMARY KEY (id),
	CONSTRAINT token_fk FOREIGN KEY (id_user) REFERENCES public."user"(id)
);
CREATE UNIQUE INDEX token_value_idx ON public."token" (value);
