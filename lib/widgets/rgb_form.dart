import 'package:http/http.dart';
import 'package:led_slider/api/lamp.dart';
import 'package:led_slider/api/led_range.dart';
import 'package:led_slider/widgets/bit_slider.dart';
import 'package:flutter/material.dart';

class RGBForm extends StatefulWidget {

  final LedStatus _ledStatus;
  RGBForm(this._ledStatus);

  @override
  _RGBFormState createState() => _RGBFormState();
}

class _RGBFormState extends State<RGBForm> {

  Color _previewColor = Color.fromRGBO(0, 0, 0, 1);

  void updateColors(){
    setState(() {
      _previewColor = Color.fromRGBO(
          widget._ledStatus.getValue("R"),
          widget._ledStatus.getValue("G"),
          widget._ledStatus.getValue("B"),
          1.0
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          BitSlider(
            colorKey: "R",
            color: Colors.red,
            ledStatus: widget._ledStatus,
            callback: updateColors,
          ),
          BitSlider(
            colorKey: "G",
            color: Colors.green,
            ledStatus: widget._ledStatus,
            callback: updateColors,
          ),
          BitSlider(
            colorKey: "B",
            color: Colors.blue,
            ledStatus: widget._ledStatus,
            callback: updateColors,
          ),
          Container(
            decoration: BoxDecoration(
                color: _previewColor,
                borderRadius: BorderRadius.circular(8.0)
            ),
            width: 200,
            height: 50,
          )
        ],
      ),
    );
  }
}
