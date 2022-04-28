import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../services/colors.dart';

class CarouselWithIndicator extends StatefulWidget {

  final BuildContext context;
  final int trainingTrend;
  final Map<String,DateTime?> personalBestTimes;
  const CarouselWithIndicator({required this.personalBestTimes, required this.trainingTrend, required this.context, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {

  static const double carouselHeight = 175;
  static const double indicatorHeight = 25;

  static const String runIconPath = 'assets/custom_icons/run_icon.svg';
  static const String bikeIconPath = 'assets/custom_icons/bike_icon.svg';
  static const String swimIconPath = 'assets/custom_icons/swim_icon.svg';

  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<Widget> carouselWidgets = [];

  @override
  void didChangeDependencies() {
    final double width = MediaQuery.of(context).size.width;
    carouselWidgets = [
      Container(
        width: double.infinity,
        color: primaryTextColor,
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
        child: Column(children: [
          Row(children: [
            Expanded(child: Text('Training trend', style: Theme.of(widget.context).textTheme.titleMedium,),),
            SizedBox(width: 60, height: 20, child: Text('${widget.trainingTrend.toString()}%', style: Theme.of(widget.context).textTheme.titleMedium, textAlign: TextAlign.end,),)
          ],),
          const SizedBox(height: 10,),
          SvgPicture.asset('assets/placeholders/dashboardTrendGraph.svg', height: 98,)
        ],),
      ),
      Container(
        width: double.infinity,
        color: primaryTextColor,
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Personal Bests', style: Theme.of(widget.context).textTheme.titleMedium,),
            const SizedBox(height: 10,),
            Expanded(
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                Row(children: [
                  SvgPicture.asset(runIconPath, width: 20,), SizedBox(child: Text('26.2 M', style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,), width: width * 0.14,),
                  Expanded(child: Text(formatDate(widget.personalBestTimes["marathon"]), style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,)),
                  SizedBox(width: width * 0.08,),
                  SvgPicture.asset(bikeIconPath, width: 20,), SizedBox(child: Text('100 K', style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,), width: width * 0.14,),
                  Expanded(child: Text(formatDate(widget.personalBestTimes["100kBike"]), style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,)),
                ],),
                Row(children: [
                  SvgPicture.asset(runIconPath, width: 20,), SizedBox(child: Text('13.1 M', style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,), width: width * 0.14,),
                  Expanded(child: Text(formatDate(widget.personalBestTimes["halfmarathon"]), style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,)),
                  SizedBox(width: width * 0.08,),
                  SvgPicture.asset(bikeIconPath, width: 20,), SizedBox(child: Text('50 K', style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,), width: width * 0.14,),
                  Expanded(child: Text(formatDate(widget.personalBestTimes["50kBike"]), style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,)),
                ],),
                Row(children: [
                  SvgPicture.asset(runIconPath, width: 20,), SizedBox(child: Text('10 K', style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,), width: width * 0.14,),
                  Expanded(child: Text(formatDate(widget.personalBestTimes["10kRun"]), style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,)),
                  SizedBox(width: width * 0.08,),
                  SvgPicture.asset(swimIconPath, width: 20,), SizedBox(child: Text('2500 m', style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,), width: width * 0.14,),
                  Expanded(child: Text(formatDate(widget.personalBestTimes["2500mSwim"]), style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,)),
                ],),
                Row(children: [
                  SvgPicture.asset(runIconPath, width: 20,), SizedBox(child: Text('5 K', style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,), width: width * 0.14,),
                  Expanded(child: Text(formatDate(widget.personalBestTimes["5kRun"]), style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,)),
                  SizedBox(width: width * 0.08,),
                  SvgPicture.asset(swimIconPath, width: 20,), SizedBox(child: Text('1000 m', style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,), width: width * 0.14,),
                  Expanded(child: Text(formatDate(widget.personalBestTimes["1000mSwim"]), style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end,)),
                ],),
              ],),
            )
          ],),
      ),
      Container(color: primaryColorLight,),
    ];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: carouselHeight,
      decoration: const BoxDecoration(
        color: primaryTextColor,
        boxShadow: [BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25), blurRadius: 4.0, spreadRadius: 0.0, offset: Offset(0, 4.0),)],
      ),
      child: Column(children: [
        CarouselSlider(
          items: carouselWidgets,
          carouselController: _controller,
          options: CarouselOptions(
              height: carouselHeight-indicatorHeight,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        SizedBox(
          height: indicatorHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: carouselWidgets.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 9.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColorDark.withOpacity(_current == entry.key ? 0.9 : 0.2)),
                ),
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }

  String formatDate(DateTime? dateTime){
    String formattedDate = '';

    if(dateTime != null){
      formattedDate = (dateTime.hour > 0 ? "${dateTime.hour}h " : "")
          + (dateTime.minute > 0 ? "${dateTime.minute}m " : "")
          + (dateTime.second > 0 ? "${dateTime.second}s" : "");
    }

    return formattedDate;
  }
}