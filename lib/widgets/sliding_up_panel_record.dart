import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../services/activity_entry.dart';
import '../services/display_data.dart';
import 'location_map.dart';

class RecordSlidingUpPanel extends StatefulWidget {
  const RecordSlidingUpPanel({
    Key? key,
    required this.widthScreen,
    required this.currentActivity,
    required this.locationStream,
  }) : super(key: key);

  final double widthScreen;
  final ActivityEntry? currentActivity;
  final Stream<LocationData> locationStream;

  @override
  State<RecordSlidingUpPanel> createState() => _RecordSlidingUpPanelState();
}

class _RecordSlidingUpPanelState extends State<RecordSlidingUpPanel> {

  @override
  Widget build(BuildContext context) {
    widget.currentActivity?.onLocationChanged = (){setState(() {});};
    return SlidingUpPanel(
      parallaxOffset: 0.5,
      minHeight: 250,
      maxHeight: 490,
      parallaxEnabled: true,
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      panel: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0.1 * widget.widthScreen),
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: 120,
            child: Stack(
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    DisplayData(title: 'Distance', dataStr: formatDistance(widget.currentActivity),
                      titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                    SizedBox(width: 0.1 * widget.widthScreen,),
                    DurationTimer(currentActivity: widget.currentActivity,),
                  ],),
                  Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    DisplayData(title: 'Avg Pace', dataStr: formatPace(widget.currentActivity?.duration ?? 0, widget.currentActivity?.distance.round() ?? 0),
                      titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                    SizedBox(width: 0.1 * widget.widthScreen,),
                    DisplayData(title: 'Current Pace', dataStr: formatPace(widget.currentActivity?.duration ?? 0, widget.currentActivity?.distance.round() ?? 0),
                      titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,),
                  ],)
                ],),
                Positioned(top: 60, left: 0, right: 0 ,child: Container(height: 1,color: const Color.fromRGBO(0, 0, 0, 0.3),)),
                Positioned(top: 0, bottom: 0, left: widget.widthScreen * 0.4 ,child: Container(width: 1,color: const Color.fromRGBO(0, 0, 0, 0.3),)),
              ],
            ),
          ),
        ),
      ),
      body: LocationMap(locationStream: widget.locationStream,),
      // body: SizedBox(height: 200, child: Image.asset('assets/placeholders/record_map.png', fit: BoxFit.fitWidth,alignment: Alignment.topCenter,)),
    );
  }
}

class DurationTimer extends StatefulWidget {
  const DurationTimer({
    Key? key,
    required this.currentActivity
  }) : super(key: key);

  final ActivityEntry? currentActivity;

  @override
  State<DurationTimer> createState() => _DurationTimerState();
}

class _DurationTimerState extends State<DurationTimer>{

  Timer? _timer;
  late int _timerDuration;
  late int _initialDuration;

  final Stopwatch _stopwatch = Stopwatch();

  @override
  void initState() {
    _timerDuration = widget.currentActivity?.duration ?? 0;
    _initialDuration = widget.currentActivity?.duration ?? 0;
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  startTimerDuration(){
    _initialDuration = widget.currentActivity?.duration ?? 0;
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer){
      setState(() {_timerDuration = _initialDuration + (_stopwatch.elapsedMilliseconds/1000).round();});
    });
  }

  stopTimerDuration(){
    _stopwatch.stop();
    _timer?.cancel();
    setState((){
      _stopwatch.reset();
      _timerDuration = widget.currentActivity?.duration ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(!(widget.currentActivity?.isCancelled ?? false)){
      if(!(_stopwatch.isRunning) && !(_timer?.isActive ?? false)) {
        startTimerDuration();
      }
    }
    else{
      stopTimerDuration();
    }

    return DisplayData(title: 'Time', dataStr: formatMovingTime(_timerDuration),
      titleStyle: Theme.of(context).textTheme.bodyMedium, dataStrStyle: Theme.of(context).textTheme.titleLarge,);
  }
}