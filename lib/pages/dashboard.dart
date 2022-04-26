import 'package:flutter/material.dart';
import 'package:race_tracker/services/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../services/bottom_bar.dart';

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
      body: const CarouselWithIndicator()
    );
  }
}

class CarouselWithIndicator extends StatefulWidget {
  const CarouselWithIndicator({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {

  static const double carouselHeight = 175;
  static const double carouselWidgetHeight = 150;
  final List<Widget> carouselWidgets = [
    Container(height: carouselWidgetHeight, color: backgroundColor,),
    Container(height: carouselWidgetHeight, color: Colors.red,),
    Container(height: carouselWidgetHeight, color: Colors.orange,),
  ];

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: carouselWidgets,
        carouselController: _controller,
        options: CarouselOptions(
            height: carouselHeight,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: carouselWidgets.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12.0,
              height: 12.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            ),
          );
        }).toList(),
      ),
    ]);
  }
}