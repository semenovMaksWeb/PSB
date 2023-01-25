INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Создавать/редактировать право', 'right_update', 'Создавать/редактировать право', true, '2022-12-05 21:33:56.086');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Просмотр прав', 'right_get', 'Просмотр прав', true, '2022-12-05 21:33:56.104');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Создавать/редактировать   ролей', 'roles_update', 'Создавать/редактировать   ролей', true, '2022-12-05 21:33:56.104');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Просмотр ролей', 'roles_get', 'Просмотр ролей', true, '2022-12-05 21:33:56.105');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Создавать/редактировать связи роли с правами', 'right-roles_update', 'Создавать/редактировать связи роли с правами', true, '2022-12-05 21:33:56.105');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Просмотр связей ролей и прав', 'right-roles_get', 'Просмотр связей ролей и прав', true, '2022-12-05 21:33:56.106');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Создавать/редактировать связи роли с пользователями', 'roles-user_update', 'Создавать/редактировать связи роли с пользователями', true, '2022-12-05 21:33:56.107');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Просмотр связей ролей и пользователей', 'roles-user_get', 'Просмотр связей ролей и пользователей', true, '2022-12-05 21:33:56.107');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Просмотр имен файлов конфигов', 'names-file-config-bec_get', 'Право разрешающие получать список имен файлов конфигурации для обработки бэка команд', true, '2022-12-25 12:42:30.124');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Открыть проект конструктор конфигурации команд', 'constructor-command_open', 'Открыть проект конструктор конфигурации команд', true, '2022-12-25 12:44:34.829');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Просмотр конфигурации команд', 'config-command_get', 'Просмотр json конфига команд выполняющиеся на стороне бэка bec', true, '2022-12-25 12:46:38.765');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Создание нового файла команд', 'config-command_create', 'Создать новый файл конфига команд выполняющиеся на стороне бэка bec', true, '2022-12-25 12:48:11.003');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Изменения файлов конфигурации команд', 'config-command_update', 'Изменения файлов конфигурации команд', true, '2022-12-25 12:51:42.303');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Удаления файлов конфигурации команд', 'config-command_delete', 'Удаления файлов конфигурации команд', true, '2022-12-25 12:52:07.082');
INSERT INTO tec."right" ("name", const_name, description, active, "date") VALUES('Запуск api команд с передачей конфига json', 'bec-command-test_start', 'Запуск api команд с передачей конфига json', true, '2022-12-25 12:58:33.303');

INSERT INTO tec.roles ("name", description, active, const_name) VALUES('Админ', 'Админская роль', true, 'admin');
INSERT INTO tec.roles ("name", description, active, const_name) VALUES('Конструктор команд', 'Конструктор команд, может работать с конфигурациями команд без ограничении', true, 'admin_constructor_command');
INSERT INTO tec.roles ("name", description, active, const_name) VALUES('Аналитик команд', 'Может просмотривать команды, нет прав на изменения', true, 'analitik_command');


select * from tec.right_roles_const_name_create('admin', 'right_update');
select * from tec.right_roles_const_name_create('admin', 'right_get');
select * from tec.right_roles_const_name_create('admin', 'roles_update');
select * from tec.right_roles_const_name_create('admin', 'roles_get');
select * from tec.right_roles_const_name_create('admin', 'right-roles_update');
select * from tec.right_roles_const_name_create('admin', 'right-roles_get');
select * from tec.right_roles_const_name_create('admin', 'roles-user_get');
select * from tec.right_roles_const_name_create('admin', 'roles-user_update');
select * from tec.right_roles_const_name_create('admin', 'constructor-command_open');
select * from tec.right_roles_const_name_create('admin', 'config-command_get');
select * from tec.right_roles_const_name_create('admin', 'config-command_create');
select * from tec.right_roles_const_name_create('admin', 'names-file-config-bec_get');
select * from tec.right_roles_const_name_create('admin', 'config-command_update');
select * from tec.right_roles_const_name_create('admin', 'config-command_delete');
select * from tec.right_roles_const_name_create('admin', 'bec-command-test_start');

select * from tec.right_roles_const_name_create('admin_constructor_command', 'constructor-command_open');
select * from tec.right_roles_const_name_create('admin_constructor_command', 'names-file-config-bec_get');
select * from tec.right_roles_const_name_create('admin_constructor_command', 'config-command_get');
select * from tec.right_roles_const_name_create('admin_constructor_command', 'config-command_create');
select * from tec.right_roles_const_name_create('admin_constructor_command', 'config-command_update');
select * from tec.right_roles_const_name_create('admin_constructor_command', 'bec-command-test_start');

select * from tec.right_roles_const_name_create('analitik_command', 'constructor-command_open');
select * from tec.right_roles_const_name_create('analitik_command', 'names-file-config-bec_get');
select * from tec.right_roles_const_name_create('analitik_command', 'config-command_get');

INSERT INTO car.car_class ("name", description) VALUES('A', 'Мини-автомобили');
INSERT INTO car.car_class ("name", description) VALUES('B', 'Маленькие автомобили');
INSERT INTO car.car_class ("name", description) VALUES('C', 'Среднеразмерные автомобили');
INSERT INTO car.car_class ("name", description) VALUES('D', 'Полноразмерные автомобили');
INSERT INTO car.car_class ("name", description) VALUES('E', 'Автомобили бизнес-класса');
INSERT INTO car.car_class ("name", description) VALUES('F', 'Представительские автомобили');
INSERT INTO car.car_class ("name", description) VALUES('S', 'Спортивные купе');
INSERT INTO car.car_class ("name", description) VALUES('M', 'Минивэны и коммерческие автомобили');
INSERT INTO car.car_class ("name", description) VALUES('J', 'Кроссоверы и внедорожники');