/* drop function */
DROP FUNCTION tec.user_get_active;
DROP FUNCTION tec.user_check;
DROP FUNCTION tec.user_check_active;
DROP FUNCTION tec.user_check_id;
/* drop function */

create type tec."user_check_active" AS (
	id int4,
	active bool
)


CREATE OR REPLACE FUNCTION tec.user_get_active(_id_user int4, out user_ user_check_active)
	RETURNS user_check_active
	LANGUAGE plpgsql
AS $function$
	BEGIN
       select u.id, u.active into user_  from "user" u where u.id  = _id_user;
	END;
$function$;


CREATE OR REPLACE FUNCTION tec.user_check(_id_user int4, out result_type_ result_type)
	RETURNS result_type
	LANGUAGE plpgsql
AS $function$
	declare
		user_ user_check_active;
	BEGIN
    	select * into user_ from user_get_active(_id_user);
		select * into result_type_ from tec.user_check_id(user_);
		if result_type_.status_ <> 0 then
			select * into result_type_ from tec.user_check_active(user_);
		end if;
	END;
$function$;


CREATE OR REPLACE FUNCTION tec.user_check_active(_user user_check_active, out result_type_ result_type)
	RETURNS result_type
	LANGUAGE plpgsql
AS $function$
	BEGIN
        select 1 as status_, null as error_ into result_type_;
        if _user.active = false then
           PERFORM tec.log_insert(_user.id, 'Пользователь не активен');
           select 0 as status_, 'Пользователь не активен' as error_ into result_type_ ;
        end if;
	END;
$function$;


CREATE OR REPLACE FUNCTION tec.user_check_id(_user user_check_active, out result_type_ result_type)
	RETURNS result_type
	LANGUAGE plpgsql
AS $function$
	BEGIN
        select 1 as status_, null as error_ into result_type_;
        if _user.id is null then
           PERFORM tec.log_insert(null, 'Был передан не корректный id - ' || _user.id || ' пользователя');
           select 0 as status_, 'Пользователь не существует' as error_ into result_type_ ;
        end if;
	END;
$function$;

/** Обрабатывается в конфиге */
CREATE OR REPLACE FUNCTION tec.user_check_unique(_nik character varying, _email character varying)
 RETURNS TABLE(status integer, nik text[], email text[])
 LANGUAGE plpgsql
AS $function$
	declare
		nik_ varchar;
		email_ varchar;
	BEGIN
    	select u.nik into nik_ from tec."user" u where u.nik = _nik;
		select u.email  into email_ from tec."user" u where u.email = _email;
		if nik_ is NOT NULL and email_ is NOT NULL then
			return query select 0 as status, array['Текущий ник пользователя занят'] as nik, array['Текущий email пользователя занят'] as email;
		elseif nik_ is NOT NULL then
			return query  select 0 as status, array['Текущий ник пользователя занят'] as nik, array[]::text[] as email;
		elseif email_ is NOT NULL then
			return query select 0 as status, array[]::text[] as nik, array['Текущий email пользователя занят'] as email;
		else
			return query select 1 as status, array[]::text[]  as nik, array[]::text[] as email;
		end if;
	END;
$function$
;



/* start function */
select * from tec.user_get_active(1); 
select * from tec.user_check(1);
/* start function */
