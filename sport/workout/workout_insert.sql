/* drop function */
drop function sport.workout_insert;
/* drop function */

 CREATE OR REPLACE FUNCTION sport.workout_insert(
	_id_user integer, 
	_ids_exercises int4[] DEFAULT array[]::integer[],
	_weight int4[] DEFAULT array[]::integer[], 
	_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
	OUT id_ integer, 
	OUT result_type_ result_type
 )
 RETURNS record
 LANGUAGE plpgsql
AS $function$
	BEGIN
		select * into result_type_  from tec.user_check(_id_user);
		if result_type_.status_ <> 0 then 
			insert into sport.workout (id_user, "date") values (_id_user, _date) RETURNING id into id_;
			select 1 as status_, null as error_ into result_type_ ;
			insert into sport.workout_exercises (id_workourt, id_exercises, weight) 
				values (id_, unnest(_ids_exercises), unnest(_weight));
			PERFORM tec.log_insert(_id_user, 'Пользователь успешно создал тренировку id - ' || id_);
		end if;
	END;
$function$;


/* start function */
select * from sport.workout_insert(1, '2022-11-03 18:00:00');
/* start function */