DROP FUNCTION sport.workout_exercises_update

/**
 * изменить тренировки
 * @params id пользователя
 * @params массив упражнении
 * @params массив веса
 * @params дата тренировки
 * @return json
 */
 CREATE OR REPLACE FUNCTION sport.workout_exercises_update(
	_id_user int4,
	_id_workourt int4,
	_ids_exercises int4[],
	_weight int4[],
	result_type_ json
)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
	begin
	DELETE from sport.workout_exercises we where we.id_workourt = _id_workourt;
	insert into sport.workout_exercises (id_workourt, id_exercises, weight) 
		values (_id_workourt, unnest(_ids_exercises), unnest(_weight));
	PERFORM tec.log_insert(_id_user, 'Пользователь успешно изменил тренировку id - ' || _id_workourt);
	select * into result_type_ FROM public.get_result(1, null);
	END;
$function$;

/**
 * просмотр тренировки
 * @params  id пользователя
 * @params id тренировки
 * @return table упражнения тренировки
 */
 CREATE OR REPLACE FUNCTION sport.workout_get_exercises(
	_id_user int4,
	_id_workourt int4
)
 RETURNS table (id int4, weight int4, id_exercises int4, name varchar)
 LANGUAGE plpgsql
AS $function$
	begin
		return query select we.id, we.weight, we.id_exercises, e."name" from sport.workout_exercises we 
		left join sport.exercises e on we.id_exercises = e.id
		left join sport.workout w on w.id = we.id_workourt
		where w.id_user = _id_user and we.id_workourt = _id_workourt;
	END;
$function$;


--select * from sport.workout_get_exercises(25, 4);
--select * from sport.workout_exercises_update(25, 4, array[3,5], array[100, 50])
