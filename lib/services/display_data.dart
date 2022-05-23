import 'package:flutter/material.dart';
import 'package:race_tracker/services/activity_entry.dart';

class DisplayData extends StatelessWidget {
  const DisplayData({
    Key? key,
    required this.title,
    required this.dataStr,
    this.titleStyle,
    this.dataStrStyle
  }) : super(key: key);

  final String title;
  final String dataStr;
  final TextStyle? titleStyle;
  final TextStyle? dataStrStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(title, style: titleStyle ?? Theme.of(context).textTheme.labelMedium,),
        const SizedBox(height: 5,),
        Text(dataStr, style: dataStrStyle ?? Theme.of(context).textTheme.bodyMedium,),
      ],),);
  }
}

String formatMovingTime(int movingTime){

  String _formattedTime = '';

  int h = movingTime ~/ 3600;
  int m = (movingTime % 3600) ~/ 60;
  int s = (movingTime % 60);

  _formattedTime = h != 0 ? h.toString() + 'h ' + m.toString() + 'm ' + s.toString() + 's' : (m != 0 ? m.toString() + 'm ' + s.toString() + 's' : s.toString() + 's');

  return _formattedTime;
}

String formatPace(int movingTime, int distance){

  String _formattedPace = "--";

  if(distance != 0){
    double pace = movingTime * 1000 / (distance * 60);
    int paceMin = pace.truncate();
    int paceSec = ((pace - paceMin) * 60).round();

    _formattedPace = paceMin.toString() + "' " + paceSec.toString().padLeft(2, '0') + " /K";
  }

  return _formattedPace;

}

String formatDistance(ActivityEntry? activityEntry){

  return (activityEntry?.activityType ?? 'run') != 'swim' ?
  '${((activityEntry?.distance ?? 0) / 1000).toStringAsFixed(2)} K' :
  '${(activityEntry?.distance.round() ?? 0).toString()} m';

}