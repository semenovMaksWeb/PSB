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



CREATE OR REPLACE FUNCTION tec.roles_user_check_not_roles(_id_user integer, _id_roles integer[])
RETURNS boolean
LANGUAGE plpgsql
AS $function$
    BEGIN
    return (select (select count(ru.id) 
        from tec.roles_user ru 
        where ru.id_user = _id_user and ru.id_roles = ANY (_id_roles)) = 0); 
    END;
$function$;


CREATE OR REPLACE FUNCTION tec.roles_user_insert(_id_user integer, _id_roles integer[])
RETURNS boolean
LANGUAGE plpgsql
AS $function$
    BEGIN
        if (select * from tec.roles_user_check_not_roles(_id_user, _id_roles)) and (select * from tec.roles_check_ids(_id_roles)) then
            return (select true);
        END IF;
        return (select false);
    END;
$function$;


select * from tec.roles_user_get_name_id(18);
select * from tec.roles_user_not_get_name_id(18);
select * from tec.roles_user_check_not_roles(18, ARRAY [1]);

DROP FUNCTION tec.roles_user_get_name_id;
DROP FUNCTION tec.roles_user_not_get_name_id;   