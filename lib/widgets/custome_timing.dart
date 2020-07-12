import 'package:flutter/material.dart';

class CustomWidget extends StatefulWidget {


  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Row(
         textDirection: TextDirection.rtl,
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         
         children: [Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.end,
children: [

Text('الفجر') ,
Text('الظهر'),
Text('العصر'),
Text('المغرب'),
Text('العشاء'),
],


         ) ,
         
         Column(
 mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.end,




         )],),
    );
  }
}