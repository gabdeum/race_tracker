import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:race_tracker/services/DisplayData.dart';
import 'package:race_tracker/services/activity_entry.dart';
import 'package:race_tracker/services/colors.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../services/activity.dart';
import 'dashboard.dart';

class RecordMap extends StatefulWidget {

  RecordMap({this.currentActivity, Key? key}) : super(key: key);

  ActivityEntry? currentActivity;

  @override
  State<RecordMap> createState() => _RecordMapState();
}

class _RecordMapState extends State<RecordMap> {

  @override
  void initState() {
    widget.currentActivity == null ? widget.currentActivity = ActivityEntry() : null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    widget.currentActivity?.startRecording();

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
                          DisplayData(title: 'Distance', dataStr: activityPlaceholder.activityType != 'swim' ?
                          '${((activityPlaceholder.activityDistance) / 1000).toStringAsFixed(2)} K' : '${activityPlaceholder.activityDistance.toString()} m',
                            titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                          SizedBox(width: 0.1 * widthScreen,),
                          DisplayData(title: 'Time', dataStr: formatMovingTime(activityPlaceholder.activityMovingTime),
                            titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                        ],),
                        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          DisplayData(title: 'Avg Pace', dataStr: formatPace(activityPlaceholder.activityMovingTime, activityPlaceholder.activityDistance),
                            titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                          SizedBox(width: 0.1 * widthScreen,),
                          DisplayData(title: 'Pace', dataStr: formatPace(activityPlaceholder.activityMovingTime, activityPlaceholder.activityDistance),
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

class BottomBarRecord extends StatefulWidget {
  const BottomBarRecord({
    Key? key,
    required this.widthScreen,
    required this.currentActivity
  }) : super(key: key);

  final double widthScreen;
  final ActivityEntry? currentActivity;

  @override
  State<BottomBarRecord> createState() => _BottomBarRecordState();
}

class _BottomBarRecordState extends State<BottomBarRecord> {

  String activityTypeValue = 'run';
  String recordTypeValue = 'Normal';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 90,
      width: widget.widthScreen,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,children: [
        Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: widget.widthScreen * 0.08),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.directions, size: 25, color: primaryColorDark,)),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    icon: const Visibility(visible:false, child: Icon(Icons.arrow_downward)),
                    borderRadius: BorderRadius.circular(15),
                    value: activityTypeValue,
                    items: <String>['run', 'bike', 'swim']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(child: SvgPicture.asset('assets/custom_icons/${value}_icon.svg', width: 40, color: primaryColorDark,)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        activityTypeValue = newValue!;
                      });
                    },
                  ),
                ),
              ],
          ),),),
        FloatingActionButton(
          heroTag: 'heroStopButton',
          backgroundColor: primaryColorDark,
          onPressed: (){widget.currentActivity?.locationSubscription != null ? widget.currentActivity?.pauseRecording() : null;},
          child: SvgPicture.asset('assets/custom_icons/stop_icon.svg', width: 20,),
        ),
        Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: widget.widthScreen * 0.08),
            child: DropdownButtonHideUnderline(
              child: DecoratedBox(
                decoration: BoxDecoration(border: Border.all(color: primaryColorDark, width:2),borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: DropdownButton(
                    isExpanded: true,
                    isDense: true,
                    icon: const Icon(Icons.keyboard_arrow_up_outlined, color: primaryColorDark,),
                    borderRadius: BorderRadius.circular(15),
                    value: recordTypeValue,
                    items: <String>['Normal', 'Assist', 'Race']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(color: primaryColorDark)),),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        recordTypeValue = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
        ),),
      ],));
  }
}