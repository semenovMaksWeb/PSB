INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Создавать/редактировать право', 'right_update', 'Создавать/редактировать право', true, '2022-12-05 21:33:56.086');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Просмотр прав', 'right_get', 'Просмотр прав', true, '2022-12-05 21:33:56.104');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Создавать/редактировать   ролей', 'roles_update', 'Создавать/редактировать   ролей', true, '2022-12-05 21:33:56.104');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Просмотр ролей', 'roles_get', 'Просмотр ролей', true, '2022-12-05 21:33:56.105');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Создавать/редактировать связи роли с правами', 'right-roles_update', 'Создавать/редактировать связи роли с правами', true, '2022-12-05 21:33:56.105');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Просмотр связей ролей и прав', 'right-roles_get', 'Просмотр связей ролей и прав', true, '2022-12-05 21:33:56.106');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Создавать/редактировать связи роли с пользователями', 'roles-user-update', 'Создавать/редактировать связи роли с пользователями', true, '2022-12-05 21:33:56.107');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Просмотр связей ролей и пользователей', 'roles-user-get', 'Просмотр связей ролей и пользователей', true, '2022-12-05 21:33:56.107');




INSERT INTO public.exercises ("name", id_user) VALUES('Жим ногами лежа', 1);
INSERT INTO public.exercises ("name", id_user) VALUES('Сгибание ног в тренажере', 1);
INSERT INTO public.exercises ("name", id_user) VALUES('Сведение ног в тренажере', 1);
INSERT INTO public.exercises ("name", id_user) VALUES('Разгибание ног на блочном тренажере', 1);
INSERT INTO public.exercises ("name", id_user) VALUES('Жим лежа', 1);
INSERT INTO public.exercises ("name", id_user) VALUES('Сведения в тренажере «Бабочка»', 1);
INSERT INTO public.exercises ("name", id_user) VALUES('Тяга вертикального блока', 1);
INSERT INTO public.exercises ("name", id_user) VALUES('Тяга горизонтального блока', 1);
INSERT INTO public.exercises ("name", id_user) VALUES('Жим Арнольда', 1);
INSERT INTO public.exercises ("name", id_user) VALUES('Подъем гантелей через стороны', 1);
INSERT INTO public.exercises ("name", id_user) VALUES('Поднятие штанги к подбородку', 1);
INSERT INTO public.exercises ("name", id_user) VALUES('Подъем гантелей перед собой', 1);
INSERT INTO public.exercises ("name", id_user) VALUES('Сгибание рук в кроссовере', 1);
INSERT INTO public.exercises ("name", id_user) VALUES('Разгибание рук в кроссовере', 1);
INSERT INTO public.exercises ("name", id_user) VALUES('французский жим лежа', 1);

INSERT INTO tec.roles ("name", description, active) VALUES('Админ', 'Админская роль', true);
