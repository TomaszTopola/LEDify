import 'dart:math';

import 'package:flutter/material.dart';

class LedStatus {

  Map<String,dynamic> _ledValues = new Map<String, dynamic>();
  final int bit;
  int maxVal;

  LedStatus.fromValues({
    @required int red,
    @required int green,
    @required int blue,
    @required int startPin,
    @required int endPin,
    @required this.bit,
  }){
    _ledValues["R"] = red;
    _ledValues["G"] = green;
    _ledValues["B"] = blue;
    _ledValues["START-INDEX"] = startPin;
    _ledValues["END-INDEX"] = endPin;
    calculateMaxVal();
  }
  LedStatus.fromMap(Map<String, dynamic> map,{@required this.bit,}){
    assert (map["R"] is int
        && map["G"] is int
        && map["B"] is int
        && map["R"] is int
        && map["R"] is int,
    'R, G, B, START_PIN and END_PIN params must be type of int');
    calculateMaxVal();
  }

  LedStatus.blank({@required this.bit}){
    _ledValues["R"] = 0;
    _ledValues["G"] = 0;
    _ledValues["B"] = 0;
    _ledValues["START-INDEX"] = 0;
    _ledValues["END-INDEX"] = 0;
    calculateMaxVal();
  }

  void calculateMaxVal(){
    maxVal = pow(2, bit); //returns max color value + 1
    // (for 8-bit it's 256, 0 is also a value so colors are in range 0-255)
  }

  void setColor({ int value, String key}){
    assert(value >= 0 && value < maxVal,
    "value must be within range from 0 to ${maxVal - 1}");
    _ledValues[key] = value;
  }

  void setRange({
    @required int start,
    @required int count
  }){
    assert (start >= 0, "Start pin must be greater or equal to 0");
    _ledValues["START-INDEX"] = start;
    _ledValues["END-INDEX"] = count;
  }

  int getValue(String field){
    return _ledValues[field];
  }

  Map<String, dynamic> getValues(){
    return _ledValues;
  }
}