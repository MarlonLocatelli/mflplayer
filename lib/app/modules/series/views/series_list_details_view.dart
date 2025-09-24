import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mflplayer/app/data/model/m3u_item.dart';
import 'package:mflplayer/app/modules/series/controllers/series_controller.dart';
import 'package:mflplayer/app/routes/app_pages.dart';

class SeriesListDetailsView extends GetView {
  final SeriesController seriesController = Get.find<SeriesController>();

  SeriesListDetailsView({super.key});

  @override
  Widget build(BuildContext context) {

    seriesController.loadSeries();

    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(seriesController.groupTitle.value)),
          centerTitle: true,
        ),
        body: Obx(() => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: seriesController.listSeries.length,
            itemBuilder: (context, index) {
              M3UItem channel = seriesController.listSeries[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PLAYER, arguments: {
                    'videoUrl': channel.url,
                    'channelName': channel.name
                  });
                },
                child: Card(
                  elevation: 2,
                  child: Center(
                    child: Text(
                      channel.name,
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
