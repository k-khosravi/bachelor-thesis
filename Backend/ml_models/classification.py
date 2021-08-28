from util.feature_selection import open_joblib_file
from util.string_utils import StringUtils

classification_model = None

def load_classification_model():
    global classification_model
    classification_model = open_joblib_file(StringUtils.classification_model)

def classification_preds(X_test):
    preds = classification_model.predict(X_test).tolist()[0]
    return preds
    
