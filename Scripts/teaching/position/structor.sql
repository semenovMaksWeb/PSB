CREATE TABLE "teaching"."position" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" varchar UNIQUE NOT NULL
);
