    CREATE TABLE if not exists roles
    (id int,
     rolename varchar,
     created_ts timestamp,
     last_modified_ts timestamp);

    CREATE TABLE if not exists users
    (id int,
     username varchar,
     created_ts timestamp,
     last_modified_ts timestamp);

    CREATE TABLE if not exists user_roles
    (role_id int,
     user_id int,
     created_ts timestamp,
     last_modified_ts timestamp);

    CREATE TABLE if not exists ds_role_permissions
    (dataset_id int,
     role_id int,
     permitted_flag boolean,
     created_ts timestamp,
     last_modified_ts timestamp);

    CREATE TABLE if not exists passwords
    (user_id int,
     password varchar,
     created_ts timestamp,
     last_modified_ts timestamp);

    -- Note: These authorisation type tables will be handled by Shell's Authorisation system, once identified
    insert into roles values (1,'Administrator', current_timestamp, current_timestamp);
    insert into roles values (2,'Countries Admin', current_timestamp, current_timestamp);
    insert into roles values (3,'Countries Read-Only', current_timestamp, current_timestamp);
    insert into users values (1,'Mary', current_timestamp, current_timestamp);
    insert into users values (2,'R2D2', current_timestamp, current_timestamp);
    insert into user_roles values(3,1, current_timestamp, current_timestamp);
    insert into user_roles values(1,2, current_timestamp, current_timestamp);
    insert into ds_role_permissions values (1,3,True, current_timestamp, current_timestamp);
    insert into ds_role_permissions values (2,3,True, current_timestamp, current_timestamp);
    insert into ds_role_permissions values (3,3,True, current_timestamp, current_timestamp);

    -- Note: These authentication type tables will be handled by Shell's Authentication system, once identified
    insert into passwords values (1,'f15c16b99f82d8201767d3a841ff40849c8a1b812ffbfd2e393d2b6aa6682a6e', current_timestamp, current_timestamp);
    insert into passwords values (2,'f15c16b99f82d8201767d3a841ff40849c8a1b812ffbfd2e393d2b6aa6682a6e', current_timestamp, current_timestamp);
