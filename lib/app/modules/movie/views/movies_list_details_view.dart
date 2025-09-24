import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mflplayer/app/data/model/m3u_item.dart';
import 'package:mflplayer/app/modules/movie/controllers/movie_controller.dart';
import 'package:mflplayer/app/routes/app_pages.dart';

class MoviesListDetailsView extends GetView {
  final MovieController movieController = Get.find<MovieController>();
  MoviesListDetailsView({super.key});
  @override
  Widget build(BuildContext context) {

    movieController.loadMovies();

    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(movieController.groupTitle.value)),
          centerTitle: true,
        ),
        body: Obx(() =>ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: movieController.listMovies.length,
            itemBuilder: (context, index) {
              M3UItem channel = movieController.listMovies[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PLAYER, arguments: {
                    'videoUrl': channel.url,
                    'channelName': channel.tvgName,
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
