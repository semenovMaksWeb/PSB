/* drop function */
DROP FUNCTION tec.user_insert;
DROP FUNCTION tec.user_get_id;
/* drop function */

CREATE OR REPLACE FUNCTION tec.user_insert(
	_nik varchar,
	_email varchar,
	_password text,
	_surname varchar,
	_name varchar,
	_patronymic varchar,
	out id_ int
)
	RETURNS int4
	LANGUAGE plpgsql
AS $function$
	BEGIN
        INSERT INTO tec."user" 
		(nik, email, "password", surname, "name", patronymic ) 
		VALUES (_nik, _email, _password, _surname, _name, _patronymic ) 
	 	RETURNING id into id_;

        PERFORM tec.log_insert(id_, 'Пользователь создан');
	END;
$function$;

CREATE OR REPLACE FUNCTION tec.user_get_id(_id_user int4)
	RETURNS TABLE(
		id int, 
		nik varchar,
		email varchar, 
		active boolean, 
		surname varchar,
		"name" varchar, 
		patronymic varchar  

		)
	LANGUAGE plpgsql
AS $function$
	BEGIN
        return query select 
			u.id as id,
			u.nik  as nik, 
			u.email as email, 
			u.active as active, 
			u.surname as surname,
			u."name" as name, 
			u.patronymic as patronymic
		from tec."user" u 
		where u.id = _id_user;
	END;
$function$;




/* start function */
select * from tec.user_insert('semenov', 'semenov@mail.ru', '1234', 'Семенов', 'Максим', 'Александрович');
select * from tec.user_get_id(1); 
/* start function */