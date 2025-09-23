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
          title: const Text('Canais ao vivo'),
          centerTitle: true,
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 colunas
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.5,
          ),
          itemCount: movieController.groupTitlesMovies.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                movieController.setGroupTitle(movieController.groupTitlesMovies[index]);
                Get.toNamed(Routes.MOVIE_LIST_DETAILS);
              },
              child: Card(
                elevation: 2,
                child: Center(
                  child: Text(
                    movieController.groupTitlesMovies[index],
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),),
            );
          },)
    );
  }
}
