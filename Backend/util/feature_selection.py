import joblib
import pickle
import os

import numpy as np
from pathlib import Path

from util.string_utils import StringUtils

def open_pkl_file(file_path):

    base_path = Path(__file__).parent
    file_path = (base_path / file_path).resolve()
    if os.path.exists(file_path):
        file = pickle.load(open(file_path, 'rb'))
    else:
        print('No File with this Name, check File Name')
        file = None
    return file

def open_joblib_file(file_path):
    base_path = Path(__file__).parent
    file_path = (base_path / file_path).resolve()
    if os.path.exists(file_path):
        file = joblib.load(open(file_path, 'rb'))
    else:
        print('No File with this Name, check File Name')
        file = None
    return file

def get_x_test(accessPoints):
    
    trained_columns = open_joblib_file(StringUtils.columns_path)
    test_columns = list(accessPoints.keys())

    # remove extra APs that were detected during online phase, but were not used for training the model
    accessPoints = drop_columns(trained_columns, test_columns, accessPoints)

    # add APs that were used for training the model, 
    # but were not detected during online phase and perform imputation on them       
    accessPoints = constant_imputation(trained_columns, test_columns, accessPoints)

    rssi_list = list(dict(sorted(accessPoints.items())).values())
    X_test = np.array(rssi_list).reshape(1, -1)
    return X_test

def drop_columns(trained_columns, test_columns, accessPoints):

    for column in test_columns:
        if column not in trained_columns:
            accessPoints.pop(column)
    return accessPoints        

def constant_imputation(trained_columns, test_columns, accessPoints):

    for column in trained_columns:
        if column not in test_columns:
            accessPoints[column] = -100
    return accessPoints        
