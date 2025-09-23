import 'dart:collection';

import 'package:get/get.dart';
import 'package:m3u_parser_nullsafe/m3u_parser_nullsafe.dart';
import 'package:mflplayer/app/data/repository/auth_repository.dart';

class HomeController extends GetxController {

  final AuthRepository _repositoryAuth = Get.find<AuthRepository>();

  M3uList? m3uList;
  final dataM3u = ''.obs;
  final isLoading = false.obs;

  // Metodo que faça um split da lista de groupTitles em 3 listas diferentes
  // Uma para cada tipo de conteúdo (Canais ao vivo, Filmes, Séries)
  List<String> get groupTitlesLiveChannels {
    return m3uList?.groupTitles.where((title) =>
    title.toLowerCase().contains('canais') ||
        title.toLowerCase().contains('live') ||
        title.toLowerCase().contains('tv') ||
        title.toLowerCase().contains('channel')).toList() ?? [];
  }

  List<String> get groupTitlesMovies {
    return m3uList?.groupTitles.where((title) =>
    title.toLowerCase().contains('filmes') ||
        title.toLowerCase().contains('movie') ||
        title.toLowerCase().contains('film')).toList() ?? [];
  }

  List<String> get groupTitlesSeries {
    return m3uList?.groupTitles.where((title) =>
        title.toLowerCase().contains('series')).toList() ?? [];
  }

  UnmodifiableListView<String> get groupTitles =>
      m3uList?.groupTitles ?? UnmodifiableListView([]);

  List<String> get typesContent => ['Canais ao vivo', 'Filmes', 'Séries'];

  void loadM3uFile() async {
    isLoading.value = true;
    var data = await _repositoryAuth.loadOfFilePlaylist();
    dataM3u.value = data;
    m3uList = M3uList.load(data);
    isLoading.value = false;
  }


  @override
  void onInit() {
    super.onInit();
    loadM3uFile();
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
