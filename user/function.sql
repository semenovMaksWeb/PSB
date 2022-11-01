
/* drop function */
DROP FUNCTION public.user_insert;
DROP FUNCTION user_get_id;
DROP FUNCTION user_check_active;
/* drop function */

CREATE OR REPLACE FUNCTION public.user_insert(
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
        INSERT INTO public."user" 
		(nik, email, "password", surname, "name", patronymic ) 
		VALUES (_nik, _email, _password, _surname, _name, _patronymic ) 
	 	RETURNING id into id_;

        PERFORM public.log_insert(id_, 'Пользователь создан');
	END;
$function$;

CREATE OR REPLACE FUNCTION public.user_get_id(_id_user int4)
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
		from public."user" u 
		where u.id = _id_user;
	END;
$function$;




CREATE OR REPLACE FUNCTION public.user_check_active(_id_user int4, out status_ boolean, out error_ text)
	RETURNS record
	LANGUAGE plpgsql
AS $function$
	declare
		user_ public.user_check_active;
	BEGIN
       select u.id, u.active into user_  from "user" u where u.id  = _id_user;
       if user_.id is null then
			status_ = false;
       		select 'Пользователь не существует' into error_;
       		PERFORM public.log_insert(null, 'Был передан не корректный id - ' || _id_user || ' пользователя');
    	end if;
    	if user_.active = true then
			status_ = false;
       		select 'Пользователь уже активен для использования' into error_;
       		PERFORM public.log_insert(_id_user, 'Пользователь пытался повторно подвердить активацию аккаунта');
    	end if;
    	if error_ is null then
    		update public."user" set active = true;
			status_ = true;
    		PERFORM public.log_insert(_id_user, 'Пользователь успешно активирован');
    	end if;
	END;
$function$;


/* start function */
select * from public.user_insert('semenov', 'semenov@mail.ru', '1234', 'Семенов', 'Максим', 'Александрович');
select * from public.user_get_id(1); 
/* start function */