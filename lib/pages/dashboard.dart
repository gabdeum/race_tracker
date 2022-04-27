import 'package:flutter/material.dart';
import 'package:race_tracker/services/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../services/bottom_bar.dart';
import 'package:flutter_svg/svg.dart';

class Dashboard extends StatelessWidget {

  Dashboard({Key? key}) : super(key: key);

  static const double carouselHeight = 175;
  static const double carouselWidgetHeight = 150;
  final List<Widget> carouselWidgets = [
    Container(height: carouselWidgetHeight, color: backgroundColor,),
    Container(height: carouselWidgetHeight, color: Colors.red,),
    Container(height: carouselWidgetHeight, color: Colors.orange,),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: const Drawer(),
      bottomNavigationBar: const BottomBar(),
      body: CarouselWithIndicator(context: context, trainingTrend: 40,)
    );
  }
}

class CarouselWithIndicator extends StatefulWidget {

  final BuildContext context;
  final int trainingTrend;
  const CarouselWithIndicator({required this.trainingTrend, required this.context, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {

  static const double carouselHeight = 175;
  static const double indicatorHeight = 25;

  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<Widget> carouselWidgets = [];

  @override
  void initState() {
    carouselWidgets = [
      Container(
        width: double.infinity,
        color: primaryTextColor,
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
        child: Column(children: [
          Row(children: [
            Expanded(child: Text('Training trend ', style: Theme.of(widget.context).textTheme.titleMedium,),),
            SizedBox(width: 60, height: 20, child: Text('${widget.trainingTrend.toString()}%', style: Theme.of(widget.context).textTheme.titleMedium, textAlign: TextAlign.end,),)
          ],),
          const SizedBox(height: 10,),
          // SvgPicture.asset('assets/placeholders/dashboardTrendGraph.svg', height: 98,)
        ],),
      ),
      Container(
        width: double.infinity,
        color: primaryTextColor,
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Personal Bests', style: Theme.of(widget.context).textTheme.titleMedium,),
            const SizedBox(height: 10,),
          ],),
      ),
      Container(color: primaryColorLight,),
    ];
    super.initState();
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
}