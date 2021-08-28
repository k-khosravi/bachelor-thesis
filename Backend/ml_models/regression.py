from util.feature_selection import open_joblib_file
from util.string_utils import StringUtils

regression_model = None

def load_regression_model():
    global regression_model
    regression_model = open_joblib_file(StringUtils.regression_model)

def regression_preds(X_test):
    preds = regression_model.predict(X_test).tolist()[0]
    return preds
