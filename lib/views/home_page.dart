import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:led_slider/api/lamp.dart';
import 'package:led_slider/api/led_range.dart';
import 'package:led_slider/widgets/indexes_form.dart';
import 'package:led_slider/widgets/rgb_form.dart';

class HomePage extends StatelessWidget {

  LedStatus _ledStatus = LedStatus.blank(bit: 8);

  @override
  Widget build(BuildContext context) {
    _ledStatus.setRange(start: 0, count: 16);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RGBForm(_ledStatus),
              SizedBox(height: 20,),
              IndexesForm(_ledStatus),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      try{
                        LedStatus blank = LedStatus.blank(bit: 8);
                        blank.setRange(start: 0, count: 16);
                        Response res = await Lamp.setState(data: blank.getValues());
                        print('Responded with status code ${res.statusCode}');
                      }catch(e){
                        print(e);
                      }
                    },
                    child: Text('Clear'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try{
                        print('Sending request with body: ${_ledStatus.getValues()}');
                        Response res = await Lamp.setState(data: _ledStatus.getValues());
                        print('Responded with status code ${res.statusCode}');
                      }catch(e){
                        print(e);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}
