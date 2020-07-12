import 'package:flutter/material.dart';



import 'package:muaazin/models/auto_model.dart';
import 'package:muaazin/stores/app_store.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class Info extends StatelessWidget {
  var appStore = Injector.get<AppStore>();

  @override
  Widget build(BuildContext context) {
    var model = Injector.getAsReactive<AppStore>(context: context);
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment:MainAxisAlignment.spaceEvenly,
      children:[
Row(
  textDirection: TextDirection.rtl,
  children:[
    Text('المدينة: '),

    StateBuilder<AppStore>(
      models:[model] ,
      builder: (context ,model){
        if(model.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }else {
         return   FutureBuilder(
        future: model.state.fetchData(),

        builder: (BuildContext context, AsyncSnapshot<AppModel> snapshot) {
        if (snapshot.hasData) {
        return Text(snapshot.data.city);

        }else{
        return CircularProgressIndicator();
        }
        },
        );
        }
      },
    ),

   

  ]
) ,


Row(


  children:[
    Text('التاريخ:'),

    StateBuilder<AppStore>(
      models:[model] ,
      builder: (context ,model){
        if(model.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }else {

          return  FutureBuilder<AppModel>(
            future: model.state.fetchData(),

            builder: (BuildContext context, AsyncSnapshot<AppModel> snapshot) {
              if (snapshot.hasData) {
                var date = new DateTime.fromMillisecondsSinceEpoch((int.parse(snapshot.data.date??0))  * 1000);
                var dateTime = DateTime.parse(date.toString());
                var formate2 = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
                print('${formate2}   ${dateTime.hour}');
//String convertedDate = new DateFormat("yyyy-MM-dd").format(date);


                return Text(formate2??'');

              }else{
                return CircularProgressIndicator();
              }
            },
          );

        }
      },
    ),





  ]
)
      ]

    );
  }
}