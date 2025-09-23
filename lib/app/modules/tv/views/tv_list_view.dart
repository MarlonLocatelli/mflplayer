import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mflplayer/app/modules/tv/views/tv_list_details_view.dart';
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
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 colunas
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 2.5,
        ),
        itemCount: tvController.groupTitlesLiveChannels.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              tvController.setGroupTitle(tvController.groupTitlesLiveChannels[index]);
              Get.toNamed(Routes.TV_LIST_DETAILS);
            },
            child: Card(
              elevation: 2,
              child: Center(
              child: Text(
                tvController.groupTitlesLiveChannels[index],
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),),
          );
        },)
    );
  }
}
