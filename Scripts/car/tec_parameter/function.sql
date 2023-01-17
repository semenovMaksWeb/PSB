/*
 * показать технические характеристики автомобилей
 * @return table tec_parameter
 */
CREATE OR REPLACE FUNCTION car.tec_parameter_get()
RETURNS setof car.tec_parameter
LANGUAGE plpgsql
AS $function$
	begin
		return query SELECT * FROM car.tec_parameter t_c;
    END;
$function$;

/*
 * Проверить уникальность имени технической характеристики автомобиля
 * @return boolean
 */
CREATE OR REPLACE FUNCTION car.tec_parameter_check_unique(_name varchar, out check_ boolean)
LANGUAGE plpgsql
AS $function$
	begin
		SELECT EXISTS(SELECT * FROM car.tec_parameter t_c where t_c."name" = _name) into check_;
    END;
$function$;

/*
 * Проверить существования технической  характеристики автомобиля по id
 * @return boolean
 */
CREATE OR REPLACE FUNCTION car.tec_parameter_check_id(_id int, out check_ boolean)
LANGUAGE plpgsql
AS $function$
	begin
		SELECT EXISTS(SELECT * FROM car.tec_parameter t_c where t_c.id = _id) into check_;
    END;
$function$;

/*
 * Создать техническую характеристику автомобиля
 * @return json
 */
CREATE OR REPLACE FUNCTION car.tec_parameter_insert(_name varchar, _id_tec_group int, out result_ json)
LANGUAGE plpgsql
AS $function$
	begin
		select * into result_ from public.get_result(1, null);
		if((SELECT * FROM car.tec_group_check_id(_id_tec_group)) = true) THEN
			select * into result_ from public.get_result(0, 'техническая группа характеристики автомобиля не найдена');
			return;
		END if;
		if ((select * from car.tec_parameter_check_unique(_name)) = true) then
			select * into result_ from public.get_result(0, 'Указанное имя технической характеристики автомобиля уже существует');
			return;
		end if;
		insert into car.tec_parameter ("name", "id_tec_group") values (_name, _id_tec_group);	
    END;
$function$;


--select * from car.tec_parameter_get();
--select * from car.tec_parameter_check_unique('test');
--select * from  car.tec_parameter_check_id(1);
--select * from car.tec_parameter_insert('test', 1);