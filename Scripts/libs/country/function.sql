drop function tec.country_unique;
drop function tec.country_get;
/*
 * проверка есть ли страна с указанным названием
 * @params _name имя страны
 * @return boolean
 */
CREATE OR REPLACE FUNCTION libs.country_unique(_name character varying, out check_ boolean)
 RETURNS boolean
 LANGUAGE plpgsql
AS $function$
	begin
		select EXISTS(select c.id from libs.country c where "name" = _name) into check_;
    END;
$function$;

/*
 * вернуть все страны
 * @return TABLE стран
 */
CREATE OR REPLACE FUNCTION libs.country_get()
RETURNS setof libs.country
LANGUAGE plpgsql
AS $function$
	begin
		return query SELECT * FROM libs.country c; 
    END;
$function$;


CREATE OR REPLACE FUNCTION libs.country_insert(
	_name varchar, 
	_capital varchar, 
	_flag varchar, 
	_description varchar = null,
	out result_ json
)
RETURNS json
LANGUAGE plpgsql
AS $function$
	begin
		select * into result_ from public.get_result(1, null);
		if libs.country_unique(_name) = 1 then
			select * from public.get_result(0, 'текущие имя страны уже существует'); 
		else
			insert into libs.country ("name", capital, description, flag) values (_name, _capital, _flag, _description);
		end if;
    END;
$function$;


--select * from libs.country_get();
--select * from libs.country_unique('Россия');