CREATE OR REPLACE FUNCTION tec.check_right(_token character varying, _right_const_name character varying, OUT result_ json)
 RETURNS json
 LANGUAGE plpgsql
AS $function$
	declare
		result_profile tec.result_profile;
        check_right_user boolean;
    BEGIN
       select * into result_profile from tec.profile(_token);
       if ((result_profile.result_::json->'status')::text::int) = 1 and result_profile.profile_::json->'id' is not null then
            select exists (	
                select r.id  from tec."right" r where r.const_name  = _right_const_name and r.id in (
                    select  rig.id as rig_id from tec."user" u 
                    left join tec.roles_user ru on ru.id_user = u.id 
                    left join tec.roles r on r.id = ru.id_roles 
                    left  join  tec.right_roles rr on rr.id_roles = ru.id_roles 
                    left join tec."right" rig on rig.id = rr.id_right 
                    where u.id  = (result_profile.profile_::json->'id')::text::int
                )	
            ) into check_right_user;
       end if;
      result_ := result_profile.result_;
        if  check_right_user = false then
           select * into result_  from public.get_result(0, 'У вас нет прав на данную операцию');
        end if;
       	if  (result_::json->'status')::text::int = 1 then
       		 select jsonb_build_object(
				'id', result_profile.profile_::json->'id',
				'status', result_::json->'status',
				'error', result_::json->'error'
			) into result_;
       	end if;
    END;
$function$;