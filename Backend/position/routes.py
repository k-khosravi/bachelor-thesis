from flask import Blueprint, request
from flask_restful import Api, Resource

from ml_models.classification import classification_preds
from ml_models.regression import regression_preds
from util.feature_selection import get_x_test

position_app = Blueprint('position_app', __name__, url_prefix='/api/v1/fingerprint')
api = Api(position_app)

class PositionAPI(Resource):

    def post(self):
        message = {'data': None, 'error': 'Invalid JSON', 'code': 400}
        access_points = request.get_json()
        if access_points is not None:
            
            X_test = get_x_test(access_points)
            zone_number = classification_preds(X_test)
            x_coordinate = regression_preds(X_test)[0]
            y_coordinate = regression_preds(X_test)[1]
            position_dict = {
                "zoneNumber": zone_number,
                "X": round(x_coordinate, 1),
                "Y": round(y_coordinate, 1),
            }
            message['data'] = position_dict
            message['error'] = None
            message['code'] = 200
            return message, 200            
        
        return message, 400
                
api.add_resource(PositionAPI, '/position')