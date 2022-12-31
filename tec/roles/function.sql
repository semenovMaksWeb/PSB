CREATE OR REPLACE FUNCTION tec.roles_check_id(_id integer)
RETURNS boolean
LANGUAGE plpgsql
AS $function$
    begin
	   return (select exists(select r.id from tec.roles r where r.id = _id));
    END;
$function$;



select * from tec.roles_check_id(1)