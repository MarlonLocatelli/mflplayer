import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mflplayer/app/data/repository/auth_repository.dart';

import 'app/routes/app_pages.dart';

void main() {

  Get.lazyPut<AuthRepository>(
    () => AuthRepository(),
    fenix: true,
  );

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
