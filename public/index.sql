create type public."result_type" AS (
	status_ int,
	error_ text
)
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
