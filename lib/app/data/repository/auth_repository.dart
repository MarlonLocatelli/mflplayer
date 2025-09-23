import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mflplayer/app/data/services/auth_service.dart';
import 'package:path_provider/path_provider.dart';

class AuthRepository {
  AuthRepository();

  Future<bool> createFile(String baseUrl) async {

    //print("URL: $baseUrl");
    AuthService service = AuthService(Dio(), baseUrl: baseUrl);

    var result = await service.fromUrlM3u();

    // Verifica se a resposta foi bem-sucedida
    if (result.response.statusCode == 200) {
      print("RESULT ok");
      return await saveFilePlaylist(result.data);
    }

    return false;
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

  Future<bool> existsFilePlaylist() async {
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