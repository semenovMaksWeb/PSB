drop function car.modification_parameter_get
/*
 * TODO возможно переделать в json для создания группировки, вложенности
 * показать параметры модификации автомобиля
 * @return table modification_parameter
 */
CREATE OR REPLACE FUNCTION car.modification_parameter_get(_id_car int)
RETURNS table (id int, id_modification int, id_tec_parameter int, value varchar, tec_parameter_name varchar, tec_group_name varchar)
LANGUAGE plpgsql
AS $function$
	begin
		return query 
		select mp.*, tp."name" as tec_parameter_name, tg."name" as tec_group_name from car.modification_parameter mp
		left join car.tec_parameter tp on tp.id = mp.id_tec_parameter
		left join car.tec_group tg on tg.id = tp.id_tec_group
		where mp.id_modification = 1;
    END;
$function$;


/*
 * Создать параметр модификации автомобиля
 * @return json
 */
CREATE OR REPLACE FUNCTION car.modification_parameter_insert(
	_id_tec_paramater int,
	_id_modification int,
	_value varchar = null,	
	out result_ json)
LANGUAGE plpgsql
AS $function$
	begin
		select * into result_ from public.get_result(1, null);
		if((SELECT * FROM car.modification_check_id(_id_car)) = false) THEN
			select * into result_ from public.get_result(0, 'Указанный id модификации автомобиля не найден');
			return;
		END if;
		if (select * from car.tec_parameter_check_id(_id_country)) = false then
			select * into result_ from public.get_result(0, 'Указанный id технической характеристики автомобиля не найден');
			return;
		end if;
		insert into car.modification_parameter ("value", "id_modification", "id_tec_paramater") 
		values (_value, _id_modification, _id_tec_paramater);	
    END;
$function$;

select mp.*, tp."name" as tec_parameter_name, tg."name" as tec_group_name from car.modification_parameter mp
left join car.tec_parameter tp on tp.id = mp.id_tec_parameter
left join car.tec_group tg on tg.id = tp.id_tec_group
where mp.id_modification = 1

--select * from car.modification_parameter_get(1);
--select * from car.modification_parameter_insert('test', 1);
