import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../services/activity_entry.dart';
import '../services/display_data.dart';
import 'location_map.dart';

class RecordSlidingUpPanel extends StatelessWidget {
  const RecordSlidingUpPanel({
    Key? key,
    required this.widthScreen,
    required this.currentActivity,
    required this.locationStream,
    this.onResume,
    this.onStop,
    this.onStart,
    this.onFinish,
  }) : super(key: key);

  final double widthScreen;
  final ActivityEntry? currentActivity;
  final Stream<LocationData> locationStream;
  final VoidCallback? onResume;
  final VoidCallback? onStop;
  final VoidCallback? onStart;
  final VoidCallback? onFinish;

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      parallaxOffset: 0.5,
      minHeight: 250,
      maxHeight: 490,
      parallaxEnabled: true,
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      panel: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0.1 * widthScreen),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: 120,
            child: Stack(
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    DisplayData(title: 'Distance', dataStr: formatDistance(currentActivity),
                      titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                    SizedBox(width: 0.1 * widthScreen,),
                    DisplayData(title: 'Time', dataStr: formatMovingTime(currentActivity?.duration ?? 0),
                      titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                  ],),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    DisplayData(title: 'Avg Pace', dataStr: formatPace(currentActivity?.duration ?? 0, currentActivity?.distance.round() ?? 0),
                      titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                    SizedBox(width: 0.1 * widthScreen,),
                    DisplayData(title: 'Current Pace', dataStr: formatPace(currentActivity?.duration ?? 0, currentActivity?.distance.round() ?? 0),
                      titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                  ],)
                ],),
                Positioned(top: 60, left: 0, right: 0 ,child: Container(height: 1,color: const Color.fromRGBO(0, 0, 0, 0.3),)),
                Positioned(top: 0, bottom: 0, left: widthScreen * 0.4 ,child: Container(width: 1,color: const Color.fromRGBO(0, 0, 0, 0.3),)),
              ],
            ),
          ),
        ),
      ),
      body: LocationMap(locationStream: locationStream,),
      // body: SizedBox(height: 200, child: Image.asset('assets/placeholders/record_map.png', fit: BoxFit.fitWidth,alignment: Alignment.topCenter,)),
    );
  }
}