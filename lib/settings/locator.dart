import 'package:get_it/get_it.dart';

import '../service/common_service.dart';
import '../service/language_change_provider.dart';
import '../service/navigation_service.dart';
import '../service/network_service.dart';
import '../service/shared_service.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => CommonService());
  locator.registerLazySingleton(() => NetworkService());
  locator.registerLazySingleton(() => SharedService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => LanguageChangeProvider());
}
