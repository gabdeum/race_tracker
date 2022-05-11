import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:race_tracker/services/activity_entry.dart';
import '../services/activity.dart';
import '../widgets/activity_card.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/carousel.dart';

class Dashboard extends StatelessWidget {

  final ActivityEntry? currentActivity;

  Dashboard({this.currentActivity, Key? key}) : super(key: key);

  final Map<String,DateTime?> personalBestTimes = {
    "marathon" : DateTime(1970, 1, 1, 2, 48, 34),
    "halfmarathon" : DateTime(1970, 1, 1, 1, 23, 10),
    "10kRun" : DateTime(1970, 1, 1, 0, 34, 45),
    "5kRun" : DateTime(1970, 1, 1, 0, 16, 25),
    "100kBike" : DateTime(1970, 1, 1, 6, 48, 34),
    "50kBike" : DateTime(1970, 1, 1, 3, 10, 22),
    "2500mSwim" : DateTime(1970, 1, 1, 1, 31, 13),
    "1000mSwim" : DateTime(1970, 1, 1, 0, 44, 10),
  };

  final List<Activity> activityHistory = [
    Activity(activityId: 'activity01', activityName: 'Afternoon run', activityType: 'run', activityDateTime: DateTime(1991, 3, 7, 23, 50), activityLocation: {"locationName" : "Versailles, FR"}, activityDistance: 13400, activityMovingTime: 4534),
    Activity(activityId: 'activity02', activityName: 'Morning bike', activityType: 'bike', activityDateTime: DateTime(1994, 11, 9, 9, 35), activityLocation: {"locationName" : "Marseille, FR"}, activityDistance: 35309, activityMovingTime: 7145),
    Activity(activityId: 'activity03', activityName: 'Noon swim', activityType: 'swim', activityDateTime: DateTime(2024, 5, 4, 12, 13), activityLocation: {"locationName" : "Brooklyn, NY"}, activityDistance: 530, activityMovingTime: 2124),
    Activity(activityId: 'activity01', activityName: 'Afternoon run', activityType: 'run', activityDateTime: DateTime(1991, 3, 7, 23, 50), activityLocation: {"locationName" : "Versailles, FR"}, activityDistance: 13400, activityMovingTime: 4534),
    Activity(activityId: 'activity02', activityName: 'Morning bike', activityType: 'bike', activityDateTime: DateTime(1994, 11, 9, 9, 35), activityLocation: {"locationName" : "Marseille, FR"}, activityDistance: 35309, activityMovingTime: 7145),
    Activity(activityId: 'activity03', activityName: 'Noon swim', activityType: 'swim', activityDateTime: DateTime(2024, 5, 4, 12, 13), activityLocation: {"locationName" : "Brooklyn, NY"}, activityDistance: 530, activityMovingTime: 2124),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: const Drawer(),
      body: Stack(alignment: AlignmentDirectional.bottomCenter,
        children: [
          Column(
            children: [
              CarouselWithIndicator(context: context, trainingTrend: 40, personalBestTimes: personalBestTimes,),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: activityHistory.length,
                    itemBuilder: (context, index) => ActivityCard(activity: activityHistory[index])
                ),
              )
            ],
          ),
          Hero(tag: 'bottomBar', child: BottomBar(dashboard: true, currentActivity: currentActivity,))
        ],
      ),
    );
  }

}