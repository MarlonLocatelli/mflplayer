import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mflplayer/app/routes/app_pages.dart';

import '../controllers/series_controller.dart';

class SeriesListView extends GetView<SeriesController> {

  final SeriesController seriesController = Get.find<SeriesController>();

  SeriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Series'),
          centerTitle: true,
        ),
        body: Obx(() => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: seriesController.listDetailsTitles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  seriesController.setGroupTitle(seriesController.listDetailsTitles[index].groupTitle);
                  Get.toNamed(Routes.SERIES_LIST_DETAILS);
                },
                child: Card(
                  elevation: 2,
                  child: Center(
                    child: Text(
                      seriesController.listDetailsTitles[index].groupTitle,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),),
              );
            },),
        )
    );
  }
}
