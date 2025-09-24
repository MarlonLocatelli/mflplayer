import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mflplayer/app/bindings/initial_binding.dart';

import 'app/routes/app_pages.dart';

void main() {

  runApp(
    GetMaterialApp(
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
