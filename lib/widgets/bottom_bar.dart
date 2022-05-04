import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import '../pages/dashboard.dart';
import '../pages/record_map.dart';
import '../pages/routes.dart';
import '../services/colors.dart';

class BottomBar extends StatelessWidget {

  final bool dashboard;

  const BottomBar({
    required this.dashboard,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: 110,
        child: Stack(alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              height: 110,
              decoration: const BoxDecoration(gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[Color.fromRGBO(0, 0, 0, 0.5),Colors.transparent]
              )),),
            Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){!dashboard ? Navigator.of(context).pushReplacement(_navigateToDashboard()): null;},
                      child: Stack(
                        children: [
                          SvgPicture.asset('assets/bottom_bar/dashboard.svg'),
                          Positioned(
                              left: 40,
                              top: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.dashboard_outlined, size: 25, color: Color.fromRGBO(255, 255, 255, !dashboard ? 1 : 0.5),),
                                  Text('Dashboard', style: Theme.of(context).textTheme.bodySmall?.merge(TextStyle(color: Color.fromRGBO(255, 255, 255, !dashboard ? 1 : 0.5))),)
                                ],
                              )
                          )
                        ],
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    InkWell(
                      onTap: (){dashboard ? Navigator.of(context).pushReplacement(_navigateToRoutes()) : null;},
                      child: Stack(
                        children: [
                          SvgPicture.asset('assets/bottom_bar/routes.svg'),
                          Positioned(
                              right: 52,
                              top: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.directions, size: 25, color: Color.fromRGBO(255, 255, 255, dashboard ? 1 : 0.5),),
                                  Text('Routes', style: Theme.of(context).textTheme.bodySmall?.merge(TextStyle(color: Color.fromRGBO(255, 255, 255, dashboard ? 1 : 0.5))),)
                                ],
                              )
                          )
                        ],
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    )
                  ],
                ),
            ),
            Positioned(
              bottom: 41.84,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.of(context).push(_navigateToRecord());
                      },
                    child: SvgPicture.asset('assets/bottom_bar/new_activity.svg',),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Route _navigateToRoutes() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const Routes(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _navigateToDashboard() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Dashboard(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(-1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _navigateToRecord() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => RecordMap(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}