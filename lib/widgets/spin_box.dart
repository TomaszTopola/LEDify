import 'package:flutter/material.dart';

class SpinBox extends StatefulWidget {

  final double maxValue;
  final double minValue;
  final double value;
  final Function onChanged;
  final String title;

  SpinBox({
    this.minValue = 0.0,
    this.maxValue = 0.0,
    this.value = 0.0,
    @required this.onChanged,
    this.title = '',
  });

  @override
  _SpinBoxState createState() => _SpinBoxState();
}

class _SpinBoxState extends State<SpinBox> {

  @override
  Widget build(BuildContext context) {
    double _value = widget.value;
    return Container(
      child: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_circle_up, color: Colors.white,),
            onPressed: (){
              setState(() {
                if(_value < widget.maxValue) _value += 1;
                widget.onChanged(_value);
              });
            },
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              _value.toInt().toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: Icon(Icons.arrow_circle_down, color: Colors.white,),
            onPressed: (){
              setState(() {
                if(_value > widget.minValue) _value -= 1;
                widget.onChanged(_value);
              });
            },
          ),
          Text(
            widget.title.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}


