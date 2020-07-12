import 'dart:convert';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:muaazin/dataSources/i_api.dart';
import 'package:muaazin/dataSources/shared_pref_data.dart';
import 'package:muaazin/models/auto_model.dart';
import 'package:muaazin/models/daily_events.dart';
import 'package:muaazin/models/notification_data.dart';
import 'package:muaazin/utils/location_info.dart';
import 'package:muaazin/utils/network_info.dart';
import 'package:muaazin/utils/notification_sevices.dart';

class AppStore {


List prays;
int  nextPray;
int  currentPray;
List<NotificationData> notifications;
List<Event> events;
AudioCache _audioController;
LocationInfo _locationInfo;
NetworkInfo _networkInfo;
LocalData _localData;
NotificationPlugin _notificationPlugin;
IApi api;



 AudioPlayer player;
AppStore(this._networkInfo , this.api ,this._locationInfo ,this._localData )  {
 _audioController = AudioCache();
 _locationInfo =LocationInfo();
 player = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
 _notificationPlugin = new NotificationPlugin();
 fetchData();

}



Future<AppModel > fetchData() async{
  AppModel result;

   if(await _networkInfo.isConnected){
    
    
    if(await _locationInfo.isEnabled()){
      double lon ,lat;
     var info = await  _locationInfo.getDeviceLocation();
     lon= info.longitude;
     lat = info.latitude;


      result =await api.fetchDataWithCoordinates(lat, lon);
     prays = [{'time':json.decode(result.timing.toString())['Fajr'] ,'name':'fajr'} ,
      {'time':json.decode(result.timing.toString())['Dhuhr'] ,'name':'dhuhr'} ,
      {'time':json.decode(result.timing.toString())['Asr']  ,'name':'asr'},
      {'time':json.decode(result.timing.toString())['Maghrib'] ,'name':'maghrib'},
      {'time':json.decode(result.timing.toString())['Isha'] , 'name':'ishaa'}    ];



return result;


 }else{
   print('knkdnfkdnfkndkfnkdnkf');
result =await api.fetchDataFromApi();


prays = [{'time':result.timing['Fajr'] ,'name':'fajr'} ,
      {'time':result.timing['Dhuhr'] ,'name':'dhuhr'} ,
      {'time':result.timing['Asr']  ,'name':'asr'},
      {'time':result.timing['Maghrib'] ,'name':'maghrib'},
      {'time':result.timing['Isha'] , 'name':'ishaa'}    ];

      notifications=[
    NotificationData(description: 'قم إلى الصلاة يا عبد الله' ,title:'حان الان موعد صلاة الفجر'  ,hour: 19 ,minute: 50) ,

  NotificationData(description: 'قم إلى الصلاة يا عبد الله' ,title:'حان الان موعد صلاة الفجر'  ,hour: int.parse((prays[0]['time']).toString().substring(0,2)) ,minute: int.parse((prays[0]['time']).toString().substring(3))) ,

  NotificationData(description: 'قم إلى الصلاة يا عبد الله' ,title:'حان الان موعد صلاة الفجر'  ,hour: int.parse((prays[1]['time']).toString().substring(0,2)) ,minute: int.parse((prays[1]['time']).toString().substring(3))) ,
    NotificationData(description: 'قم إلى الصلاة يا عبد الله' ,title:'حان الان موعد صلاة الفجر'  ,hour: int.parse((prays[2]['time']).toString().substring(0,2)) ,minute: int.parse((prays[2]['time']).toString().substring(3))) ,
  NotificationData(description: 'قم إلى الصلاة يا عبد الله' ,title:'حان الان موعد صلاة الفجر'  ,hour: int.parse((prays[3]['time']).toString().substring(0,2)) ,minute: int.parse((prays[3]['time']).toString().substring(3))) ,
  NotificationData(description: 'قم إلى الصلاة يا عبد الله' ,title:'حان الان موعد صلاة الفجر'  ,hour: int.parse((prays[4]['time']).toString().substring(0,2)) ,minute: int.parse((prays[4]['time']).toString().substring(3))  ) ,








];

await _localData.saveData(result);
await _localData.saveNotifications(notifications);

print('${int.parse((prays[1]['time']).toString().substring(0,2))}/////////////////////////////////////////////');
return result;

 }
  
}

else{
   if(await _localData.hasData()){
print('jojojjjjojojojojjojojojjojojoj');
var data = await _localData.getDataFromShardPrefs();
prays = [{'time':data.timing['Fajr'] ,'name':'fajr'} ,
      {'time':data.timing['Dhuhr'] ,'name':'dhuhr'} ,
      {'time':data.timing['Asr']  ,'name':'asr'},
      {'time':data.timing['Maghrib'] ,'name':'maghrib'},
      {'time':data.timing['Isha'] , 'name':'ishaa'}    ];


notifications=[
  NotificationData( id: 'fajr',notificationId: 0 ,    description: 'قم إلى الصلاة يا عبد الله' ,title:'حان الان موعد صلاة الفجر'  ,hour: 13 ,minute: 59) ,
  NotificationData(id: 'dhuhr',notificationId: 0 , description: 'قم إلى الصلاة يا عبد الله' ,title:'حان الان موعد صلاة الفجر'  ,hour: int.parse((prays[0]['time']).toString().substring(0,2)) ,minute: int.parse((prays[0]['time']).toString().substring(3))) ,

  NotificationData(id: 'asr',notificationId: 0 , description: 'قم إلى الصلاة يا عبد الله' ,title:'حان الان موعد صلاة الفجر'  ,hour: int.parse((prays[1]['time']).toString().substring(0,2)) ,minute: int.parse((prays[0]['time']).toString().substring(3))) ,
    NotificationData(id: 'maghrib',notificationId: 0 , description: 'قم إلى الصلاة يا عبد الله' ,title:'حان الان موعد صلاة الفجر'  ,hour: int.parse((prays[2]['time']).toString().substring(0,2)) ,minute: int.parse((prays[0]['time']).toString().substring(3))) ,
  NotificationData(id: 'isha',notificationId: 0 , description: 'قم إلى الصلاة يا عبد الله' ,title:'حان الان موعد صلاة الفجر'  ,hour: int.parse((prays[3]['time']).toString().substring(0,2)) ,minute: int.parse((prays[0]['time']).toString().substring(3))) ,
  NotificationData(id: 'kkkk',notificationId: 0 , description: 'قم إلى الصلاة يا عبد الله' ,title:'حان الان موعد صلاة الفجر'  ,hour: int.parse((prays[4]['time']).toString().substring(0,2)) ,minute: int.parse((prays[0]['time']).toString().substring(3))) ,


];
events =[
  Event( 0 ,'صلاة العصر' , int.parse((prays[0]['time']).toString().substring(0,2)),int.parse((prays[0]['time']).toString().substring(3))) ,
  Event( 0 ,'صلاة العصر' , int.parse((prays[1]['time']).toString().substring(0,2)),int.parse((prays[0]['time']).toString().substring(3))) ,
  Event( 0 ,'صلاة العصر' , int.parse((prays[2]['time']).toString().substring(0,2)),int.parse((prays[0]['time']).toString().substring(3))) ,
  Event( 0 ,'صلاة العصر' , int.parse((prays[3]['time']).toString().substring(0,2)),int.parse((prays[0]['time']).toString().substring(3))) ,
  Event( 0 ,'صلاة العصر' , int.parse((prays[4]['time']).toString().substring(0,2)),int.parse((prays[0]['time']).toString().substring(3))) ,

];
_notificationPlugin.scheduleAllNotifications(notifications);

await addNotifications(notifications);
result= data;
return result;
   }
 }


return result;
}

Future<void>  addNotifications(List<NotificationData> myNotifications) async{
  await _notificationPlugin.scheduleAllNotifications(myNotifications);
}

Future<void> startAzan() async{
player = await _audioController.play('azan.mp3');
}
Future stopAzan() async{
player?.stop();
}





  
}