CREATE TABLE "config"."bec" (
  "id" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL,
  "name" varchar UNIQUE NOT NULL,
  "api" boolean NOT NULL DEFAULT true,
  "config" json NOT NULL,
  "group" varchar
);
