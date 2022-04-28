import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../services/activity.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/carousel.dart';
import '../services/colors.dart';

class Dashboard extends StatelessWidget {

  Dashboard({Key? key}) : super(key: key);

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
    Activity(activityId: 'activity01', activityName: 'Afternoon run', activityType: 'run', activityDateTime: DateTime(1991, 3, 7, 23, 50), activityLocation: {"locationName" : "Versailles, FR"}, activityDistance: 13400, activityMovingTime: 6456),
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
      bottomNavigationBar: const BottomBar(),
      body: Column(
        children: [
          CarouselWithIndicator(context: context, trainingTrend: 40, personalBestTimes: personalBestTimes,),
          const SizedBox(height: 10,),
          Container(
            height: 300,
            decoration: const BoxDecoration(
              color: primaryTextColor,
              boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 4.0, spreadRadius: 0.0, offset: Offset(0, 4.0),)],
            ),
            child: Column(children: [
              const SizedBox(height: 5,),
              Row(crossAxisAlignment: CrossAxisAlignment.center ,children: [
                const SizedBox(width: 10,),
                SvgPicture.asset('assets/custom_icons/${activityHistory[0].activityType}_icon.svg', width: 40,),
                const SizedBox(width: 10,),
                Text(activityHistory[0].activityName, style: Theme.of(context).textTheme.titleMedium,),
                const Expanded(child: SizedBox(height: 40,)),
                Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
                    Text('Wednesday, September 28, 2022', style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,),
                    Text('9:35 AM • Brooklyn, NY', style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.end,)
                  ],),
                const SizedBox(width: 15,),
              ],),
              Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  
                ],)),
              Image.asset('assets/placeholders/routeMap.png', width: MediaQuery.of(context).size.width, height: 190, fit: BoxFit.cover,)
            ],),
          ),
        ],
      )
    );
  }
}