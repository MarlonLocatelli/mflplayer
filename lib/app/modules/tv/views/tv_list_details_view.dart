import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:m3u_parser_nullsafe/m3u_parser_nullsafe.dart';
import 'package:mflplayer/app/modules/tv/controllers/tv_controller.dart';
import 'package:mflplayer/app/routes/app_pages.dart';

class TvListDetailsView extends GetView {

  TvListDetailsView({super.key});

  TvController tvController = Get.find<TvController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(tvController.groupTitle.value)),
        centerTitle: true,
      ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: tvController.detailsGroupTitles.length,
          itemBuilder: (context, index) {
            M3uItem channel = tvController.detailsGroupTitles[index];
            return GestureDetector(
              onTap: () {
                  Get.toNamed(Routes.PLAYER, arguments: {
                    'videoUrl': channel.link,
                    'channelName': channel.title
                  });
              },
              child: Card(
                elevation: 2,
                child: Center(
                  child: Text(
                    channel.title,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),),
            );
          },)
    );
  }
}
