drop function tec.right_get
drop function tec.right_get_userid
drop function tec.right_get_userid_list
drop function tec.right_get_not_userid_list

/*
 * @params id пользователя
 * @return table (id right)
 */
CREATE OR REPLACE FUNCTION tec.right_get_userid(
	_id integer
	)
RETURNS TABLE(id integer)
LANGUAGE plpgsql
AS $function$
    BEGIN
    RETURN query
        select rr.id_right from tec.roles_user ru
            left join tec.roles r on ru.id_roles = r.id
            left join tec.right_roles rr on rr.id_roles = r.id 
            where ru.id_user = _id;
    END;
$function$;

/*
 * @params id пользователя
 * @params id_right id право (фильтр)
 * @params _const_name констант имя право (фильтр)
 * @return table right права которые есть у пользователя
 */
CREATE OR REPLACE FUNCTION tec.right_get_userid_list(
	_id integer,
	_id_right int = null, 
	_const_name varchar = null
)
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
            where ru.id_user = _id and 
           (rig.id = _id_right or _id_right is null)
          and (rig.const_name = _const_name or _const_name is null);
    END;
$function$;


/*
 * @params id пользователя
 * @return table right права которых нет у пользователя
 */
CREATE OR REPLACE FUNCTION tec.right_get_not_userid_list(
	_id integer,
	_id_right int = null, 
	_const_name varchar = null
)
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
      	)
        and (r.id = _id_right or _id_right is null)
       	and (r.const_name = _const_name or _const_name is null); 	
    END;
$function$;

/*
 * @return table right 
 */
CREATE OR REPLACE FUNCTION tec.right_get(_const_name varchar=null, _active boolean=null, _id int = null)
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
			when _id IS NOT NULL then r.id = _id
			else true
		end;
    END;
$function$;

--select * from tec.right_get_userid(49);
--select * from tec.right_get_userid_list(79);
--select * from tec.right_get_not_userid_list(79, _id_right => 1);
--select * from tec."right" r 
--select * from tec.right_get(_active => true)