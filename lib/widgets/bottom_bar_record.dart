import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../services/activity_entry.dart';
import '../services/colors.dart';

class BottomBarRecord extends StatefulWidget {
  const BottomBarRecord({
    Key? key,
    required this.widthScreen,
    required this.currentActivity,
    required this.callback
  }) : super(key: key);

  final double widthScreen;
  final ActivityEntry? currentActivity;
  final VoidCallback callback;

  @override
  State<BottomBarRecord> createState() => _BottomBarRecordState();
}

class _BottomBarRecordState extends State<BottomBarRecord> {

  String _activityTypeValue = 'run';
  String _recordTypeValue = 'Normal';
  final double _fabSize = 60;

  @override
  Widget build(BuildContext context) {

    return Container(
        color: Colors.white,
        height: 90,
        width: widget.widthScreen,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.center,children: [
          Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: (widget.currentActivity?.isCancelled ?? false) && (widget.currentActivity?.locationSubscription != null) ? widget.widthScreen * 0.045 : widget.widthScreen * 0.08),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.directions, size: 25, color: primaryColorDark,)),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    icon: const Visibility(visible:false, child: Icon(Icons.arrow_downward)),
                    borderRadius: BorderRadius.circular(15),
                    value: widget.currentActivity?.activityType ?? _activityTypeValue,
                    items: <String>['run', 'bike', 'swim']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(child: SvgPicture.asset('assets/custom_icons/${value}_icon.svg', width: 40, color: primaryColorDark,)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _activityTypeValue = newValue!;
                        widget.currentActivity?.activityType = newValue;
                        widget.callback();
                      });
                    },
                  ),
                ),
              ],
            ),),),
          (widget.currentActivity?.locationSubscription == null) ?
          SizedBox(width: _fabSize, height: _fabSize,
            child: FloatingActionButton(
              heroTag: 'heroStartButton',
              backgroundColor: primaryColorDark,
              onPressed: (){
                widget.currentActivity?.startRecording().then((value) => setState((){}));
              },
              child: Text('START', style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(color: primaryTextColor)),),
            ),
          ) :
          (widget.currentActivity?.isCancelled ?? false) ?
          Row(children: [
            Container(width: _fabSize, height: _fabSize,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: primaryColorDark, width: 2)),
              child: FloatingActionButton(
                heroTag: 'heroResumeButton',
                backgroundColor: primaryTextColor,
                onPressed: (){
                  widget.currentActivity?.startRecording().then((value) => setState(() {}));
                },
                child: Text('RESUME', style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(color: primaryColorDark)),),
              ),
            ),
            const SizedBox(width: 15,),
            SizedBox(width: _fabSize, height: _fabSize,
              child: FloatingActionButton(
                heroTag: 'heroFinishButton',
                backgroundColor: primaryColorDark,
                onPressed: () async {
                  await showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: Text('Ending recording?', style: Theme.of(context).textTheme.headlineMedium?.merge(const TextStyle(color: primaryColorDark)),),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      actions: [
                        TextButton(
                          onPressed: () {
                            widget.currentActivity?.finishRecording();
                            Navigator.pop(context);
                          },
                          child: Text('Yes', style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: primaryColorLight)),),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('No', style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(color: primaryColorLight)),),
                        ),
                      ],
                    );
                  });
                  widget.callback();
                },
                child: Text('FINISH', style: Theme.of(context).textTheme.bodySmall?.merge(const TextStyle(color: primaryTextColor)),),
              ),
            ),
          ],) :
          SizedBox(width: _fabSize, height: _fabSize,
            child: FloatingActionButton(
              heroTag: 'heroStopButton',
              backgroundColor: primaryColorDark,
              onPressed: (){
                widget.currentActivity?.locationSubscription != null ? widget.currentActivity?.stopRecording()?.then((value) => null) : null;
                setState(() {});
              },
              child: SvgPicture.asset('assets/custom_icons/stop_icon.svg', width: 20,),
            ),
          ),
          Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: ((widget.currentActivity?.isCancelled ?? false) && (widget.currentActivity?.locationSubscription != null)) ? widget.widthScreen * 0.045 : widget.widthScreen * 0.08),
            child: DropdownButtonHideUnderline(
              child: DecoratedBox(
                decoration: BoxDecoration(border: Border.all(color: primaryColorDark, width:2),borderRadius: BorderRadius.circular(50)),
                child: Padding(padding: const EdgeInsets.fromLTRB(10, 5, 5, 5), //symmetric(vertical: 5, horizontal: 15),
                  child: DropdownButton(
                    isExpanded: true,
                    isDense: true,
                    icon: const Icon(Icons.keyboard_arrow_up_outlined, color: primaryColorDark,),
                    borderRadius: BorderRadius.circular(15),
                    value: _recordTypeValue,
                    items: <String>['Normal', 'Assist', 'Race']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, overflow: TextOverflow.ellipsis ,style: Theme.of(context).textTheme.bodyMedium?.merge(const TextStyle(color: primaryColorDark)),),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _recordTypeValue = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),),
        ],));
  }
}