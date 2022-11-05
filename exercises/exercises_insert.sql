 CREATE OR REPLACE FUNCTION public.exercises_insert(
 	_id_user integer,
 	_name varchar, 
 	OUT id_ integer,
 	OUT result_type_ result_type
)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
	BEGIN
		select * into result_type_  from user_check(_id_user);
		if result_type_.status_ <> 0 then 
			insert into exercises (id_user, "name") values (_id_user, _name) RETURNING id into id_;
			select 1 as status_, null as error_ into result_type_ ;
			PERFORM public.log_insert(_id_user, 'Пользователь успешно создал упражнения id - ' || id_);
		end if;
	END;
$function$;