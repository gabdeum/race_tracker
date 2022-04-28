class Activity {

  final String activityId; // used to retrieve route details in DB, images in storage...
  final String activityName;
  final String activityType; // run, bike or swim
  final DateTime activityDateTime; // DateTime from the start of the activity
  final Map<String,dynamic> activityLocation; // Map of location details (lat, lon, place name like "Brooklyn, NY")
  final int activityDistance; // distance in meters
  final int activityMovingTime; // elapsed time in seconds

  Activity({required this.activityId, required this.activityName, required this.activityType, required this.activityDateTime,
    required this.activityLocation, required this.activityDistance, required this.activityMovingTime});

}