CREATE OR REPLACE FUNCTION tec.right_roles_const_name_create(_roles_const_name varchar, _right_const_name varchar)
 RETURNS void 
 LANGUAGE plpgsql
AS $function$
    BEGIN
        insert into tec.right_roles (id_roles, id_right) values (
            (select id from tec."roles" r where r.const_name = _roles_const_name),
            (select id from tec."right" r where r.const_name = _right_const_name)	
        );
    END;
$function$
;
