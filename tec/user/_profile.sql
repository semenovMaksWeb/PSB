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


CREATE OR REPLACE FUNCTION tec.profile(_token varchar, out result_ public.result_type, out profile_ tec.user_get_profile)
 RETURNS RECORD
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
        if user_profile.active = false then
            select 0 as status_, 'Ваш аккаунт заблокирован' as error_ into result_ ;
        elseif user_profile.confirmed = false then
            select 0 as status_, 'Вы не подвердили аккаунт через почту' as error_ into result_ ;
        else
            select 1 as status_, null as error_ into result_ ;
            profile_ = user_profile;
       end if;
    END;
$function$;