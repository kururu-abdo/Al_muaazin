import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:muaazin/dataSources/shared_pref_data.dart';
import 'package:muaazin/stores/app_store.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class Header extends StatelessWidget {
 


  @override
  Widget build(BuildContext context) {
    var model  = Injector.getAsReactive<AppStore>(context: context);
    return Container(
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center ,
        children:[
          Text('بسم الله الرحمن الرحيم'   , style: TextStyle(fontFamily:ArabicFonts.Cairo  , fontSize:20.0 ,package: 'google_fonts_arabic'),) ,
          Text('برنامج المؤذن'   , style: TextStyle(fontFamily:ArabicFonts.Cairo  , fontSize:15.0 ,package: 'google_fonts_arabic'),) ,
Text('${model.state.runtimeType}')

        ]
      ),
    );
  }
}