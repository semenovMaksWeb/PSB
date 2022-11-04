/* drop function */
DROP FUNCTION user_update_active;
/* drop function */

CREATE OR REPLACE FUNCTION public.user_update_active(_id_user int4, out result_type_ result_type)
	RETURNS result_type
	LANGUAGE plpgsql
AS $function$
	declare
		user_ user_check_active;
	BEGIN
       select * into user_  from public.user_get_active(_id_user);
	   select * into result_type_ from public.user_check_id(user_);
		if user_.active = true then
			select 0 as status_, 'Пользователь уже активен для использования' as error_ into result_type_ ;
       		PERFORM public.log_insert(_id_user, 'Пользователь пытался повторно подвердить активацию аккаунта');
    	end if;
	   if result_type_.status_ <> 0 then 
	   	    update public."user" set active = true;
			select 1 as status_, null as error_ into result_type_ ;
    		PERFORM public.log_insert(_id_user, 'Пользователь успешно активирован');
		end if;
	END;
$function$;

/* start function */
select * from public.user_update_active(1); 
/* start function */