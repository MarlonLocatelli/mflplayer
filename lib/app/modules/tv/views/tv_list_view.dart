import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mflplayer/app/routes/app_pages.dart';

import '../controllers/tv_controller.dart';

class TvListView extends GetView<TvController> {

  final TvController tvController = Get.find<TvController>();

  TvListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Canais ao vivo'),
        centerTitle: true,
      ),
      body: Obx(() => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: tvController.listDetailsTitles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                tvController.setGroupTitle(tvController.listDetailsTitles[index].groupTitle);
                Get.toNamed(Routes.TV_LIST_DETAILS);
              },
              child: Card(
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                  child: Text(
                    tvController.listDetailsTitles[index].groupTitle,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                                ),
                ),),
            );
          },),
      )
    );
  }
}
