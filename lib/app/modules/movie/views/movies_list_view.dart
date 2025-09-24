import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mflplayer/app/routes/app_pages.dart';

import '../controllers/movie_controller.dart';

class MovieListView extends GetView<MovieController> {
  final MovieController movieController = Get.find<MovieController>();
  MovieListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Filmes'),
          centerTitle: true,
        ),
        body: Obx(() =>
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: movieController.listDetailsTitles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  movieController.setGroupTitle(movieController.listDetailsTitles[index].groupTitle);
                  Get.toNamed(Routes.MOVIE_LIST_DETAILS);
                },
                child: Card(
                  elevation: 2,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        movieController.listDetailsTitles[index].groupTitle ?? '',
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
