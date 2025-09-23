import 'package:get/get.dart';
import 'package:mflplayer/app/modules/movie/views/movies_list_details_view.dart';
import 'package:mflplayer/app/modules/series/views/series_list_details_view.dart';
import 'package:mflplayer/app/modules/tv/views/tv_list_details_view.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/movie/bindings/movie_binding.dart';
import '../modules/movie/views/movies_list_view.dart';
import '../modules/player/bindings/player_binding.dart';
import '../modules/player/views/player_view.dart';
import '../modules/series/bindings/series_binding.dart';
import '../modules/series/views/series_list_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/tv/bindings/tv_binding.dart';
import '../modules/tv/views/tv_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.TV,
      page: () => TvListView(),
      binding: TvBinding(),
    ),
    GetPage(
      name: _Paths.TV_LIST_DETAILS,
      page: () => TvListDetailsView(),
      binding: TvBinding(),
    ),
    GetPage(
      name: _Paths.SERIES,
      page: () => SeriesListView(),
      binding: SeriesBinding(),
    ),
    GetPage(
      name: _Paths.SERIES_LIST_DETAILS,
      page: () => SeriesListDetailsView(),
      binding: SeriesBinding(),
    ),
    GetPage(
      name: _Paths.MOVIE,
      page: () => MovieListView(),
      binding: MovieBinding(),
    ),
    GetPage(
      name: _Paths.MOVIE_LIST_DETAILS,
      page: () => MoviesListDetailsView(),
      binding: MovieBinding(),
    ),
    GetPage(
      name: _Paths.PLAYER,
      page: () => PlayerView(),
      binding: PlayerBinding(),
    ),
  ];
}
