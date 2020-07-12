import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:muaazin/main.dart';
import 'package:muaazin/widgets/responsive_safe_area.dart';

class SplashScreen extends StatefulWidget {
  

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
AudioCache _audioCache = new AudioCache();
  @override
  void initState() {
   
    super.initState();

   
    //openAudio();
     goToTheMain();
  }



goToTheMain() async{
   Timer(Duration(seconds: 4), (){
     Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=> MyHomePage(title: 'Flutter Demo Home Page')));

  });
}
void openAudio()async{
 _audioCache.play('azan.mp3');
}

  @override
  Widget build(BuildContext context) {
    return 
       MaterialApp(
         debugShowCheckedModeBanner: false,
         debugShowMaterialGrid: false,
                home: Scaffold(
           
          body:ResponsiveSafeArea(
            builder:(context ,size){
              return Container(alignment: Alignment.center,
          
          child: Center(
child: Text('بسم الله  الرحمن الرحيم'),
          ),
          );

            }
          )
      
    ),
       );
  }
}