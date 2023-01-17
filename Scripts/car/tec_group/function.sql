/*
 * показать технические группы характеристик автомобилей
 * @return table tec_group
 */
CREATE OR REPLACE FUNCTION car.tec_group_get()
RETURNS setof car.tec_group
LANGUAGE plpgsql
AS $function$
	begin
		return query SELECT * FROM car.tec_group t_g;
    END;
$function$;

/*
 * Проверить уникальность имени технические группы характеристик автомобилей
 * @return boolean
 */
CREATE OR REPLACE FUNCTION car.tec_group_check_unique(_name varchar, out check_ boolean)
LANGUAGE plpgsql
AS $function$
	begin
		SELECT EXISTS(SELECT * FROM car.tec_group t_g where t_g."name" = _name) into check_;
    END;
$function$;

/*
 * Проверить существования технические группы характеристик автомобилей по id
 * @return boolean
 */
CREATE OR REPLACE FUNCTION car.tec_group_check_id(_id int, out check_ boolean)
LANGUAGE plpgsql
AS $function$
	begin
		SELECT EXISTS(SELECT * FROM car.tec_group t_g where t_g.id = _id) into check_;
    END;
$function$;

/*
 * Проверить существования технические группы характеристик автомобилей по id
 * @return boolean
 */
CREATE OR REPLACE FUNCTION car.tec_group_insert(_name varchar, out result_ json)
LANGUAGE plpgsql
AS $function$
	begin
		select * into result_ from public.get_result(1, null); 
		if ((select * from car.tec_group_check_unique(_name)) = true) then
			select * into result_ from public.get_result(0, 'Указанное имя технической группы характеристик автомобиля уже существует');
			return;
		end if;
		insert into car.tec_group ("name") values (_name);		
    END;
$function$;


--select * from car.tec_group_get();
--select * from car.tec_group_check_unique('test');
--select * from  car.tec_group_check_id(1);
--select * from car.tec_group_insert('test');