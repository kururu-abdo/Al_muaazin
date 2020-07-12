import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:muaazin/dataSources/i_api.dart';
import 'package:muaazin/dataSources/shared_pref_data.dart';
import 'package:muaazin/stores/app_store.dart';
import 'package:muaazin/utils/location_info.dart';
import 'package:muaazin/utils/network_info.dart';


var locator = GetIt.instance();
void setupLocator() {

//app store
locator.registerFactory<AppStore>(() => AppStore(locator() ,locator() ,locator() ,locator()));

//network info
locator.registerFactory<NetworkInfo>(() =>NetworkInfoImp(locator()));

//
locator.registerLazySingleton(() => DataConnectionChecker());

locator.registerLazySingleton<IApi>(() => IApiImpl(locator(), locator()));

locator.registerFactory(() =>Dio());

locator.registerFactory<LocationInfo>(() => LocationInfo());

locator.registerFactory<LocalData>(() => LocalImpl());


}