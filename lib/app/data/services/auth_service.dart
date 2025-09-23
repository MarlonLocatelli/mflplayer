import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String? baseUrl}) = _AuthService;

  //http://server.iptv:8080/player_api.php?username=YOURUSERNAME&password=YOURPASSWORD&action=get_live_streams
  @GET("/")
  Future<HttpResponse<String>> createFile();

  @GET("")
  Future<HttpResponse<String>> fromUrlM3u();
}