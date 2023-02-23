DROP FUNCTION tec.user_update_confirmed;

/*
 * подверждения почты пользователем
 * @params id_user
 * @return id пользователя
 * @bec true
 **/
CREATE OR REPLACE FUNCTION tec.user_update_confirmed(_id_user int4, out result_type_ json)
	RETURNS json
	LANGUAGE plpgsql
AS $function$
	declare
		user_ tec.user;
	BEGIN
		select * into result_type_ from public.get_result(1, null);
       	select * into user_ from tec.user u where u.id = _id_user;
		
		if user_.id is null then
			select * into result_type_ from public.get_result(0, 'Пользователя не существует');
    	end if;

		if user_.confirmed = true then
		select * into result_type_ from public.get_result(0, 'Активация не требуется');
    	end if;

	   	if result_type_.status_ <> 0 then 
	   	    update tec."user" set confirmed = true where id = _id_user;
			select 1 as status_, null as error_ into result_type_ ;
    		PERFORM tec.log_insert(_id_user, 'Пользователь успешно активирован');
		end if;
	END;
$function$;

--select * from tec.user_update_confirmed(1); 