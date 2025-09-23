import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';

import '../controllers/player_controller.dart';

class PlayerView extends GetView<PlayerController> {

  PlayerView({super.key});

  final PlayerController playerController = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Obx(() => Text(playerController.titleView.value)), centerTitle: true,),
      body: Obx(() {
        if (!playerController.isPlayerReady.value) {
          return Center(child: CircularProgressIndicator());
        } else {
        return Chewie(controller: playerController.chewieController);
        }
      }
    ));
  }
}
