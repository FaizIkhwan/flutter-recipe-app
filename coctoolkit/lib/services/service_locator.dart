import 'package:get_it/get_it.dart';
import 'package:coctoolkit/business_logic/view_models/test_view_model.dart';
import 'package:coctoolkit/services/navigation/navigation_service.dart';
import 'package:coctoolkit/services/shared_preferences/shared_preferences_service.dart';
import 'package:coctoolkit/services/web_api/web_api.dart';
import 'package:coctoolkit/services/web_api/web_api_fake.dart';
import 'package:coctoolkit/services/web_api/web_api_implementation.dart';

GetIt serviceLocator = GetIt.instance;

Future setupServiceLocator() async {
  // services
  serviceLocator.registerLazySingleton<WebApi>(() => WebApiImplementation()); // For live API
  // serviceLocator.registerLazySingleton<WebApi>(() => WebApiFake()); // For fake API
  serviceLocator.registerLazySingleton(() => NavigationService());
  var instance = await SharedPreferencesService.getInstance();
  serviceLocator.registerSingleton<SharedPreferencesService>(instance);

  // view models
  serviceLocator.registerFactory<TestViewModel>(() => TestViewModel());
}