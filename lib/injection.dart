import 'package:freshmarket/config/api/api.dart';
import 'package:freshmarket/config/api/base_api.dart';
import 'package:freshmarket/navigation/navigation_utils.dart';
import 'package:freshmarket/providers/voucher_providers.dart';
import 'package:freshmarket/service/address_service.dart';
import 'package:freshmarket/service/category_product_service.dart';
import 'package:freshmarket/service/category_service.dart';
import 'package:freshmarket/service/product_service.dart';
import 'package:freshmarket/service/voucher_service.dart';
import 'package:get_it/get_it.dart';


GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  /// Registering api
  if (locator.isRegistered(instance: Api()) == false) {
    locator.registerSingleton(Api());
  }
  if (locator.isRegistered(instance: BaseAPI()) == false) {
    locator.registerSingleton(BaseAPI());
  }

  locator.registerSingleton(NavigationUtils());

  /// Registering services
  locator.registerLazySingleton(() => CategoryService(locator<BaseAPI>()));
  locator.registerLazySingleton(() => CategoryProductService(locator<BaseAPI>()));
  locator.registerLazySingleton(() => VoucherService(locator<BaseAPI>()));
  locator.registerLazySingleton(() => ProductService(locator<BaseAPI>()));
  locator.registerLazySingleton(() => AddressService(locator<BaseAPI>()));
}
