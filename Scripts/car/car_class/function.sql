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

--select * from car.car_class_get()