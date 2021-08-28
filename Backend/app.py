from flask import Flask

from database.db import init_db, shutdown_session
from point.routes import point_app
from position.routes import position_app

def init_app():
    app = Flask(__name__)

    if app.config["ENV"] == "production":
        app.config.from_object("config.ProductionConfig")
    else:
        app.config.from_object("config.DevelopmentConfig")
    
    init_db() 

    with app.app_context():
        app.register_blueprint(point_app)
        app.register_blueprint(position_app)

    app.teardown_appcontext(shutdown_session)
    return app