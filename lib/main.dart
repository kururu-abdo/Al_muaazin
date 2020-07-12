import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:muaazin/dataSources/i_api.dart';
import 'package:muaazin/dataSources/shared_pref_data.dart';
import 'package:muaazin/stores/app_store.dart';
import 'package:muaazin/utils/app_injector.dart';
import 'package:muaazin/utils/location_info.dart';
import 'package:muaazin/utils/network_info.dart';
import 'package:muaazin/utils/notification_sevices.dart';
import 'package:muaazin/utils/show_not.dart';
import 'package:muaazin/widgets/auto_timing.dart';
import 'package:muaazin/widgets/city_date_info.dart';
import 'package:muaazin/widgets/header.dart';
import 'package:muaazin/widgets/responsive_safe_area.dart';
import 'package:muaazin/widgets/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:schedule_controller/schedule_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

/// The name associated with the UI isolate's [SendPort].
const String isolateName = 'isolate';

/// A port used to communicate from a background isolate to the UI isolate.
final ReceivePort port = ReceivePort();

void main()  async{
setupLocator();
WidgetsFlutterBinding.ensureInitialized();


// Register the UI isolate's SendPort to allow for communication from the
// background isolate.
IsolateNameServer.registerPortWithName(
  port.sendPort,
  isolateName,
);
  runApp(MyApp());



}

class MyApp extends StatelessWidget {
  var _androidAppRetain = MethodChannel("send_app_to_background");
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
        if (Platform.isAndroid) {
          if (Navigator.of(context).canPop()) {
            return Future.value(true);
          } else {
            _androidAppRetain.invokeMethod("sendToBackground");
            return Future.value(false);
          }
        } else {
          return Future.value(true);
        }},
          child: Injector(
            inject: [

Inject<SharedPreferences>.future(() async =>  await SharedPreferences.getInstance()) ,

              Inject(()=>DataConnectionChecker()),
              Inject(()=>Dio()),
              Inject<Client>(()=>Client()),
              Inject<IApi>(() => IApiImpl(Injector.get() ,Injector.get())),


              Inject<LocalData>(() => LocalImpl( )),
              Inject(()=>LocationInfo()),
              Inject<NetworkInfo>(() => NetworkInfoImp(Injector.get() )),


              Inject(()async{
                var prefs =await SharedPreferences.getInstance();
                return prefs;
              }),


              Inject<AppStore>(()=>AppStore(Injector.get() ,Injector.get(),Injector.get(),Injector.get())),
            ],


          builder: (context){
              return    MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Al muaazin',

                  theme: ThemeData(

                  primarySwatch: Colors.blue,

                  visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
            home: SplashScreen()


            ,
            );
          },

      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
 
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var notifcation = NotificationPlugin();
ScheduleController controller;
@override
  void initState() {
initAzan();
AndroidAlarmManager.initialize();


// Register for events from the background isolate. These messages will
  // always coincide with an alarm firing.
  port.listen((_) async => await showNotification());

  }
void initAzan()async{


}

 Future<void> showNotification() async {
   print('Increment counter!');


 }
 //the background
 static SendPort uiSendPort;


// The callback for our alarm
  static Future<void> callback() async {
  var store = GetIt.I<AppStore>();


  await store.startAzan();



    // This will be null if we're running in the background.
    uiSendPort ??= IsolateNameServer.lookupPortByName(isolateName);
    uiSendPort?.send(null);
  }


  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      
      body:ResponsiveSafeArea(
        builder:(context  ,size){
           return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Header() ,
            Info() ,
            AutoWidget() 
          ]
        );
        }
      )
    );
  }
}
