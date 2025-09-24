import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:mflplayer/app/data/dao/m3u_item_dao.dart';
import 'package:mflplayer/app/data/model/m3u_item.dart';
import 'package:mflplayer/app/data/services/auth_service.dart';
import 'package:path_provider/path_provider.dart';

class AuthRepository {
  final M3UItemDao _m3uDao = Get.find<M3UItemDao>();

  Future<bool> createFile(String baseUrl) async {

    //print("URL: $baseUrl");
    AuthService service = AuthService(Dio(), baseUrl: baseUrl);

    // Request para baixar o arquivo M3U
    var result = await service.fromUrlM3u();

    // Verifica se a resposta foi bem-sucedida
    if (result.response.statusCode == 200 && result.data.isNotEmpty) {
      // Parse do result
      var listItems = M3UItem.parseM3U(result.data);
      print("TEM ITENS ${listItems.length}");

      if (listItems.isNotEmpty) {
        // Salva o arquivo em cache
        _m3uDao.insertBatchPartitioned(listItems);
        return true;
      }
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'Erro',
        message: 'Falha ao carregar a playlist. Verifique a URL.',
        duration: Duration(seconds: 3),
      ));
    }

    return false;
  }

  Future<bool> checkExistData() async {
    return await _m3uDao.hasData();
  }

  // Método para salvar o arquivo baixado em cache
  Future<bool> saveFilePlaylist(String content) async {
    try {
      // Obtém o diretório de cache do aplicativo
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/playlist.m3u';

      // Cria o arquivo e escreve o conteúdo
      final file = File(filePath);
      await file.writeAsString(content);
      print('Arquivo salvo em: $filePath');
      return true;
    } catch (e) {
      print('Erro ao salvar o arquivo: $e');
    }

    return false;
  }

  Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/playlist.m3u';
  }

  // Método para carregar o arquivo salvo em cache
  Future<String> loadOfFilePlaylist() async {
    try {
      var filePath = await getFilePath();

      // Lê o conteúdo do arquivo
      final file = File(filePath);
      return await file.readAsString();
    } catch (e) {
      print('Erro ao carregar o arquivo: $e');
      return '';
    }
  }

  Future<bool> existsPlaylist() async {
    try {
      var filePath = await getFilePath();

      // Verifica se o arquivo existe
      final file = File(filePath);
      return await file.exists();
    } catch (e) {
      print('Erro ao verificar o arquivo: $e');
      return false;
    }
  }
}