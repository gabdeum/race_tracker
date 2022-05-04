import 'dart:async';
import 'dart:math';
import 'package:location/location.dart';

class ActivityEntry {

  double? time;
  LocationData? location;
  String activityType = 'run'; // run, bike or swim
  double distance = 0; // distance in meters
  double duration = 0; //elapsed time in seconds
  StreamSubscription? locationSubscription;

  ActivityEntry();

  startRecording() async {

    print('---------START---------');

    Stream<LocationData>? locationStream = await getLocationStream();
    location = await getLocation();
    time = location?.time;

    locationSubscription = locationStream?.listen((event) async {

      distance += calculateDistance(location!.latitude!, location!.longitude!, event.latitude!, event.longitude!);
      location = event;

      if (time != null && event.time != null){
        duration += (event.time! - time!)/1000;
        time = event.time;
      }

      print('time: $time - lat: ${location?.latitude} - lon: ${location?.longitude} - duration: ${duration}s - distance: ${distance}m');

    });

  }

  pauseRecording(){
    locationSubscription?.pause();
    print('---------PAUSE---------');
    print('time: $time - duration: $duration - distance: $distance');
  }

  stopRecording(){
    print('---------STOP----------');
    locationSubscription?.cancel();
  }

  Future<LocationData> getLocation() async {

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    Location location = Location();
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('Location service not enabled');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Location denied by user');
      }
    }

    _locationData = await location.getLocation();

    return _locationData;

  }

  Future<Stream<LocationData>?> getLocationStream() async {

    Location location = Location();
    Stream<LocationData>? _locationStream;
    _locationStream = location.onLocationChanged;

    return _locationStream;

  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a)) * 1000;
  }


}