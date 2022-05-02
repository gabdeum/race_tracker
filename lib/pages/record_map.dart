import 'package:flutter/material.dart';
import 'package:race_tracker/services/DisplayData.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../services/activity.dart';

class RecordMap extends StatelessWidget {
  const RecordMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Activity currentActivity = Activity(activityId: 'activity01', activityName: 'Afternoon run', activityType: 'run', activityDateTime: DateTime(1991, 3, 7, 23, 50), activityLocation: {"locationName" : "Versailles, FR"}, activityDistance: 13400, activityMovingTime: 4534);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Record'),
      ),
      body: Stack(
        children: [
          SlidingUpPanel(
            parallaxOffset: 0.5,
            minHeight: 250,
            maxHeight: 490,
            parallaxEnabled: true,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
            panel: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0.1 * MediaQuery.of(context).size.width),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 120,
                  child: Stack(
                    children: [
                      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          DisplayData(title: 'Distance', dataStr: currentActivity.activityType != 'swim' ?
                          '${((currentActivity.activityDistance) / 1000).toStringAsFixed(2)} K' : '${currentActivity.activityDistance.toString()} m',
                            titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                          DisplayData(title: 'Time', dataStr: formatMovingTime(currentActivity.activityMovingTime),
                            titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                        ],),
                        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          DisplayData(title: 'Avg Pace', dataStr: formatPace(currentActivity.activityMovingTime, currentActivity.activityDistance),
                            titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                          DisplayData(title: 'Pace', dataStr: formatPace(currentActivity.activityMovingTime, currentActivity.activityDistance),
                            titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                        ],)
                      ],),
                      Positioned(top: 60, left: 0, right: 0 ,child: Container(height: 1,color: const Color.fromRGBO(0, 0, 0, 0.3),)),
                      Positioned(top: 0, bottom: 0, left: MediaQuery.of(context).size.width * 0.4 ,child: Container(width: 1,color: const Color.fromRGBO(0, 0, 0, 0.3),)),
                    ],
                  ),
                ),
              ),
            ),
            body: Image.asset('assets/placeholders/record_map.png', fit: BoxFit.fitWidth,alignment: Alignment.topCenter,)
          ),
          Positioned(bottom: 0,child: Image.asset('assets/placeholders/bottom_bar_record.png', width: MediaQuery.of(context).size.width, fit: BoxFit.fitWidth,)),
        ],
      ),
    );
  }

}
