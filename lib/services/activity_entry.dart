import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:location/location.dart';

class ActivityEntry {

  int time = DateTime.now().millisecondsSinceEpoch;
  LocationData? location;
  String activityType = 'run'; // run, bike or swim
  double distance = 0; // distance in meters
  int duration = 0; //elapsed time in seconds
  StreamSubscription? locationSubscription;
  bool isCancelled = true;
  void Function() onLocationChanged;
  Stream<LocationData> locationStream;

  ActivityEntry({required this.onLocationChanged, required this.locationStream});

  Future startRecording() async {

    print('---------START---------');

    time = DateTime.now().millisecondsSinceEpoch;
    location = await locationStream.first;

    if(locationSubscription == null || isCancelled){

      print('locationSubscription is null or cancelled: recreating subscription');

      isCancelled = false;
      locationSubscription = locationStream.listen((event) {

        if (location != null){

          distance += calculateDistance(location!.latitude!, location!.longitude!, event.latitude!, event.longitude!);
          location = event;

          duration += ((DateTime.now().millisecondsSinceEpoch - time)/1000).round();
          time = DateTime.now().millisecondsSinceEpoch;

          onLocationChanged();

          print('lat: ${location?.latitude} - lon: ${location?.longitude} - dur: ${duration}s - dist: ${distance}m - acc: ${location?.accuracy}');
        }
        else {
          location = event;
        }

      });

    }

    else{
      print('locationSubscription not cancelled: doing nothing');
    }

    return null;

  }

  Future? stopRecording() {
    print('---------STOP----------');
    isCancelled = true;
    return locationSubscription?.cancel();
  }

  Future? finishRecording() {
    print('---------FINISH--------');
    distance = 0;
    duration = 0;
    return null;
  }

  Future<LocationData> getLocation() async {

    Location location = Location();
    LocationData _locationData;

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