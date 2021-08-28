class Point {
  int xCoordinate;
  int yCoordinate;
  int totalScanTime;
  int intervalTime;
  String dateTime;
  List<AccessPoint> accessPoints;

  Point(
      {required this.xCoordinate,
      required this.yCoordinate,
      required this.totalScanTime,
      required this.intervalTime,
      required this.dateTime,
      required this.accessPoints});

  Map toJson() {
    return {
      'x': xCoordinate,
      'y': yCoordinate,
      'T': totalScanTime,
      'Ts': intervalTime,
      'dateTime': dateTime,
      'accessPoints': accessPoints
    };
  }
}

class AccessPoint {
  String bssid;
  List<int> rssiList;

  AccessPoint({required this.bssid, required this.rssiList});

  Map toJson() => {'BSSID': bssid, 'RSSIs': rssiList};
}
