import pandas as pd
import dirs
from connect_to_db import create_connection

def load_table_from_csv(database,schema,table,dir,csv):
    #Create to the source database and load the table from the uploaded csv file
    conn = create_connection(database)
    data = pd.read_csv(dir + csv, keep_default_na=False, na_values=['_'])
    data.to_sql(table, conn, schema=schema, if_exists='replace', index=False)
    conn.commit()
    conn.close()