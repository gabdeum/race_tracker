import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../services/display_data.dart';
import '../services/activity.dart';
import '../services/colors.dart';

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
                DisplayData(title: 'Distance', dataStr: activity.activityType != 'swim' ? '${((activity.activityDistance) / 1000).toStringAsFixed(2)} K'
                    : '${activity.activityDistance.toString()} m',),
                Container(color: const Color.fromRGBO(0, 0, 0, 0.5), height: 30, width: 1,),
                DisplayData(title: 'Time', dataStr: formatMovingTime(activity.activityMovingTime)),
                Container(color: const Color.fromRGBO(0, 0, 0, 0.5), height: 30, width: 1,),
                DisplayData(title: 'Avg Pace', dataStr: formatPace(activity.activityMovingTime, activity.activityDistance)),
              ],)),
            Image.asset('assets/placeholders/${activity.activityId}.png', width: MediaQuery.of(context).size.width, height: 190, fit: BoxFit.cover,)
          ],),
        ),
      ],
    );
  }

}