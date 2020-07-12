import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationInfo{


  Future<bool> isEnabled() async{
return   await Permission.locationWhenInUse.serviceStatus.isEnabled;


}
Future<Position> getDeviceLocation() async{
  Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);


return position;
}

}