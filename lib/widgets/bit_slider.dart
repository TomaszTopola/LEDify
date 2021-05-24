import 'dart:math';

import 'package:flutter/material.dart';
import 'package:led_slider/api/led_range.dart';

class BitSlider extends StatefulWidget {

  final LedStatus ledStatus;
  final int bit;
  final MaterialColor color;
  final String colorKey;
  final Function callback;

  BitSlider({
    @required this.ledStatus,
    this.bit = 8,
    this.color = Colors.teal,
    @required this.colorKey,
    @required this.callback
  });

  @override
  _BitSliderState createState() => _BitSliderState();
}

class _BitSliderState extends State<BitSlider> {

  @override
  Widget build(BuildContext context) {
    final double minValue = 0;
    final double maxValue = (pow(2, widget.bit) - 1).toDouble();
    return Slider(
      activeColor: widget.color,
      inactiveColor: widget.color.shade900,
      value: widget.ledStatus.getValue(widget.colorKey).toDouble(),
      max: maxValue,
      min: minValue,
      divisions: maxValue.round().toInt() +1,
      label: widget.ledStatus.getValue(widget.colorKey).toString(),
      onChanged: (double value) {
        setState(() {
          widget.ledStatus.setColor(
              value: value.round().toInt(),
              key: widget.colorKey);
        });
        widget.callback();
      },
    );
  }
}
