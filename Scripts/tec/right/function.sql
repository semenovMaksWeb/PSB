/*
 * @params id пользователя
 * @return table (id right)
 */
CREATE OR REPLACE FUNCTION tec.right_get_userid(_id integer)
RETURNS TABLE(id integer)
LANGUAGE plpgsql
AS $function$
    BEGIN
    RETURN query
        select rr.id_right from tec.roles_user ru
            left join tec.roles r on ru.id_roles = r.id
            left join tec.right_roles rr on rr.id_roles = r.id 
            where ru.id_user  = _id;
    END;
$function$;

/*
 * @params id пользователя
 * @return table right права которые есть у пользователя
 */
CREATE OR REPLACE FUNCTION tec.right_get_userid_list(_id integer)
RETURNS TABLE(id integer, name varchar, const_name varchar)
LANGUAGE plpgsql
AS $function$
    BEGIN
    RETURN query
       select rig.id, rig."name", rig.const_name  
       from tec.roles_user ru
            left join tec.roles r on ru.id_roles = r.id
            left join tec.right_roles rr on rr.id_roles = r.id
            left join tec."right" rig on rig.id  = rr.id_right
            where ru.id_user = _id;
    END;
$function$;


/*
 * @params id пользователя
 * @return table right права которых нет у пользователя
 */
CREATE OR REPLACE FUNCTION tec.right_get_not_userid_list(_id integer)
RETURNS TABLE(id integer, name varchar, const_name varchar)
LANGUAGE plpgsql
AS $function$
    BEGIN
    RETURN query
        select r.id, r."name", r.const_name 
        from tec."right" r 
        where r.id not in (
	        select rig.id 
	        from  tec.roles_user ru
            left join tec.roles r on ru.id_roles = r.id
            left join tec.right_roles rr on rr.id_roles = r.id
            left join tec."right" rig on rig.id  = rr.id_right
            where ru.id_user = _id and rig.id is not null
        );
    END;
$function$;

/*
 * @return table right 
 */
CREATE OR REPLACE FUNCTION tec.right_get(_const_name varchar=null, _active boolean=null)
RETURNS TABLE(id integer, name varchar, const_name varchar, description varchar, active boolean, date timestamp)
LANGUAGE plpgsql
AS $function$
    BEGIN
    RETURN query
        select *
        from tec."right" r 
        	where case
			when _const_name IS NOT NULL then r.const_name = _const_name
			when _active IS NOT NULL then r.active = _active
			else true
		end;
    END;
$function$;

--select * from tec.right_get_userid(18);
--select * from tec.right_get_userid_list(18);
--select * from tec.right_get_not_userid_list(18);
--select * from tec."right" r 
--select * from tec.right_get(_active => true)
