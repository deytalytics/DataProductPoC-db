    CREATE TABLE if not exists data_products
    (id serial,
     name varchar,
     root_uri varchar,
     version varchar,
     description varchar,
     security_classification_id int,
     deprecation_date date,
     created_ts timestamp,
     last_modified_ts timestamp);

    create unique index if not exists data_products_ix on data_products(name,version);

    CREATE TABLE if not exists data_product_tags
    (id serial,
     dp_id int,
     tag varchar);

    CREATE TABLE if not exists data_product_owners
    (id serial,
     name varchar,
     contact_email varchar);

    CREATE TABLE if not exists data_product_x_owners
    (id serial,
     dp_id int,
     dpo_id int);

    CREATE TABLE if not exists security_classifications
    (id serial,
     name varchar);

    CREATE TABLE if not exists data_product_data_sources
    (id serial,
     dp_id int,
     name varchar,
     created_ts timestamp,
     last_modified_ts timestamp);

    CREATE TABLE if not exists data_source_data_sharing_agreements
    (id serial,
     data_source_id int,
     name varchar,
     url_suffix varchar,
     created_ts timestamp,
     last_modified_ts timestamp);

    CREATE TABLE if not exists source_datasets
    (id serial,
     name varchar,
     created_ts timestamp,
     last_modified_ts timestamp);

    create unique index if not exists source_datasets_ix on source_datasets(name);

    CREATE TABLE if not exists source_dataset_versions
    (id serial primary key,
     ds_id int ,
     version varchar,
     created_ts timestamp,
     last_modified_ts timestamp);

    create unique index if not exists source_dataset_versions_ix on source_dataset_versions(ds_id, version);

    CREATE TABLE if not exists target_datasets
    (id serial,
     name varchar,
     created_ts timestamp,
     last_modified_ts timestamp);

    create unique index if not exists target_datasets_ix on target_datasets(name);

    CREATE TABLE if not exists target_dataset_versions
    (id serial,
     ds_id int,
     version varchar,
     created_ts timestamp,
     last_modified_ts timestamp);

    create unique index  if not exists  target_dataset_versions_ix on target_dataset_versions(ds_id,version);

    CREATE TABLE if not exists dp_schemata
    (ds_id int,
     ds_version varchar,
     field_name varchar,
     field_description varchar,
     field_datatype varchar,
     created_ts timestamp default current_timestamp,
     last_modified_ts timestamp default current_timestamp);

    create unique index if not exists  dp_schemata_ix on dp_schemata(ds_id,ds_version,field_name);

