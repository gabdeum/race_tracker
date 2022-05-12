import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:race_tracker/services/display_data.dart';
import 'package:race_tracker/services/activity_entry.dart';
import 'package:race_tracker/services/colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../services/activity.dart';
import '../services/bottom_bar_record.dart';

class RecordMap extends StatefulWidget {

  RecordMap({this.currentActivity, Key? key}) : super(key: key);

  ActivityEntry? currentActivity;

  @override
  State<RecordMap> createState() => _RecordMapState();
}

class _RecordMapState extends State<RecordMap> {

  @override
  void initState() {
    widget.currentActivity == null ? widget.currentActivity = ActivityEntry(onLocationChange: (){setState(() {});}) : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Activity activityPlaceholder = Activity(activityId: 'activity01', activityName: 'Afternoon run', activityType: 'run', activityDateTime: DateTime(1991, 3, 7, 23, 50), activityLocation: {"locationName" : "Versailles, FR"}, activityDistance: 13400, activityMovingTime: 4534);
    final widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Text('Back', style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: primaryTextColor)) ,),
          onPressed: () => Navigator.of(context).pop(widget.currentActivity)
        ),
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
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0.1 * widthScreen),
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 120,
                  child: Stack(
                    children: [
                      Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          DisplayData(title: 'Distance', dataStr: (widget.currentActivity?.activityType ?? 'run') != 'swim' ?
                          '${((widget.currentActivity?.distance ?? 0) / 1000).toStringAsFixed(2)} K' : '${(widget.currentActivity?.distance.round() ?? 0).toString()} m',
                            titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                          SizedBox(width: 0.1 * widthScreen,),
                          DisplayData(title: 'Time', dataStr: formatMovingTime(widget.currentActivity?.duration.round() ?? 0),
                            titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                        ],),
                        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          DisplayData(title: 'Avg Pace', dataStr: formatPace(widget.currentActivity?.duration.round() ?? 0, widget.currentActivity?.distance.round() ?? 0),
                            titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                          SizedBox(width: 0.1 * widthScreen,),
                          DisplayData(title: 'Pace', dataStr: formatPace(widget.currentActivity?.duration.round() ?? 0, widget.currentActivity?.distance.round() ?? 0),
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
            body: Image.asset('assets/placeholders/record_map.png', fit: BoxFit.fitWidth,alignment: Alignment.topCenter,)
          ),
          Positioned(bottom: 0,child: BottomBarRecord(widthScreen: widthScreen, currentActivity: widget.currentActivity,)),
        ],
      ),
    );
  }
}