import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:m3u_parser_nullsafe/m3u_parser_nullsafe.dart';
import 'package:mflplayer/app/modules/movie/controllers/movie_controller.dart';
import 'package:mflplayer/app/routes/app_pages.dart';

class MoviesListDetailsView extends GetView {
  final MovieController movieController = Get.find<MovieController>();
  MoviesListDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(movieController.groupTitle.value)),
          centerTitle: true,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: movieController.detailsGroupTitles.length,
          itemBuilder: (context, index) {
            M3uItem channel = movieController.detailsGroupTitles[index];
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
