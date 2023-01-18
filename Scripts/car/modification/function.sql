drop function car.modification_get
/*
 * показать модификации автомобиля
 * @return table modification
 */
CREATE OR REPLACE FUNCTION car.modification_get(_id_car int)
RETURNS table (id int, id_country int, id_car int, "name" varchar, "date" date, description varchar, country_name varchar)
LANGUAGE plpgsql
AS $function$
	begin
		return query select m.*, c."name" as country_name from  car.modification m
		left join libs.country c on c.id = m.id_country
		where m.id_car = _id_car; 
    END;
$function$;

/*
 * Проверить существования модификации автомобиля по id
 * @return boolean
 */
CREATE OR REPLACE FUNCTION car.modification_check_id(_id int, out check_ boolean)
LANGUAGE plpgsql
AS $function$
	begin
		SELECT EXISTS(SELECT * FROM car.modification c where c.id = _id) into check_;
    END;
$function$;

/*
 * Создать модификацию автомобиля
 * @return json
 */
CREATE OR REPLACE FUNCTION car.modification_insert(
	_name varchar,
	_date date,
	_id_country int,
	_id_car int,
	_description varchar = null,	
	out result_ json)
LANGUAGE plpgsql
AS $function$
	begin
		select * into result_ from public.get_result(1, null);
		if((SELECT * FROM car.car_check_id(_id_car)) = false) THEN
			select * into result_ from public.get_result(0, 'Указанный id автомобиля не найден');
			return;
		END if;
		if (select * from libs.country_check_id(_id_country)) = false then
			select * into result_ from public.get_result(0, 'Указанный id страны не найден');
			return;
		end if;
		insert into car.modification ("name", "date", "description", "id_country", "id_car") 
		values (_name, _date, _description, _id_country, _id_car);	
    END;
$function$;

--select * from car.modification_get(1);
--select * from  car.modification_check_id(1);
--select * from car.modification_insert('test', 1);
