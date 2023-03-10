import pandas as pd
import dirs,os
from connect_to_db import create_connection
from load_table_from_csv import load_table_from_csv
from sqlalchemy import text

def cr_db(dbname):
    # Connect to the specified database
    conn = create_connection(dbname)

    #Build all of the tables
    ddl_file=dirs.ddl_dir + dbname + '/cr_db.ddl'
    print(ddl_file)
    with open(ddl_file, 'r') as file:
        ddl = ''
        #Loop through each line in the file
        for line in file:
            #Add it to the DDL
            ddl += line
            #If the line has a ; in it then we have a statement that can be executed
            if ';' in line:
                # Execute the DDL
                print(ddl)
                conn.execute(text(ddl))
                #Empty the ddl string so that the next ddl command can be processed
                ddl = ''
        conn.commit()

    #Lets handle the processing of the data , and then abstract them using data pipeline sql,
    #write to a target dataset file and then load into the target dataset table
    if dbname==dirs.dataset_db:

        #Populate the source datasets from CSV files
        mypath=dirs.src_data_dir
        src_files = [f for f in os.listdir(mypath) if os.path.isfile(os.path.join(mypath, f))]
        for file in src_files:
            data = pd.read_csv(dirs.src_data_dir+file)
            data.to_sql(file.split(".")[0], conn, schema="src_data", if_exists='replace', index=False)

        conn.commit()
        conn.close()

        # Find the target dataset names in the metadata database
        conn = create_connection(dirs.metadata_db)
        target_datasets=conn.execute(text("SELECT d.name, v.version from target_datasets d, target_dataset_versions v where v.ds_id = d.id"))

        #Load the target dataset table from the target dataset files
        for row in target_datasets:
            tablename='%s-%s'%(row[0],row[1])
            csvfile='%s.csv'%tablename
            load_table_from_csv(dbname, dirs.target_data_schema, tablename, dirs.target_data_dir, csvfile)
        conn.commit()
        conn.close()

    #Else if we are creating the metadata tables then lets populate the schema table from a CSV file (could be exported from PowerDesigner)
    elif dbname==dirs.metadata_db:
        data = pd.read_csv(dirs.metadata_dir + 'data_products.csv')
        data.to_sql('data_products', conn, if_exists='replace', index=False)
        data = pd.read_csv(dirs.metadata_dir + 'data_product_x_owners.csv')
        data.to_sql('data_product_x_owners', conn, if_exists='replace', index=False)
        data = pd.read_csv(dirs.metadata_dir + 'data_product_owners.csv')
        data.to_sql('data_product_owners', conn, if_exists='replace', index=False)
        data = pd.read_csv(dirs.metadata_dir + 'data_product_data_sources.csv')
        data.to_sql('data_product_data_sources', conn, if_exists='replace', index=False)
        data = pd.read_csv(dirs.metadata_dir + 'data_source_data_sharing_agreements.csv')
        data.to_sql('data_source_data_sharing_agreements', conn, if_exists='replace', index=False)
        data = pd.read_csv(dirs.metadata_dir + 'src_datasets.csv')
        data.to_sql('source_datasets', conn, if_exists='replace', index=False)
        data = pd.read_csv(dirs.metadata_dir + 'src_dataset_versions.csv')
        data.to_sql('source_dataset_versions', conn, if_exists='replace', index=False)
        data = pd.read_csv(dirs.metadata_dir + 'schema.csv')
        data.to_sql('dp_schemata', conn,if_exists='replace', index=False)
        conn.commit()
    # Close the connection
    conn.close()