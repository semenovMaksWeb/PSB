/* drop function */
DROP FUNCTION tec.user_update_confirmed;
/* drop function */

CREATE OR REPLACE FUNCTION tec.user_update_confirmed(_id_user int4, out result_type_ result_type)
	RETURNS result_type
	LANGUAGE plpgsql
AS $function$
	declare
		user_ tec.user;
	BEGIN
		select 1 as status_, '' as error_ into result_type_ ;
       	select * into user_ from tec.user u where u.id = _id_user;
		
		if user_.id is null then
			select 0 as status_, 'Пользователя не существует' as error_ into result_type_ ;
    	end if;

		if user_.confirmed = true then
			select 0 as status_, 'Активация не требуется' as error_ into result_type_ ;
    	end if;

	   	if result_type_.status_ <> 0 then 
	   	    update tec."user" set confirmed = true;
			select 1 as status_, null as error_ into result_type_ ;
    		PERFORM tec.log_insert(_id_user, 'Пользователь успешно активирован');
		end if;
	END;
$function$;

/* start function */
select * from tec.user_update_confirmed(1); 
/* start function */