DROP FUNCTION tec.log_insert;
DROP FUNCTION tec.log_get_id;

/*
 * создает новую запись в таблицу log
 * @params id пользователя
 * @params text логирования
 * @return id новой записи
 */
CREATE OR REPLACE FUNCTION tec.log_insert(
    _id_user int4,
    _text text,
    out id_ int
)
	RETURNS int4
	LANGUAGE plpgsql
AS $function$
	BEGIN
        INSERT INTO tec."log" (id_user, "text") 
        VALUES (_id_user, _text)
        RETURNING id into id_;
	END;
$function$;

/*
 * просмотр логирования для конкретного пользователя
 * @params id пользователя
 * @return Table log
 */
CREATE OR REPLACE FUNCTION tec.log_get_id(
    _id_user int4
)
	RETURNS TABLE (id int4, text text, date text)
	LANGUAGE plpgsql
AS $function$
	BEGIN
        return query select l.id as id, l.text as text,  to_char(l.date, 'DD.MM.YYYY HH24:MM:SS') as date
        from tec.log l
        where l.id_user = _id_user;
	END;
$function$;

--select * from tec.user_insert('semenov', 'semenov@mail.ru', '1234', 'Семенов', 'Максим', 'Александрович');
--select * from tec.log_get_id(25);
--select * from tec.log l 

 