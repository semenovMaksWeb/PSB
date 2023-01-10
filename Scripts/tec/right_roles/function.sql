drop function tec.right_roles_const_name_create
/**
 * @params id роли
 * @return table right
 */
CREATE OR REPLACE FUNCTION tec.get_right_roles(_id_roles int)
 RETURNS table (id int, name varchar, const_name varchar, description varchar, active boolean, date timestamp) 
 LANGUAGE plpgsql
AS $function$
    BEGIN
        return query SELECT rr.id, r."name", r.const_name, r.description, r.active, r."date" FROM tec.right_roles rr
		left join tec."right" r on r.id  = rr.id_right 
		where rr.id_roles = _id_roles;
    END;
$function$;

--select * from tec.get_right_roles(1);