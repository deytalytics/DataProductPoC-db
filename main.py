#import directory path definitions
import dirs

#import the library which creates a database
from cr_db import cr_db

#Create the databases if the cr_db_flag environment variable is set
cr_db(dirs.metadata_db)
cr_db(dirs.dataset_db)
cr_db(dirs.dataset_auth_db)
