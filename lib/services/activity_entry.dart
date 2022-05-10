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

  Stream<LocationData> locationStream = const Stream.empty();

  startRecording() async {

    print('---------START---------');

    location = await getLocation();
    time = location?.time;

    if(locationSubscription == null){

      print('locationSubscription is null: recreating subscription');
      locationStream = getLocationStream();
      locationSubscription = locationStream.listen((event) async {
        distance += calculateDistance(location!.latitude!, location!.longitude!, event.latitude!, event.longitude!);
        location = event;

        if (time != null && event.time != null){
          duration += (event.time! - time!)/1000;
          time = event.time;
        }

        print('time: $time - lat: ${location?.latitude} - lon: ${location?.longitude} - duration: ${duration}s - distance: ${distance}m');

      });
    }
    else if(locationSubscription!.isPaused){
      print('locationSubscription is NOT null: resuming subscription');
      locationSubscription?.resume();
    }

  }

  pauseRecording(){
    print('---------PAUSE---------');
    locationSubscription?.pause();
  }

  stopRecording(){
    print('---------STOP----------');
    locationSubscription?.cancel();
    locationSubscription = null;
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

    print('lat: ${_locationData.latitude}, lon: ${_locationData.longitude}');

    return _locationData;

  }

  Stream<LocationData> getLocationStream() {

    Location location = Location();
    locationStream = location.onLocationChanged;

    return locationStream;

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