import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:race_tracker/services/activity_entry.dart';
import '../pages/dashboard.dart';
import '../pages/record_map.dart';
import '../pages/routes.dart';
import '../services/colors.dart';

class BottomBar extends StatefulWidget {

  final bool dashboard;
  ActivityEntry? currentActivity;

  BottomBar({
    required this.dashboard,
    this.currentActivity,
    Key? key,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
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
                      onTap: (){!widget.dashboard ? Navigator.of(context).pushReplacement(_navigateToDashboard(widget.currentActivity)): null;},
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
                                  Icon(Icons.dashboard_outlined, size: 25, color: Color.fromRGBO(255, 255, 255, !widget.dashboard ? 1 : 0.5),),
                                  Text('Dashboard', style: Theme.of(context).textTheme.bodySmall?.merge(TextStyle(color: Color.fromRGBO(255, 255, 255, !widget.dashboard ? 1 : 0.5))),)
                                ],
                              )
                          )
                        ],
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    InkWell(
                      onTap: (){widget.dashboard ? Navigator.of(context).push(_navigateToRoutes(widget.currentActivity)) : null;},
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
                                  Icon(Icons.directions, size: 25, color: Color.fromRGBO(255, 255, 255, widget.dashboard ? 1 : 0.5),),
                                  Text('Routes', style: Theme.of(context).textTheme.bodySmall?.merge(TextStyle(color: Color.fromRGBO(255, 255, 255, widget.dashboard ? 1 : 0.5))),)
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
                    onTap: () {
                      Navigator.of(context).push(_navigateToRecord(widget.currentActivity)).then((value) {
                        setState(() {
                          value is ActivityEntry ? widget.currentActivity = value : null;
                        });
                      });
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

Route _navigateToRoutes(ActivityEntry? currentActivity) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Routes(currentActivity: currentActivity,),
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

Route _navigateToDashboard(ActivityEntry? currentActivity) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Dashboard(currentActivity: currentActivity),
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

Route _navigateToRecord(ActivityEntry? currentActivity) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => RecordMap(currentActivity: currentActivity,),
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