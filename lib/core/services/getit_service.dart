import 'package:fruit_market_dashboard/core/services/fire_storage.dart';
import 'package:fruit_market_dashboard/core/services/storage_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<StorageService>(FireStorage());
}
