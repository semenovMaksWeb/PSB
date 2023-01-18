drop function car.car_get
/*
 * показать автомобили
 * @return table car
 */
CREATE OR REPLACE FUNCTION car.car_get(_limit int = 20, _offset int = 0)
RETURNS table (
	id int, 
	"name" varchar, 
	"date" date, 
	description varchar, 
	id_car_class int, 
	id_stamp int, 
	id_model int, 
	id_gen int,
	car_class_name varchar,
	stamp_name varchar,
	stamp_logo varchar,
	model_name varchar,
	gen_name varchar
	)
LANGUAGE plpgsql
AS $function$
	begin
		return query
		select c.*, cc."name" as car_class_name, 
		s."name" as stamp_name, s.logo as stamp_logo, 
		m."name" as model_name,
		g."name" as gen_name
		from car.car c
		left join car.car_class cc on cc.id = c.id_car_class
		left join car.stamp s on s.id = c.id_stamp
		left join car.model m on m.id = c.id_model
		left join car.gen g on g.id = c.id_gen 
		LIMIT _limit OFFSET _offset;
    END;
$function$;

/*
 * Проверить существования автомобиля по id
 * @return boolean
 */
CREATE OR REPLACE FUNCTION car.car_check_id(_id int, out check_ boolean)
LANGUAGE plpgsql
AS $function$
	begin
		SELECT EXISTS(SELECT * FROM car.car c where c.id = _id) into check_;
    END;
$function$;

/*
 * Создать автомобиль
 * @return json
 */
CREATE OR REPLACE FUNCTION car.car_insert(
	_name varchar,
	_date date,
	_id_car_class int,
	_id_stamp int,
	_id_model int,
	_id_gen int,
	_description varchar = null,	
	out result_ json)
LANGUAGE plpgsql
AS $function$
	begin
		select * into result_ from public.get_result(1, null);
		if((SELECT * FROM car.car_class_check_id(_id_car_class)) = false) THEN
			select * into result_ from public.get_result(0, 'Класс автомобиля по указанному id не найдено');
			return;
		END if;
		if ((select * from car.stamp_check_id(_id_stamp)) = false) then
			select * into result_ from public.get_result(0, 'Марка автомобиля по указанному id не найдено');
 			return;
		end if;
		if ((select * from car.model_check_id(_id_model)) = false) then
			select * into result_ from public.get_result(0, 'Модель автомобиля по указанному id не найдено');
 			return;
		end if;
	if ((select * from car.gen_check_id(id_gen)) = false) then
			select * into result_ from public.get_result(0, 'Поколение автомобиля по указанному id не найдено');
 			return;
		end if;
		insert into car.car ("name", "date", "description", "id_car_class", "id_stamp", "id_model", "id_gen") 
		values (_name, _date, _description, _id_car_class, _id_stamp, _id_model, _id_gen);	
    END;
$function$;

 

--select * from car.car_get();
--select * from  car.car_check_id(1);
--select * from car.car_insert('test', 1);
