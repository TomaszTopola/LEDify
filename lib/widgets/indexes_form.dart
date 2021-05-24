import 'package:flutter/material.dart';
import 'package:led_slider/api/led_range.dart';
import 'package:led_slider/widgets/spin_box.dart';

class IndexesForm extends StatefulWidget {

  final LedStatus _ledStatus;
  IndexesForm(this._ledStatus);

  @override
  _IndexesFormState createState() => _IndexesFormState();
}

class _IndexesFormState extends State<IndexesForm> {

  double startIndex = 0.0;
  double count = 1.0;
  double pixelsCount = 16.0;
  double maxCount = 16.0;

  void saveLedState(){
    widget._ledStatus.setRange(start: startIndex.toInt(), count: count.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SpinBox(
            minValue: 0,
            maxValue: pixelsCount,
            onChanged: (value) {
              setState(() {
                startIndex = value;
                maxCount = pixelsCount - startIndex;
                if(count>maxCount) count = maxCount;
              });
              saveLedState();
            },
            value: startIndex.toDouble(),
            title: 'start\nindex',
          ),
          SpinBox(
            minValue: 1,
            maxValue: maxCount,
            onChanged: (value) {
              setState(() {
                count = value;
                maxCount = pixelsCount - startIndex;
                if(count>maxCount) count = maxCount;
              });
              saveLedState();
            },
            value: count,
            title: 'led\ncount',
          )
        ]
      ),
    );
  }
}
