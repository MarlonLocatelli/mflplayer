import 'package:get/get.dart';
import 'package:mflplayer/app/data/database/databaseHelper.dart';

class HomeController extends GetxController {

  final isLoading = false.obs;

  List<String> get typesContent => ['Canais ao vivo', 'Filmes', 'Séries'];
  final dbHelper = Get.find<DatabaseHelper>();

  // Metodo para limpar os dados carregados
  Future<void> clearData() async {
    isLoading.value = true;
    // Chama o database para limpar os dados
    await dbHelper.clearDatabase();

    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    //loadM3uFile();
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
