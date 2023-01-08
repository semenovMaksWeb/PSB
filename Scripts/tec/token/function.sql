/*
 * @params id пользователя
 * @params token пользователя
 * @return токен пользователя
 * @bec true
 */
CREATE OR REPLACE FUNCTION tec.token_insert(_id_user integer, _token varchar, OUT token_ character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
    BEGIN
	    insert into tec."token" 
        ("value", "id_user")
        values (_token,_id_user)
        RETURNING "token".value INTO token_;
    END;
$function$
;

/*
 * @params id пользователя
 * @params token пользователя
 * @return токен
 * @bec true
 */
CREATE OR REPLACE FUNCTION tec.token_delete_value(_token varchar, OUT token_ character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
    BEGIN
	    DELETE FROM tec."token" t WHERE t.
	    insert into tec."token" 
        ("value", "id_user")
        values (_token,_id_user)
        RETURNING "token".value INTO token_;
    END;
$function$
;


SELECT * FROM tec.token