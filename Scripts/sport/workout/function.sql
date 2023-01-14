drop function sport.workout_insert;
 
/**
 * Создание тренировки
 * @params id пользователя
 * @params массив упражнении
 * @params массив веса
 * @params дата тренировки
 * @return id созданой записи
 */
 CREATE OR REPLACE FUNCTION sport.workout_insert(
	_id_user integer, 
	_ids_exercises int4[] DEFAULT array[]::integer[],
	_weight int4[] DEFAULT array[]::integer[], 
	_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
	OUT id_ integer
 )
 LANGUAGE plpgsql
AS $function$
	BEGIN
		insert into sport.workout (id_user, "date") values (_id_user, _date) RETURNING id into id_;
		insert into sport.workout_exercises (id_workourt, id_exercises, weight) 
		values (id_, unnest(_ids_exercises), unnest(_weight));
		PERFORM tec.log_insert(_id_user, 'Пользователь успешно создал тренировку id - ' || id_);
	END;
$function$;

/**
 * просмотр тренировки по user_id
 * @params table sport.workout
 */
CREATE OR REPLACE FUNCTION sport.workout_get_id(_id_user integer)
 RETURNS SETOF sport.workout
 LANGUAGE plpgsql
AS $function$
	BEGIN
		return query select * from sport.workout w where w.id_user = _id_user;
	END;
$function$;

--select * from sport.workout w where w.id_user = 25
--select * from  sport.workout_insert(25, array[3,5], array[10, 35]);
