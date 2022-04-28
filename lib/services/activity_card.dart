import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'activity.dart';
import 'colors.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    Key? key,
    required this.activity,
  }) : super(key: key);

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              SvgPicture.asset('assets/custom_icons/${activity.activityType}_icon.svg', width: 40,),
              const SizedBox(width: 10,),
              Text(activity.activityName, style: Theme.of(context).textTheme.titleMedium,),
              const Expanded(child: SizedBox(height: 40,)),
              Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
                Text(DateFormat.yMMMMEEEEd().format(activity.activityDateTime), style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,),
                Text('${DateFormat.jm().format(activity.activityDateTime)} • ${activity.activityLocation['locationName']}', style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.end,)
              ],),
              const SizedBox(width: 15,),
            ],),
            Expanded(child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Distance', style: Theme.of(context).textTheme.labelMedium,),
                  const SizedBox(height: 5,),
                  Text(activity.activityType != 'swim' ? '${((activity.activityDistance) / 1000).toStringAsFixed(2)} K'
                      : '${activity.activityDistance.toString()} m', style: Theme.of(context).textTheme.bodyMedium,),
                ],)),
                Container(color: const Color.fromRGBO(0, 0, 0, 0.5), height: 30, width: 1,),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Time', style: Theme.of(context).textTheme.labelMedium,),
                  const SizedBox(height: 5,),
                  Text(formatMovingTime(activity.activityMovingTime), style: Theme.of(context).textTheme.bodyMedium,),
                ],)),
                Container(color: const Color.fromRGBO(0, 0, 0, 0.5), height: 30, width: 1,),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Avg Pace', style: Theme.of(context).textTheme.labelMedium,),
                  const SizedBox(height: 5,),
                  Text(formatPace(activity.activityMovingTime, activity.activityDistance), style: Theme.of(context).textTheme.bodyMedium,),
                ],)),
              ],)),
            Image.asset('assets/placeholders/activity01.png', width: MediaQuery.of(context).size.width, height: 190, fit: BoxFit.cover,)
          ],),
        ),
      ],
    );
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

}