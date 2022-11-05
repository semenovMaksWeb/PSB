 CREATE OR REPLACE FUNCTION public.workout_exercises_update(
	_id_user int4,
	_id_workourt int4,
	_ids_exercises int4[],
	_weight int4[],
	out result_type_ result_type
	
)
 RETURNS result_type
 LANGUAGE plpgsql
AS $function$
	begin
		select * into result_type_ from public.workout_check(_id_workourt,_id_user);
		if result_type_.status_ <> 0 then
			insert into public.workout_exercises (id_workourt, id_exercises, weight) 
			values (_id_workourt, unnest(_ids_exercises), unnest(_weight));
            PERFORM public.log_insert(_id_user, 'Пользователь успешно изменил тренировку id - ' || id_);
		end if;
	END;
$function$;