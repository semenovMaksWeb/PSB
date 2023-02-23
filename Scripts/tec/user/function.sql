DROP FUNCTION tec.user_insert;
DROP FUNCTION tec.user_get_id;

/*
 * создание пользователя
 * @params данные для создания
 * @return id пользователя
 * @bec true
 **/
CREATE OR REPLACE FUNCTION tec.user_insert(
	_nik varchar,
	_email varchar,
	_password text,
	_surname varchar,
	_name varchar,
	_patronymic varchar,
	out id_ int
)
	RETURNS int4
	LANGUAGE plpgsql
AS $function$
	BEGIN
        INSERT INTO tec."user" 
		(nik, email, "password", surname, "name", patronymic) 
		VALUES (_nik, _email, _password, _surname, _name, _patronymic) 
	 	RETURNING id into id_;
        PERFORM tec.log_insert(id_, 'Пользователь создан');
	END;
$function$;

/*
 * вернуть пользователя по id_user
 * @params id пользователя
 * @return таблица пользователя
 * @bec true
 **/
CREATE OR REPLACE FUNCTION tec.user_get_id(_id_user int4)
	RETURNS TABLE(
		id int, 
		nik varchar,
		email varchar, 
		active boolean, 
		surname varchar,
		"name" varchar, 
		patronymic varchar  

		)
	LANGUAGE plpgsql
AS $function$
	BEGIN
        return query select 
			u.id as id,
			u.nik  as nik, 
			u.email as email, 
			u.active as active, 
			u.surname as surname,
			u."name" as name, 
			u.patronymic as patronymic
		from tec."user" u 
		where u.id = _id_user;
	END;
$function$;

/*
 * изменить пароль пользователю
 * @params id пользователя
 * @params новый пароль
 **/
CREATE OR REPLACE FUNCTION tec.user_update_password(_id_user int4, _password varchar)
returns void
LANGUAGE plpgsql
AS $function$
	BEGIN
        update tec."user" set "password" = _password where id = _id_user; 
	END;
$function$;


/**
 *  изменения пользователя
 * @params _id - id пользователя
 * @params _nik - ник пользователя
 * @params _name - имя пользователя
 * @params _surname - фамилия пользователя
 * @params _patronymic - отчество пользователя
 */

CREATE OR REPLACE FUNCTION tec.user_update(
	_id int,
	_nik varchar,
	_name varchar,
	_surname varchar,
	_patronymic varchar
)
RETURNS void
LANGUAGE plpgsql
AS $function$
	begin
		update tec."user" 
		set nik = _nik, "name" = _name, patronymic = _patronymic, surname = _surname  
		where id = _id;
	END
$function$;

/**
 * функция изменения активности у пользователя
 * @params id пользователя
 * @params _active активность пользователя
 */
CREATE OR REPLACE FUNCTION tec.user_update_active(
	_active boolean,
	_id int
)
RETURNS void
LANGUAGE plpgsql
AS $function$
	begin
		update tec."user" set active = _active where id = _id;
	END
$function$;

/*
 * получить список пользователей в виде таблицы
 * _id фильтр по id
 * _active фильтр по активности
 * _confirmed фильтр по подвержденным пользователям
 * _surname поиск like по фамилии
 * _limit лимит строк
 * _offset сколько пропустить строк
 **/
CREATE OR REPLACE FUNCTION tec.user_get(
	_id int = null,
	_active boolean = null,
	_confirmed boolean = null,
	_surname varchar = null,
	_limit int = null,
	_offset int = null 
	)
	RETURNS TABLE(
		id int, 
		nik varchar,
		email varchar, 
		active boolean, 
		surname varchar,
		"name" varchar, 
		patronymic varchar,
		confirmed boolean
		)
	LANGUAGE plpgsql
AS $function$
	BEGIN
        return query select 
			u.id as id,
			u.nik  as nik, 
			u.email as email, 
			u.active as active, 
			u.surname as surname,
			u."name" as name,
			u.patronymic as patronymic,
			u.confirmed as confirmed
		from tec."user" u
		where 
		(u.id = _id OR _id IS NULL) and
		(u.active = _active OR _active IS NULL) and
		(u.confirmed = _confirmed OR _confirmed IS NULL) and
		(LOWER(u.surname) like (LOWER(_surname) || '%') or _surname is null )
		limit _limit
		offset _offset;
	END;
$function$;
 
--select * from tec.user_insert('semenov', 'semenov@mail.ru', '1234', 'Семенов', 'Максим', 'Александрович');
--select * from tec.user_get_id(1); 
--select * from tec.user_update_active(true ,59)
--select * from tec.user_update(59, 'maksim', 'Макс', 'Семенов', 'Тест')
