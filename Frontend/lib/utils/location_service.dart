import 'package:location/location.dart';

class LocationService {
  final Location location = Location();

  Future<PermissionStatus> checkPermissions() async =>
      await location.hasPermission();

  Future<void> requestPermission() async => await location.requestPermission();

  Future<bool> checkService() async => await location.serviceEnabled();

  Future<void> requestService() async => await location.requestService();
}
