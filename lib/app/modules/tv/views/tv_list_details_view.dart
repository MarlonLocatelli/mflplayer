import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mflplayer/app/data/model/m3u_item.dart';
import 'package:mflplayer/app/modules/tv/controllers/tv_controller.dart';
import 'package:mflplayer/app/routes/app_pages.dart';

@immutable
class TvListDetailsView extends GetView {

  TvListDetailsView({super.key});

  TvController tvController = Get.find<TvController>();

  @override
  Widget build(BuildContext context) {

    // Load channels for the current group title
    tvController.loadChannels();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(tvController.groupTitle.value)),
        centerTitle: true,
      ),
        body: Obx(() => ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tvController.listChannels.length,
            itemBuilder: (context, index) {
              M3UItem channel = tvController.listChannels[index];
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
