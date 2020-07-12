import 'package:dio/dio.dart';
import 'package:muaazin/exceptions/network_exceptions.dart';
import 'package:muaazin/models/auto_model.dart';
import 'package:muaazin/utils/constants.dart';
import 'package:muaazin/utils/network_info.dart';

abstract class IApi{
  Future<AppModel> fetchDataFromApi();

  Future<AppModel> fetchDataWithCoordinates(double lat ,double lon) ;
}
class IApiImpl implements IApi{
  NetworkInfo _networkInfo;
  Dio _dio;

  IApiImpl(this._dio ,this._networkInfo){

  }

  @override
  Future<AppModel> fetchDataFromApi()  async{
    AppModel model;

 //   try {
      var result = await _dio.get(ByCity);

 model = AppModel.fromJson(result.data);
 print(result.data.toString());

print(model.city+"/////////////////////////////////////////////////////////////////////////");


    // } catch (e) {
    //   throw NetworkException('there is a problem with network connection');
    // }


    
  

return model;
  }

  @override
  Future<AppModel> fetchDataWithCoordinates(double lat ,double lon)  async{
    AppModel model;
  
    try {
      var result = await _dio.get(ByCoordinates+"latitude=${lat}&longitude=${lon}&method=2");

 model = AppModel.fromJson(result.data);


print(model.city+"/////////////////////////////////////////////////////////////////////////");

    } catch (e) {
      throw NetworkException('there is a problem with network connection');
    }


    
  

return model;
  }

}