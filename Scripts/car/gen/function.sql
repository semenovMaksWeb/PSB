drop function car.gen_get;
drop function car.gen_check_unique;
drop function car.gen_insert;

/*
 * показать модели автомобилей
 * @return table car_class
 */
CREATE OR REPLACE FUNCTION car.gen_get()
RETURNS setof car.gen
LANGUAGE plpgsql
AS $function$
	begin
		return query SELECT * FROM car.gen g;
    END;
$function$;

/*
 * проверка уникальности
 * @return boolean
 */
CREATE OR REPLACE FUNCTION car.gen_check_unique(_name varchar, out check_ boolean)
LANGUAGE plpgsql
AS $function$
	begin
		SELECT EXISTS(select id from car.gen g where m."name" = _name) into check_;
    END;
$function$;

/*
 * проверка существования поколения по id
 * @return boolean
 */
CREATE OR REPLACE FUNCTION car.gen_check_id(_id varchar, out check_ boolean)
LANGUAGE plpgsql
AS $function$
	begin
		SELECT EXISTS(select id from car.gen g where s.id = _id) into check_;
    END;
$function$;

/*
 * создать модель автомобиля
 * @return json get_result
 */
CREATE OR REPLACE FUNCTION car.gen_insert(
	_name varchar, 
	_id_model int,
	_date_start date,
	_date_end date,
	_description varchar = null,
	out result_ json
)
returns json
LANGUAGE plpgsql
AS $function$
	begin
		select * into result_ from public.get_result(1, null);
		if (select * from car.gen_check_unique(_name)) = true then
			select * into result_ from public.get_result(0, 'Указанное имя поколения автомобиля уже существует');
			return;
		end if;
		if (select * from libs.model_check_id(_id_model)) = false then
			select * into result_ from public.get_result(0, 'Указанный id модели автомобиля не найден');
			return;
		end if;
 		insert into car.gen ("name", "id_stamp", "description", "date_start", "date_end")
 		values (_name,_id_stamp, _description, _date_start, _date_end);
    END;
$function$;

--select * from car.gen_insert('lada', 'lada.png', '1966-01-01', 1);
--select * from car.gen_get();