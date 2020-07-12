import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:muaazin/models/auto_model.dart';
import 'package:muaazin/models/daily_events.dart';
import 'package:muaazin/models/notification_data.dart';
import 'package:muaazin/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalData {
  Future saveData(AppModel model);

Future<AppModel> getDataFromShardPrefs();


Future<void> saveNotifications(List<NotificationData> data);
Future<List<NotificationData>> getNotications();

Future<bool> hasData();
Future createEvents(List<Event> data);
Future<List<Event>> getEvents();

Future getCurrentEvent();
Future getNextEvent();
}

class LocalImpl  implements LocalData{

  @override
  Future changeAppMode(String type)  async{
    SharedPreferences pref =await SharedPreferences.getInstance();
  await pref.setString(TYPE, type);
  }

  @override
  Future<AppModel> getDataFromShardPrefs()  async{
    SharedPreferences pref =await SharedPreferences.getInstance();
var date =await pref.getString(DATE) ;
var day = await pref.getString(DAY) ;
var city = await pref.getString(CITY) ;
var timings = json.decode(await pref.getString(TIMING) );
print(city);

return AppModel(date ,day  ,city ,timings);

  }

  @override
  Future<bool> hasData()  async{
    SharedPreferences pref =await SharedPreferences.getInstance();
return await pref.containsKey(NOTIFIES);
  }

  @override
  Future<String> loadMode()  async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    return await pref.getString(TYPE);
  }

  @override
  Future saveData(AppModel model)  async{
    SharedPreferences pref =await SharedPreferences.getInstance();
        await pref.setString(DATE, model.date.toString());
            await pref.setString(DAY, model.day);

               await pref.setString(CITY, model.city);
                await pref.setString(TIMING, json.encode(model.timing));


   
  }

  @override
  Future createEvents(List<Event> data)  async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    await pref.setString(EVENTS ,jsonEncode(data) );
  }

  @override
  Future getCurrentEvent()  async{
    SharedPreferences pref =await SharedPreferences.getInstance();
   return  pref.getInt(currentEvent);
  }

  @override
  Future getNextEvent() async {
    SharedPreferences pref =await SharedPreferences.getInstance();
     return  pref.getInt(nextEvent);
  }

  @override
  Future<List<Event>> getEvents() async {
    SharedPreferences pref =await SharedPreferences.getInstance();
  var data= await pref.getString(EVENTS);

List<Event> events = json.decode(data);


return events;

  }

  @override
  Future<List<NotificationData>> getNotications()  async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    var data = await  pref.getString(NOTIFIES);
   List<NotificationData>  events = json.decode(data) ;



return events;
  }

  @override
  Future<void> saveNotifications(List<NotificationData> data)  async{
    SharedPreferences pref =await SharedPreferences.getInstance();
 await pref.setString( NOTIFIES
, json.encode(data));
  }

}