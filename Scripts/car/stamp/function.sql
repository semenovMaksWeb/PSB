drop function car.stamp_get;
drop function car.stamp_check_unique;
drop function car.stamp_insert;

/*
 * показать марки автомобилей
 * @return table car_class
 */
CREATE OR REPLACE FUNCTION car.stamp_get()
RETURNS table (id int, "name" varchar, logo varchar, date_foundation date, description varchar, id_country int, name_country varchar)
LANGUAGE plpgsql
AS $function$
	begin
		return query 
			SELECT s.id, s."name", s.logo, s.date_foundation, s.description,
			s.id_country, c."name" as name_country
			FROM car.stamp s
			left join libs.country c on s.id_country = c.id;
    END;
$function$;

/*
 * проверка существования марки по id
 * @return boolean
 */
CREATE OR REPLACE FUNCTION car.stamp_check_id(_id varchar, out check_ boolean)
LANGUAGE plpgsql
AS $function$
	begin
		SELECT EXISTS(select id from car.stamp s where s.id = _id) into check_;
    END;
$function$;

/*
 * проверка уникальности
 * @return boolean
 */
CREATE OR REPLACE FUNCTION car.stamp_check_unique(_name varchar, out check_ boolean)
LANGUAGE plpgsql
AS $function$
	begin
		SELECT EXISTS(select id from car.stamp s where s."name" = _name) into check_;
    END;
$function$;

/*
 * создать марку автомобиля
 * @return json get_result
 */
CREATE OR REPLACE FUNCTION car.stamp_insert(
	_name varchar, 
	_logo varchar,
	_date_foundation date,
	_id_country int,
	_description varchar = null,
	out result_ json
)
returns json
LANGUAGE plpgsql
AS $function$
	begin
		select * into result_ from public.get_result(1, null);
		if (select * from car.stamp_check_unique(_name)) = true then
			select * into result_ from public.get_result(0, 'Указанное имя марки автомобиля уже существует');
			return;
		end if;
		if (select * from libs.country_check_id(_id_country)) = false then
			select * into result_ from public.get_result(0, 'Указанный id страны не найден');
			return;
		end if;
		insert into car.stamp ("name", "logo", "date_foundation", "description", "id_country")
		values (_name, _logo, _date_foundation, _description, _id_country);
    END;
$function$;

--select * from car.stamp_insert('lada', 'lada.png', '1966-01-01', 1);
--select * from car.stamp_get();