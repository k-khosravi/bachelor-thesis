from sqlalchemy import Column, String, Integer, ForeignKey
from sqlalchemy.dialects import postgresql
from sqlalchemy.orm import relationship

from database.db import Base

class Point(Base):

    __tablename__ = 'reference_points'
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    x = Column('x', String)
    y = Column('y', String)
    total_scan_time = Column('T', Integer)
    interval_time = Column('Ts', Integer)
    date_time = Column('date_time', String)
    accesspoints = relationship('AccessPoint', backref='point')

    def __init__(self, x, y, total_scan_time, interval_time, date_time):
        self.x = x
        self.y = y
        self.total_scan_time = total_scan_time
        self.interval_time = interval_time
        self.date_time = date_time
    
    def __repr__(self):
        return f"<Point's coordination is ({self.x} {self.y})>"


class AccessPoint(Base):

    __tablename__ = 'access_points'

    id = Column(Integer, primary_key=True, autoincrement=True)
    point_id = Column(Integer, ForeignKey('reference_points.id'), nullable=False)
    BSSID = Column('BSSID', String)
    rssi_list = Column('RSSIs', postgresql.ARRAY(Integer, dimensions=1))

    def __init__(self, point_id, BSSID, rssi_list):
        self.point_id = point_id
        self.BSSID = BSSID
        self.rssi_list = rssi_list
        
    def __repr__(self):
        return f"<The AccessPoint's features are:  {self.BSSID}:{self.RSSIs}>"
