import 'dart:async';
import 'dart:math';
import 'package:location/location.dart';

class Activity {

  final String activityId; // used to retrieve route details in DB, images in storage...
  final String activityName;
  String activityType; // run, bike or swim
  final DateTime activityDateTime; // DateTime from the start of the activity
  final Map<String,dynamic> activityLocation; // Map of location details (lat, lon, place name like "Brooklyn, NY")
  int activityDistance; // distance in meters
  int activityMovingTime; // elapsed time in seconds

  Activity({required this.activityId, required this.activityName, required this.activityType, required this.activityDateTime,
    required this.activityLocation, this.activityDistance = 0, required this.activityMovingTime});

}