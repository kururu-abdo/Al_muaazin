import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:muaazin/models/auto_model.dart';
import 'package:muaazin/stores/app_store.dart';
import 'package:provider/provider.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class AutoWidget extends StatefulWidget {


  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<AutoWidget> {
var appStore = Injector.get<AppStore>();

  @override
  void initState() {
   
    super.initState();

appStore.fetchData();
  }
  @override
  Widget build(BuildContext context) {
    var model  = Injector.getAsReactive<AppStore>(context: context);
    return Container(
       child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             textDirection: TextDirection.rtl,
       
         children: [
//           Column(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Text('الفجر' ,style: TextStyle(fontWeight:FontWeight.bold ,fontSize: 20),) ,
//Text('الظهر' ,style: TextStyle(fontWeight:FontWeight.bold ,fontSize: 20),),
//Text('العصر',style: TextStyle(fontWeight:FontWeight.bold ,fontSize: 20),),
//Text('المغرب',style: TextStyle(fontWeight:FontWeight.bold ,fontSize: 20),),
//Text('العشاء',style: TextStyle(fontWeight:FontWeight.bold ,fontSize: 20),),
//         ],
//
//         ) ,
        //  FutureBuilder<AppModel>(
        //    future: store.fetchData(),
           
        //    builder: (BuildContext context, AsyncSnapshot<AppModel> snapshot) {
        //      if (snapshot.hasData) {
        //        return Text(snapshot.data.timing.toString());
               
        //      }else{
        //        return CircularProgressIndicator();
        //      }
        //    },
        //  ),

           Builder(

             builder: (context  ){
               if(model.connectionState==ConnectionState.waiting){
                 return  CircularProgressIndicator();
               }else if(model.connectionState==ConnectionState.done){
                 return Column(
 mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.end,
children:model.state.prays.map((e) => Text('${e['time']}' ,style:TextStyle(fontWeight:FontWeight.bold ,fontSize: 20),)).toList()
       ) ;
               }else{

                 return Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children:model.state.events.map((e) => Text('${e.name}' ,style:TextStyle(fontWeight:FontWeight.bold ,fontSize: 20),)).toList()
                 ) ;
               }
             },
           )

//         Column(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.end,
//children:store.prays.map((e) => Text('${e['time']}' ,style:TextStyle(fontWeight:FontWeight.bold ,fontSize: 20),)).toList()
//       )
//
,

           StateBuilder<AppStore>(
             models: [model],
             builder: (context  ,model){
               if(model.connectionState==ConnectionState.waiting){
                 return  CircularProgressIndicator();
               }else if(model.connectionState==ConnectionState.none){
                 return Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.end,
                     children:model.state.events.map((e) => ListTile(
                       title: Text(e.name),

                     )).toList()
                 ) ;
               }else{
                 return Text('wait');
               }
             },
           )

        ],),
    );
  }
}