drop function car.model_get;
drop function car.model_check_unique;
drop function car.model_insert;

/*
 * показать модели автомобилей
 * @return table car_class
 */
CREATE OR REPLACE FUNCTION car.model_get()
RETURNS setof car.model
LANGUAGE plpgsql
AS $function$
	begin
		return query SELECT * FROM car.model m
    END;
$function$;

/*
 * проверка уникальности
 * @return boolean
 */
CREATE OR REPLACE FUNCTION car.model_check_unique(_name varchar, out check_ boolean)
LANGUAGE plpgsql
AS $function$
	begin
		SELECT EXISTS(select id from car.model m where m."name" = _name) into check_;
    END;
$function$;

/*
 * проверка существования модели по id
 * @return boolean
 */
CREATE OR REPLACE FUNCTION car.model_check_id(_id varchar, out check_ boolean)
LANGUAGE plpgsql
AS $function$
	begin
		SELECT EXISTS(select id from car.model s where s.id = _id) into check_;
    END;
$function$;

/*
 * создать модель автомобиля
 * @return json get_result
 */
CREATE OR REPLACE FUNCTION car.model_insert(
	_name varchar, 
	_id_stamp int,
	_description varchar = null,
	out result_ json
)
returns json
LANGUAGE plpgsql
AS $function$
	begin
		select * into result_ from public.get_result(1, null);
		if (select * from car.model_check_unique(_name)) = true then
			select * into result_ from public.get_result(0, 'Указанное имя модели автомобиля уже существует');
			return;
		end if;
		if (select * from libs.stamp_check_id(_id_stamp)) = false then
			select * into result_ from public.get_result(0, 'Указанный id марки автомобиля не найден');
			return;
		end if;
 		insert into car.model ("name", "id_stamp", "description")
 		values (_name,_id_stamp, _description);
    END;
$function$;

--select * from car.model_insert('lada', 'lada.png', '1966-01-01', 1);
--select * from car.model_get();