drop function car.car_class_get;

/*
 * показать классы автомобилей
 * @return table car_class
 */
CREATE OR REPLACE FUNCTION car.car_class_get()
RETURNS  setof car.car_class
LANGUAGE plpgsql
AS $function$
	begin
		return query select * from car.car_class c_c;
    END;
$function$;


/*
 * проверка существования класса автомобиля по id
 * @return boolean
 */
CREATE OR REPLACE FUNCTION car.car_class_check_id(_id varchar, out check_ boolean)
LANGUAGE plpgsql
AS $function$
	begin
		SELECT EXISTS(select * from car.car_class c_c where c_c.id = _id) into check_;
    END;
$function$;

--select * from car.car_class_get()