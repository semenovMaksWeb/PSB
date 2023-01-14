drop function tec.roles_check_id;
drop function tec.roles_check_ids;
drop function tec.roles_get;

/**
 * @params id роли
 * @return булевое значение 
 * true такое право существует
 * false такого право не существует
 */
CREATE OR REPLACE FUNCTION tec.roles_check_id(_id integer)
RETURNS boolean
LANGUAGE plpgsql
AS $function$
    begin
	   return (select exists(select r.id from tec.roles r where r.id = _id));
    END;
$function$;

/**
 * @params массив id ролей
 * @return булевое значение 
 * true такие права существуют
 * false таких прав не существует
 */
CREATE OR REPLACE FUNCTION tec.roles_check_ids(_ids integer[])
RETURNS boolean
LANGUAGE plpgsql
AS $function$
    begin
       return (
        select (select count(r.id) 
            from tec.roles r  
            where r.id = ANY (_ids)) = (select cardinality(_ids))
       );
    END;
$function$;

/**
 * @return таблица ролей 
 */
CREATE OR REPLACE FUNCTION tec.roles_get(_active boolean = null, _const_name varchar = null)
RETURNS table(id int, description text, active boolean, const_name varchar)
LANGUAGE plpgsql
AS $function$
    begin
       	return query 
       	select * 
       	from tec.roles r 
       	where case
			when _active IS NOT NULL then r.active = _active
			when _const_name IS NOT NULL then r.const_name = _const_name
			else true
		end;
    END;
$function$;


--select * from tec.roles r where r.active = true and r.const_name = 'admin'

--select * from tec.roles_check_id(1)
--select * from tec.roles_check_ids(array[1,2])