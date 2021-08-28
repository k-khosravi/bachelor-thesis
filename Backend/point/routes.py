from flask import Blueprint, request
from flask_restful import Api, Resource

from models import Point, AccessPoint
from database.db import db_session

point_app = Blueprint('point_app', __name__, url_prefix='/api/v1/fingerprint')
api = Api(point_app)

class PointAPI(Resource):

    def post(self):
        message = {'data': None, 'error': 'Check Your JSON Fileds', 'code': 400}
        data = request.get_json()
        if {'x', 'y', 'T', 'Ts', 'dateTime', 'accessPoints'} <= data.keys(): 
            x = data['x']
            y = data['y']
            total_scan_time = data['T']
            interval_time = data['Ts']
            date_time = data['dateTime']
            access_points = data['accessPoints']
            new_point = Point(x, y, total_scan_time, interval_time, date_time)
            db_session.add(new_point)
            db_session.commit()

            for ap in access_points:
                vals = list(ap.values())
                bssid = vals[0]
                rssi_list = vals[1]
                new_access_point = AccessPoint(new_point.id, bssid, rssi_list)
                db_session.add(new_access_point)
                db_session.commit()
            message['error'] = None
            message['code'] = 200
            return message, 200    

        return message, 400              

api.add_resource(PointAPI, '/points')