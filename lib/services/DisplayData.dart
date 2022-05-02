import 'package:flutter/material.dart';

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
    ],));
  }
}

String formatMovingTime(int movingTime){

  String formattedTime = '';

  int h = movingTime ~/ 3600;
  int m = (movingTime % 3600) ~/ 60;
  int s = (movingTime % 60);

  formattedTime = h != 0 ? h.toString() + 'h ' + m.toString() + 'm ' + s.toString() + 's' : (m != 0 ? m.toString() + 'm ' + s.toString() + 's' : s.toString() + 's');

  return formattedTime;
}

String formatPace(int movingTime, int distance){

  String formattedPace = "";

  double pace = movingTime * 1000 / (distance * 60);
  int paceMin = pace.truncate();
  int paceSec = ((pace - paceMin) * 60).round();

  formattedPace = paceMin.toString() + "' " + paceSec.toString() + " /K";

  return formattedPace;

}