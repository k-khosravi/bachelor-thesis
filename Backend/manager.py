import os

from app import init_app
from ml_models.classification import load_classification_model
from ml_models.regression import load_regression_model

app = init_app()

if __name__ == "__main__":

    load_classification_model()
    load_regression_model()
    app.run(host=os.getenv('IP', '192.168.1.4'), port=int(os.getenv('PORT', 3000)), threaded=True)
