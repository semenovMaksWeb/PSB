CREATE OR REPLACE FUNCTION sport.exercises_get(
 	_id_user integer
)
RETURNS  SETOF sport.exercises
LANGUAGE plpgsql
AS $function$
	BEGIN
		return query select * from sport.exercises e where id_user  = _id_user;
		PERFORM tec.log_insert(_id_user, 'Пользователь решил посмотреть свои упраженения');
	END;
$function$;