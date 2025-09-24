import 'package:get/get.dart';
import 'package:mflplayer/app/data/dao/m3u_item_dao.dart';
import 'package:mflplayer/app/data/model/m3u_item.dart';

class SeriesController extends GetxController {

  final _m3uDao = Get.find<M3UItemDao>();
  final groupTitle = ''.obs;
  final listDetailsTitles = <M3UItem>[].obs;
  final listSeries = <M3UItem>[].obs;

  void loadSeries() async {
    var channels = await _m3uDao.getItemsByGroupTitle(groupTitle.value);
    listSeries.assignAll(channels);
  }

  void initListDetailsTitles(String? group) async {
    var items = await _m3uDao.getItemsByGroupTitleWithGroupBy(group ?? groupTitle.value);
    listDetailsTitles.assignAll(items);
  }

  void setGroupTitle(String title) {
    groupTitle.value = title;
  }

  @override
  void onInit() {
    super.onInit();
    initListDetailsTitles("series");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
