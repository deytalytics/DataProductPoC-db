    CREATE TABLE if not exists data_products
    (id serial,
     name varchar,
     version varchar,
     created_ts timestamp,
     last_modified_ts timestamp);

    create unique index data_products_ix on data_products(name,version);

    CREATE TABLE if not exists source_datasets
    (id serial,
     name varchar,
     created_ts timestamp,
     last_modified_ts timestamp);

    create unique index source_datasets_ix on source_datasets(name);

    CREATE TABLE if not exists source_dataset_versions
    (id serial primary key,
     ds_id int ,
     version varchar,
     created_ts timestamp,
     last_modified_ts timestamp);

    create unique index source_dataset_versions_ix on source_dataset_versions(ds_id, version);

    CREATE TABLE if not exists target_datasets
    (id serial,
     name varchar,
     created_ts timestamp,
     last_modified_ts timestamp);

    create unique index target_datasets_ix on target_datasets(name);

    CREATE TABLE if not exists target_dataset_versions
    (id serial,
     ds_id int,
     version varchar,
     created_ts timestamp,
     last_modified_ts timestamp);

    create unique index target_dataset_versions_ix on target_dataset_versions(ds_id,version);

    CREATE TABLE if not exists dp_schemata
    (ds_id int,
     ds_version varchar,
     field_name varchar,
     field_description varchar,
     field_datatype varchar,
     created_ts timestamp default current_timestamp,
     last_modified_ts timestamp default current_timestamp);

    create unique index dp_schemata_ix on dp_schemata(ds_id,ds_version,field_name);

    CREATE TABLE if not exists dp_docs
    (dp_id int,
     description varchar,
     data_sharing_agreement_url varchar,
     license_info_url varchar,
     terms_of_service_url varchar,
     contact_email varchar,
     created_ts timestamp default current_timestamp,
     last_modified_ts timestamp default current_timestamp);

    create unique index dp_docs_ix on dp_docs(dp_id);
