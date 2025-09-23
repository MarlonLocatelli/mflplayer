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
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: seriesController.groupTitlesSeries.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                seriesController.setGroupTitle(seriesController.groupTitlesSeries[index]);
                Get.toNamed(Routes.SERIES_LIST_DETAILS);
              },
              child: Card(
                elevation: 2,
                child: Center(
                  child: Text(
                    seriesController.groupTitlesSeries[index],
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),),
            );
          },)
    );
  }
}
