drop function tec.token_insert;
drop function tec.token_delete_value;
drop function tec.token_delete_not_active;
DROP FUNCTION tec.token_get;
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
 * @return json public.get_result
 * @description функция удаляет токен по его значению
 */
CREATE OR REPLACE FUNCTION tec.token_delete_value(_token varchar, out result_ json)
LANGUAGE plpgsql
AS $function$
    BEGIN
	   DELETE FROM tec."token" t WHERE t.value = _token;
	   select * into result_ from public.get_result(1, null);
    END;
$function$;

/*
 * @return json public.get_result
 * @description функция удаляет токены которые уже не валидные
 */
CREATE OR REPLACE FUNCTION tec.token_delete_not_active(out result_ json)
LANGUAGE plpgsql
AS $function$
    BEGIN
	   DELETE FROM tec."token" t where t.date_end < CURRENT_TIMESTAMP or t.active = false;
	   select * into result_ from public.get_result(1, null);
    END;
$function$;

/*
 * @return таблицу токенов с пользователями
 * @description функция удаляет токены которые уже не валидные
 */
CREATE OR REPLACE FUNCTION tec.token_get(_id_user int = null, _token varchar = null)
returns table(id int, value text, date timestamp, active boolean, date_end timestamp, id_user int, email varchar, surname varchar, name varchar) 
LANGUAGE plpgsql
AS $function$
    begin
	    return query select t.*, u.email,u.surname, u."name" from tec."token" t 
		left join tec."user" u on u.id = t.id_user
		where  
		case
			when _id_user IS NOT NULL then t.id_user = _id_user
			when _token IS NOT NULL then t.value  = _token
			else true 
		end;
    END;
$function$;



--select * from tec.token_delete_value('1yJ1eXA1OiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVc2VyIERldGFpbHMiLCJuaWsiOiJzZW1lbm92IiwiaWF0IjoxNjcyNjAxNzQ4LCJlbWFpbCI6InNlbWVub3ZAbWFpbC5ydSJ9.86TWeFQouC-mew5u2mbD6Lw71DKF1OQ0ufpbVM0X5M0');
--select * from tec.token_delete_not_active();
--select * from tec."token" t 
--select * from tec."token" t where t.date_end < CURRENT_TIMESTAMP or t.active = false
--select * from tec.token_get(_token => 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVc2VyIERldGFpbHMiLCJuaWsiOiJob3hpZ2FmNDMwIiwiaWF0IjoxNjcyOTg0MTg5LCJlbWFpbCI6ImhveGlnYWY0MzBAY254Y29pbi5jb20ifQ.3i5pop0YyXBt_b3neElOh2o01L_lTBP7E5VapnbWi0c', _id_user => 40)