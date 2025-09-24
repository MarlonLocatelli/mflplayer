import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mflplayer/app/data/repository/auth_repository.dart';
import 'package:mflplayer/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final urlTextEditController = TextEditingController();
  final AuthRepository _repository = Get.find<AuthRepository>();
  final isLoading = false.obs;

  Future<void> createFile() async {
    isLoading.value = true;
    var result = await _repository.createFile(urlTextEditController.text);

    if (result) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar('Erro', 'Falha ao carregar a playlist. Verifique a URL.',
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.value = false;
  }

  void _checkFileAndRedirect() async {
    isLoading.value = true;
    var resultCheck = await _repository.checkExistData();
    if (resultCheck) {
      Get.offAllNamed(Routes.HOME);
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    _checkFileAndRedirect();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    urlTextEditController.dispose();
    super.onClose();
  }
}
