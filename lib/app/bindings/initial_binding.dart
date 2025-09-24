import 'package:get/get.dart';
import 'package:mflplayer/app/data/dao/m3u_item_dao.dart';
import 'package:mflplayer/app/data/database/databaseHelper.dart';
import 'package:mflplayer/app/data/repository/auth_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DatabaseHelper>(DatabaseHelper(), permanent: true);
    Get.lazyPut<M3UItemDao>(
          () => M3UItemDao(),
      fenix: true,
    );

    Get.lazyPut<AuthRepository>(
          () => AuthRepository(),
      fenix: true,
    );
  }
}
