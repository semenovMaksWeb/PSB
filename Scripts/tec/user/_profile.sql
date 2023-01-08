create type tec.result_profile as (
	result_ json,
	profile_ json
)

create type tec."user_get_profile" AS (
	id int4,
	nik varchar,
	email varchar,
	active bool,
	confirmed bool,
	name varchar,
	surname varchar,
	patronymic varchar
)


CREATE OR REPLACE FUNCTION tec.profile(_token character varying, OUT result_ json, OUT profile_ json)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
	declare
		user_profile tec.user_get_profile;
	BEGIN
	select u.id, u.nik, u.email, u.active, u.confirmed, u."name" , u.patronymic, u.surname 
        into user_profile
			from tec."token" t  
			left join  tec."user" u on u.id  = t.id_user 
			where t.value = _token and t.active = true and t.date_end > CURRENT_TIMESTAMP;
        if user_profile is null then
			select * into result_  from public.get_result(0, 'Не валидный токен');
		elseif user_profile.active = false then
			select * into result_  from public.get_result(0, 'Ваш аккаунт заблокирован');
        elseif user_profile.confirmed = false then
		select * into result_  from public.get_result(0, 'Вы не подвердили аккаунт через почту');
        else
			select * into result_  from public.get_result(1, null);
			select jsonb_build_object(
				'id', user_profile.id,
				'nik', user_profile.nik, 
				'email', user_profile.email,
				'active', user_profile.active,
				'confirmed', user_profile.confirmed,
				'name', user_profile.name,
				'surname', user_profile.surname,
				'patronymic', user_profile.patronymic
			) into profile_;
       end if;
    END;
$function$
;