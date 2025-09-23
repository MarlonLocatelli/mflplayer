import 'package:get/get.dart';
import 'package:mflplayer/app/data/repository/auth_repository.dart';
import 'package:mflplayer/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HomeController>(
      HomeController(),
      permanent: true,
    );
  }
}
