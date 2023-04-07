DROP FUNCTION tec.log_insert;
DROP FUNCTION tec.log_get;
DROP FUNCTION tec.log_delete_id;
DROP FUNCTION tec.log_delete_date;

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
 * @params id пользователя (фильтр)
 * @params _date_start c даты лога (фильтр)
 * @params _date_end  по дате лога (фильтр)
 * @return Table log
 */
CREATE OR REPLACE FUNCTION tec.log_get(
    _id_user int4 = null,
    _date_start timestamp =  null,
    _date_end timestamp =  null
)
	RETURNS TABLE (id int4, text text, date text)
	LANGUAGE plpgsql
AS $function$
	BEGIN
        return query select l.id as id, l.text as text,  to_char(l.date, 'DD.MM.YYYY HH24:MM:SS') as date
        from tec.log l
        where 
       (l.id_user = _id_user or _id_user is null) and 
       ((l.date between _date_start and _date_end) or (_date_start is null and _date_end is null));
	END;
$function$;

/*
 * удаление лога по id
 * @params id лога (фильтр)
 * @return id удаленного лога
 */
CREATE OR REPLACE FUNCTION tec.log_delete_id(
	_id int
)
	RETURNS int
	LANGUAGE plpgsql
AS $function$
begin 
	delete from tec.log where id = _id;
	return _id;
end
$function$;

/*
 * удаление лога по дате between
 * @params date_start дата лога(с) (фильтр)
 * @params date_end дата лога(по) (фильтр)
 */
CREATE OR REPLACE FUNCTION tec.log_delete_date(
	 _date_start timestamp,
	_date_end timestamp
)
	RETURNS void
	LANGUAGE plpgsql
AS $function$
begin 
	delete from tec.log where date between _date_start and _date_end;
end
$function$;

COMMENT ON FUNCTION tec.log_delete_date(timestamp, timestamp) IS 'Удаление логов по дате between';
COMMENT ON FUNCTION tec.log_delete_id(int4) IS 'Удаление лога по id';
COMMENT ON FUNCTION tec.log_get(int4, timestamp, timestamp) IS 'Просмотр логов';
COMMENT ON FUNCTION tec.log_insert(in int4, in text, out int4) IS 'Создание логов';

--select * from tec.log_delete_date(_date_start => '2023-01-06 00:00:00', _date_end => '2023-01-10 00:00:00');
--select * from tec.log_delete_id(106);
--select * from tec.user_insert('semenov', 'semenov@mail.ru', '1234', 'Семенов', 'Максим', 'Александрович');
--select * from tec.log_get (_date_start => '2023-01-06 00:00:00', _date_end => '2023-01-10 00:00:00')

 