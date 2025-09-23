import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class PlayerController extends GetxController {

  late VideoPlayerController videoController;
  late ChewieController chewieController;

  final titleView = ''.obs;
  final isPlayerReady = false.obs;

  Future<void> initializePlayer() async {
    if (videoUrl.isNotEmpty) {
      print("Video URL: $videoUrl");
      videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl),
          videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true,
              webOptions: VideoPlayerWebOptions(allowRemotePlayback: true)));

      await videoController.initialize()
          .onError((x, i) {

          Get.snackbar('Erro', 'Não foi possível carregar o vídeo.', duration: Duration(seconds: 3));
          Get.back();

          })
          .catchError((error) {
        Get.snackbar('Erro', 'Não foi possível carregar o vídeo.', duration: Duration(seconds: 3));
        Get.back();
      });

      chewieController = ChewieController(
        videoPlayerController: videoController,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        errorBuilder: (ctx, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );

        },
        additionalOptions: (context) =>
        [
          OptionItem(
            onTap: (ctx) {},
            iconData: Icons.settings,
            title: 'Configurações',
          ),
        ],
      );

      titleView.value = channelName;
      isPlayerReady.value = true;
    }
  }

  late String videoUrl;
  late String channelName;

  @override
  void onInit() {
    super.onInit();
    // get parameters from Get.arguments
    final args = Get.arguments as Map<String, dynamic>?;
    videoUrl = args?['videoUrl'] as String? ?? '';
    channelName = args?['channelName'] as String? ?? 'Não encontrado';
    initializePlayer();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    videoController.dispose();
    chewieController.dispose();
    super.onClose();
  }
}
