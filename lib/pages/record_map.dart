import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:race_tracker/services/activity_entry.dart';
import 'package:race_tracker/services/colors.dart';
import '../widgets/bottom_bar_record.dart';
import '../widgets/sliding_up_panel_record.dart';

//ignore: must_be_immutable
class RecordMap extends StatefulWidget {

  RecordMap({this.currentActivity, Key? key}) : super(key: key);

  ActivityEntry? currentActivity;

  @override
  State<RecordMap> createState() => _RecordMapState();
}

class _RecordMapState extends State<RecordMap> {

  late Stream<LocationData> locationStream;

  @override
  void initState() {
    askPermission();
    locationStream = getLocationStream();
    widget.currentActivity == null ? widget.currentActivity = ActivityEntry(locationStream: locationStream, onLocationChanged: (){setState(() {});}) : widget.currentActivity?.onLocationChanged = (){setState(() {});};
    super.initState();
  }

  @override
  void dispose() {
    widget.currentActivity?.onLocationChanged = (){};
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Text('Back', style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: primaryTextColor)) ,),
          onPressed: () => Navigator.of(context).pop(widget.currentActivity)
        ),
        title: const Text('Record'),
      ),
      body: Stack(
        children: [
          RecordSlidingUpPanel(
            widthScreen: widthScreen,
            currentActivity: widget.currentActivity,
            locationStream: locationStream,
          ),
          Positioned(bottom: 0,child: BottomBarRecord(
            widthScreen: widthScreen,
            currentActivity: widget.currentActivity,
            callback: (){
              setState(() {});
            },
            onStart: (){print('TEST_START');},
            onFinish: (){print('TEST_FINISH');},
            onResume: (){print('TEST_RESUME');},
            onStop: (){print('TEST_STOP');},
          )),
        ],
      ),
    );
  }

  Future askPermission() async {

    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('Location service not enabled');
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Location denied by user');
      }
    }
  }

  Stream<LocationData> getLocationStream() {

    Location location = Location();
    return location.onLocationChanged;

  }

}