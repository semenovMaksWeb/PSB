/* drop function */
drop function sport.workout_get_id;
drop function sport.workout_check;
/* drop function */

CREATE OR REPLACE FUNCTION sport.workout_get_id(_id integer)
 RETURNS SETOF sport.workout
 LANGUAGE plpgsql
AS $function$
	BEGIN
		return query select * from sport.workout w where id  = _id;
	END;
$function$;

CREATE OR REPLACE FUNCTION sport.workout_check(
	_id integer, 
	_id_user integer, 
	out result_type_ result_type
	)
 RETURNS result_type
 LANGUAGE plpgsql
AS $function$
	declare
		workout_ sport.workout;
	BEGIN
		select 1 as status_, null as error_ into result_type_;
		select * into result_type_  from tec.user_check(_id_user);
		if	result_type_.status_ <> 0 then
		select * into workout_ from sport.workout_get_id(_id);
			if workout_.id is null then
				PERFORM tec.log_insert(_id_user, 'Пользователь обратился к тренировке которой не существует id - ' || _id);
				select 0 as status_, 'Тренировка не существует' as error_ into result_type_ ;
			ELSIF workout_.id_user <> _id_user then
				PERFORM tec.log_insert(_id_user, 'Пользователь обратился к чужой тренировке, к которой не имеет доступ id - ' || _id);
				select 0 as status_, 'Тренировка не доступна' as error_ into result_type_ ;
			END IF;	
		end if;	
	END;
$function$;




/* start function */
select * from sport.workout_get_id(1);
/* start function */