import 'package:get/get.dart';
import 'package:mflplayer/app/data/dao/m3u_item_dao.dart';
import 'package:mflplayer/app/data/model/m3u_item.dart';

class MovieController extends GetxController {

  final _m3uDao = Get.find<M3UItemDao>();
  final groupTitle = ''.obs;
  final listDetailsTitles = <M3UItem>[].obs;
  final listMovies = <M3UItem>[].obs;

  void setGroupTitle(String title) {
    groupTitle.value = title;
  }

  void loadMovies() async {
    var channels = await _m3uDao.getItemsByGroupTitle(groupTitle.value);
    listMovies.assignAll(channels);
  }

  void initListDetailsTitles(String? group) async {
    var items = await _m3uDao.getItemsByGroupTitleWithGroupBy(group ?? groupTitle.value);
    listDetailsTitles.assignAll(items);
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    initListDetailsTitles("filmes");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
