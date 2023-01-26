drop function public.insert_into_dynamic

/**
 * возможно old
 */
create type public."result_type" AS (
	status_ int,
	error_ text
)

/*
 * возможно не нужная функция из за неизвестного безопастной её использования
 * универсальная функция создания sql запроса учитывая передаваемые параметры
 * @params sql первоначальный sql код
 * @params limit количество строк
 * @params offset количество пропускаемых строк
 * @params where строка с условиями
 * @params order_by строка с сортировкой
 * @return строка sql кода
 **/
CREATE OR REPLACE FUNCTION public.table_get(_sql character varying, _limit integer DEFAULT NULL::integer, _offset integer DEFAULT NULL::integer, _order_by character varying DEFAULT NULL::character varying, _where text DEFAULT NULL::text)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare
    sql varchar;
begin
    sql := _sql;
    IF _where  IS NOT NULL THEN 
        IF (select position('where' in sql)) > 0 THEN
          sql := concat(sql || ' and ' || _where);
        ELSE
            sql := concat(sql || ' where ' || _where); END IF;
        END IF;
    IF _order_by  IS NOT NULL THEN sql := concat(sql || ' order by ' || _order_by); END IF;
    IF _limit  IS NOT NULL THEN sql := concat(sql || ' limit ' || _limit); END IF;
    IF _offset  IS NOT NULL THEN sql := concat(sql || ' offset ' || _offset); END IF;
    return sql;
END;
$function$
;

/*
 * функция конвертация в json
 * @params _status, _error
 * @return json
 **/
CREATE OR REPLACE FUNCTION public.get_result(_status int, _error varchar, out result_ json)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
	BEGIN
	 select jsonb_build_object(
	'error', _error,
	'status', _status
) into result_;
    END;
$function$;


/*
 * функция динамический inser into
 * @table, @name, @values
 * @return json
 **/
CREATE OR REPLACE FUNCTION public.insert_into_dynamic(_schema varchar,_table varchar, _column varchar, _values varchar)
RETURNS void
LANGUAGE plpgsql
AS $function$
	BEGIN
		execute format('insert into %I.%I (%s) VALUES (%s)', _schema, _table, _column, _values);
    END;
$function$; 

 
--select * from  public.insert_into_dynamic('tec', 'log', 'id_user,text', 'null, ''тестовый лог'' ');
 