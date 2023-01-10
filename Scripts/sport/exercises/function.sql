DROP FUNCTION sport.exercises_insert;
DROP FUNCTION sport.exercises_get;
DROP FUNCTION sport.exercises_delete;

/**
 * Просмотр упражнений пользователя
 * @params id пользователя
 * @return SETOF sport.exercises
 */
CREATE OR REPLACE FUNCTION sport.exercises_get(
 	_id_user integer
)
RETURNS SETOF sport.exercises
LANGUAGE plpgsql
AS $function$
	BEGIN
		return query select * from sport.exercises e where id_user  = _id_user;
		PERFORM tec.log_insert(_id_user, 'Пользователь решил посмотреть свои упраженения');
	END;
$function$;

/**
 * Создание упражнения для конкретного пользователя
 * @params id пользователя
 * @params имя упражнения
 * @return id упражнения
 * @return public.get_result json
 */
CREATE OR REPLACE FUNCTION sport.exercises_insert(
 	_id_user integer,
 	_name varchar, 
 	OUT id_ integer,
 	OUT result_type_ json
)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
	begin
		insert into sport.exercises (id_user, "name") 
		values (_id_user, _name) 
		RETURNING id into id_;
		SELECT * into result_type_ FROM public.get_result(1, null);
		PERFORM tec.log_insert(_id_user, 'Пользователь успешно создал упражнения id - ' || id_);
	END;
$function$;

/**
 * Удаляет упражнения для конкретного пользователя
 * @params id пользователя
 * @params id упражнения
 * @return public.get_result json
 */
CREATE OR REPLACE FUNCTION sport.exercises_delete(
 	_id_user integer,
 	_id_exercises integer, 
 	OUT result_type_ json
)
 LANGUAGE plpgsql
AS $function$
	begin
		delete from sport.exercises e where e.id = _id_exercises and e.id_user = _id_user;
		SELECT * into result_type_ FROM public.get_result(1, null);
		PERFORM tec.log_insert(_id_user, 'Пользователь успешно удалил упражнения id - ' || _id_exercises);
	END;
$function$;

--select * from sport.exercises_delete(25, 4);
--select * from sport.exercises_get(25);
--select * from sport.exercises_insert(25, 'Жим лежа')
