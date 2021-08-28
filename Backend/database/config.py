import os 

from dotenv import load_dotenv
from sqlalchemy import create_engine

# Sets the base directory path
basedir = os.path.abspath(os.path.dirname(__file__))

# loads the environment variable file
load_dotenv()

# Get the environmental variables
def get_env_variable(name):
    try:
        return os.environ[name]
    except KeyError:
        message = "Expected env variable '{}' not set.".format(name)
        raise Exception(message)

def get_connection_from_env():

    host = get_env_variable("POSTGRES_HOST")
    port = get_env_variable("POSTGRES_PORT")
    user = get_env_variable("POSTGRES_USER")
    passwd = get_env_variable("POSTGRES_PASSWORD")
    db = get_env_variable("POSTGRES_DATABASE")
    return get_engine(host, port, user, passwd, db)

def get_engine(host, port, user, passwd, db):    
    url = 'postgresql://{user}:{passwd}@{host}:{port}/{db}'.format(
        user=user, passwd=passwd, host=host, port=port, db=db)
    engine = create_engine(url, pool_size=50)
    return engine

def get_database():
    try:
        engine = get_connection_from_env()
    except IOError:
        return None, 'fail'
    return engine
