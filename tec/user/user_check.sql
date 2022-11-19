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

/* start function */
select * from tec.user_get_active(1); 
select * from tec.user_check(1);
/* start function */
