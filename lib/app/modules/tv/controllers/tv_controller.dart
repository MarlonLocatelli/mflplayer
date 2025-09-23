import 'dart:collection';

import 'package:get/get.dart';
import 'package:m3u_parser_nullsafe/m3u_parser_nullsafe.dart';
import 'package:mflplayer/app/modules/home/controllers/home_controller.dart';

class TvController extends GetxController {

  final HomeController _homeController = Get.find<HomeController>();

  final groupTitle = ''.obs;

  List<String> get groupTitlesLiveChannels =>
      _homeController.groupTitlesLiveChannels;

  List<M3uItem> get detailsGroupTitles {
    return _homeController.m3uList?.items
            .where((item) => item.groupTitle == groupTitle.value)
            .toList() ??
        [];
  }

  void setGroupTitle(String title) {
    groupTitle.value = title;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    groupTitle.value = '';
    super.onClose();
  }
}
