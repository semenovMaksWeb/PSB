DROP FUNCTION tec.roles_user_get_name_id;
DROP FUNCTION tec.roles_user_not_get_name_id; 
DROP FUNCTION tec.roles_user_check_not_roles; 
DROP FUNCTION tec.roles_user_insert;
DROP FUNCTION tec.roles_user_delete;

/*
 * Функция roles_user_get_name_id
 * @params id пользователя
 * @return таблица ролей пользователя в виде списка
 * @bec true
 * */
CREATE OR REPLACE FUNCTION tec.roles_user_get_name_id(_id integer)
RETURNS TABLE(id integer, name varchar, const_name varchar)
LANGUAGE plpgsql
AS $function$
    BEGIN
    RETURN query
        select r.id, r."name", r.const_name from tec.roles_user ru
            left join tec.roles r on ru.id_roles = r.id 
            where ru.id_user = _id;
    END;
$function$;

/*
 * Функция roles_user_not_get_name_id
 * @params id пользователя
 * @return таблица ролей которых нет  у пользователя в виде списка
 * @bec true
 * */
CREATE OR REPLACE FUNCTION tec.roles_user_not_get_name_id(_id integer)
RETURNS TABLE(id integer, name varchar, const_name varchar)
LANGUAGE plpgsql
AS $function$
    BEGIN
    RETURN query
        select r.id, r."name", r.const_name from tec.roles_user ru
            left join tec.roles r on ru.id_roles != r.id 
            where ru.id_user = _id;
    END;
$function$;


/*
 * Функция roles_user_check_not_roles
 * @params id пользователя, 
 * @params массив ролей
 * @return булевое значение
 * true у пользователя нет не одной из указанных ролей 
 * false у пользователя есть указанные роли
 * */
CREATE OR REPLACE FUNCTION tec.roles_user_check_not_roles(_id_user integer, _id_roles integer[])
RETURNS boolean
LANGUAGE plpgsql
AS $function$
    BEGIN
    return (select (select count(ru.id) 
        from tec.roles_user ru 
        where ru.id_user = _id_user and ru.id_roles = ANY (_id_roles)) = 0); 
    END;
$function$;


/*
 * Функция roles_user_insert
 * @params id пользователя
 * @params массив ролей
 * @return json валидация результата сохранение ролей через public.get_result
 * @description проверка что нет ролей которых ходим добавить, проверка что все указанные роли существуют если все валидно то сохраняем записи.
 * */
CREATE OR REPLACE FUNCTION tec.roles_user_insert(_id_user integer, _id_roles integer[], out result_ json)
LANGUAGE plpgsql
AS $function$
    BEGIN
        if (select * from tec.roles_user_check_not_roles(_id_user, _id_roles)) = false then
            select * into result_ from public.get_result(0, 'Указанные роли уже есть у пользователя');
            return;
        elseif (select * from tec.roles_check_ids(_id_roles)) = false then
            select * into result_ from public.get_result(0, 'Указанные роли не существуют');
            RETURN;
        END IF;
        insert into tec.roles_user (id_user, id_roles) VALUES (_id_user, UNNEST(_id_roles));
        select * into result_ from public.get_result(1, '');
    END;
$function$

/*
 * Функция roles_user_delete
 * @params id пользователя
 * @params массив ролей
 * @return json валидация результата сохранение ролей через public.get_result
 * @description удаляет массив ролей от пользователя без валидации.
 * */
CREATE OR REPLACE FUNCTION tec.roles_user_delete(_id_user integer, _id_roles integer[], out result_ json)
LANGUAGE plpgsql
AS $function$
    BEGIN
        DELETE FROM tec.roles_user ru where ru.id_roles = ANY (_id_roles) and ru.id_user = _id_user;
        select * into result_ from public.get_result(1, '');
    END;
$function$


--select * from tec.roles_user_get_name_id(18);
--select * from tec.roles_user_not_get_name_id(18);
--select * from tec.roles_user_check_not_roles(18, ARRAY [1]);
--select * from tec.roles_user_insert(18, ARRAY [1]);  