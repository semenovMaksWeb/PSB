/* drop function */
DROP FUNCTION user_get_active;
/* drop function */

create type public."user_check_active" AS (
	id int4,
	active bool
)

CREATE OR REPLACE FUNCTION public.user_get_active(_id_user int4, out user_ user_check_active)
	RETURNS user_check_active
	LANGUAGE plpgsql
AS $function$
	BEGIN
       select u.id, u.active into user_  from "user" u where u.id  = _id_user;
	END;
$function$;

CREATE OR REPLACE FUNCTION public.user_check_id(_user user_check_active, out result_type_ result_type)
	RETURNS result_type
	LANGUAGE plpgsql
AS $function$
	BEGIN
        select 1 as status_, null as error_ into result_type_;
        if _user.id is null then
           PERFORM public.log_insert(null, 'Был передан не корректный id - ' || _user.id || ' пользователя');
           select 0 as status_, 'Пользователь не существует' as error_ into result_type_ ;
        end if;
	END;
$function$;

/* start function */
select * from public.user_get_active(1); 
/* start function */
