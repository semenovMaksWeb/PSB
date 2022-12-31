CREATE OR REPLACE FUNCTION tec.roles_user_get_name_id(_id integer)
RETURNS TABLE(id integer, name varchar, const_name varchar)
LANGUAGE plpgsql
AS $function$
    BEGIN
    RETURN query
        select r.id, r."name", r.const_name from tec.roles_user ru
            left join tec.roles r on ru.id_roles = r.id 
            where ru.id_user = _id;
    END;
$function$;

CREATE OR REPLACE FUNCTION tec.roles_user_not_get_name_id(_id integer)
RETURNS TABLE(id integer, name varchar, const_name varchar)
LANGUAGE plpgsql
AS $function$
    BEGIN
    RETURN query
        select r.id, r."name", r.const_name from tec.roles_user ru
            left join tec.roles r on ru.id_roles != r.id 
            where ru.id_user = _id;
    END;
$function$;

select * from tec.roles_user_get_name_id(18);
select * from tec.roles_user_not_get_name_id(18);

DROP FUNCTION tec.roles_user_get_name_id;
DROP FUNCTION tec.roles_user_not_get_name_id;