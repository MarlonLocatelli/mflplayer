import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mflplayer/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bem vindo!'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'sair') {
                // Implemente a lógica de logout aqui
                await homeController.clearData();
                Get.offAllNamed(Routes.AUTH);
              } else if (value == 'configurar') {
                // Navegue para a tela de configurações
                Get.toNamed(Routes.SETTINGS);
              } else if (value == 'atualizar') {
                // Chame o método de atualização
                //homeController.atualizar();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'configurar',
                child: Text('Configurar'),
              ),
              const PopupMenuItem(
                value: 'atualizar',
                child: Text('Atualizar'),
              ),
              const PopupMenuItem(
                value: 'sair',
                child: Text('Sair'),
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          itemCount: homeController.typesContent.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  Get.toNamed(Routes.TV);
                } else if (index == 1) {
                  Get.toNamed(Routes.MOVIE);
                } else if (index == 2) {
                  Get.toNamed(Routes.SERIES);
                }
              },
              child: Card(
                elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      homeController.typesContent[index],
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          },
      )
    );
  }
}
