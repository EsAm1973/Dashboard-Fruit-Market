import 'package:fruit_market_dashboard/core/repos/images_repo/image_repo.dart';
import 'package:fruit_market_dashboard/core/repos/images_repo/image_repo_implementation.dart';
import 'package:fruit_market_dashboard/core/repos/product_repos/product_repo.dart';
import 'package:fruit_market_dashboard/core/repos/product_repos/product_repo_implementation.dart';
import 'package:fruit_market_dashboard/core/services/database_service.dart';
import 'package:fruit_market_dashboard/core/services/fire_storage.dart';
import 'package:fruit_market_dashboard/core/services/firestore_service.dart';
import 'package:fruit_market_dashboard/core/services/storage_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<StorageService>(FireStorage());
  getIt.registerSingleton<DatabaseService>(FirestoreService());
  getIt.registerSingleton<ImageRepo>(
    ImageRepoImplementation(storageService: getIt.get<StorageService>()),
  );
  getIt.registerSingleton<ProductRepo>(
    ProductRepoImplementation(databaseService: getIt.get<DatabaseService>()),
  );
}
