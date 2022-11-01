/* drop function */
DROP FUNCTION public.log_insert;
DROP FUNCTION log_get_id;
/* drop function */

CREATE OR REPLACE FUNCTION public.log_insert(
    _id_user int4,
    _text text,
    out id_ int
)
	RETURNS int4
	LANGUAGE plpgsql
AS $function$
	BEGIN
        INSERT INTO public."log" (id_user, "text") 
        VALUES (_id_user, _text)
        RETURNING id into id_;
	END;
$function$;

CREATE OR REPLACE FUNCTION public.log_get_id(
    _id_user int4
)
	RETURNS TABLE (id int4, text text, date varchar)
	LANGUAGE plpgsql
AS $function$
	BEGIN
        return query select l.id as id, l.text as text,  to_char(l.date, 'DD.MM.YYYY HH24:MM:SS') as date
        from public.log l
        where l.id_user = _id_user;
	END;
$function$;




/* start function */
select * from public.user_insert('semenov', 'semenov@mail.ru', '1234', 'Семенов', 'Максим', 'Александрович');
select * from public.log_get_id(1)
/* start function */