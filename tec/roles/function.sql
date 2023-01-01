CREATE OR REPLACE FUNCTION tec.roles_check_id(_id integer)
RETURNS boolean
LANGUAGE plpgsql
AS $function$
    begin
	   return (select exists(select r.id from tec.roles r where r.id = _id));
    END;
$function$;

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


select * from tec.roles_check_id(1)