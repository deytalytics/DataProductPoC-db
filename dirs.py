#define the database & schema names
metadata_db="data_product_metadata"
dataset_auth_db="dataset_auth"
dataset_db="dataset"
src_data_schema="src_data"
target_data_schema="target_data"

#define locations of data & metadata
root_dir="./"
ddl_dir= root_dir+"ddl/"
metadata_dir = ddl_dir + "data_product_metadata/"

src_dir= root_dir+"input-data-port/"
src_data_dir = src_dir+"data/"

transformation_dir = root_dir+"transformation/"
transformation_data_dir = transformation_dir+"data/"
transformation_sql_dir = transformation_dir+"sql/"

target_dir= root_dir+"output-data-port/"
target_data_dir = target_dir+"data/"
template_dir = target_dir+"templates/"
target_metadata_dir = target_dir+"metadata/"
target_schema_dir = target_metadata_dir+"schema/"
docs_dir = target_metadata_dir+"docs/"