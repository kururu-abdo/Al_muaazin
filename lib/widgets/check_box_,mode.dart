 import 'package:flutter/material.dart';

class Mode extends StatefulWidget {
  @override
  _ModeState createState() => _ModeState();
}

class _ModeState extends State<Mode> {
 bool _autoVal = false;

  bool _customVal = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // [Monday] checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Auto"),
                  Checkbox(
                    value: _autoVal,
                    onChanged: (bool value) {
                      setState(() {
                        _autoVal = value;
                      });
                    },
                  ),
                ],
              ),
              // [Tuesday] checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Custom"),
                  Checkbox(
                    value: _customVal,
                    onChanged: (bool value) {
                      setState(() {
                        _customVal = value;
                      });
                    },
                  ),
                ],
              ),
              // [Wednesday] checkbox
           
            ],
          ),
    );
  }
}