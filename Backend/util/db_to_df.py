from datetime import datetime

import pandas as pd

from database.db import engine
from models import AccessPoint

def sql_table_to_df():    
    df = pd.read_sql_table('access_points', engine)
    access_points = AccessPoint.query.all()
    df = modify_df(df, access_points)
    return df

# Reshape dataframe in which every bssid is a column and every value in rssi_list is a row
def modify_df(df, access_points):
    index = ['x', 'y', 'date_time']
    x_list = []
    y_list = []
    datetime_list = []
    for ap in access_points:
        x = ap.point.x
        x_list.append(x)
        y = ap.point.y
        y_list.append(y)
        datetime = ap.point.date_time
        datetime_list.append(datetime)

    df = df.assign(x=x_list, y=y_list, date_time=datetime_list)  
    df.drop(['id', 'point_id'], axis=1, inplace=True)
    df = pd.pivot_table(
        df, 
        index=index, 
        values='RSSIs', 
        columns='BSSID', 
        aggfunc='first').reset_index().rename_axis(None, axis=1)
    df = df.set_index(index).apply(lambda x: x.apply(pd.Series).stack()).reset_index().drop('level_' + str(len(index)), 1)     
    return df

def export_df_to_csv(df, indicator):
    current_date_and_time = datetime.now().strftime('%Y_%m_%d-%H_%M_%S') 
    extension = ".csv"
    file_name = current_date_and_time + indicator + extension
    df.to_csv(f'/Users/macbookpro/RSSI_Data/CSV/{file_name}', encoding='utf-8')    
