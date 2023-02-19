import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/instance_manager.dart';
import 'package:tvmaze_app/core/routes/app_route.dart';
import 'package:tvmaze_app/modules/shows/episode_detail/episode_detail_page.dart';
import 'package:tvmaze_app/modules/shows/list_show/list_show_bindings.dart';
import 'package:tvmaze_app/modules/shows/list_show/list_show_page.dart';
import 'package:tvmaze_app/modules/shows/show_detail/show_detail_bindings.dart';
import 'package:tvmaze_app/modules/shows/show_detail/show_detail_page.dart';

class ShowsRouter implements AppRoute {
  @override
  List<GetPage> getPages() {
    return [
      GetPage(
        name: ShowsRoutes.listShow,
        page: () => const ListShowPage(),
        binding: ListShowBindings(),
      ),
      GetPage(
        name: ShowsRoutes.showDetail,
        page: () => const ShowDetailPage(),
        binding: ShowDetailBindings(),
      ),
      GetPage(
        name: ShowsRoutes.episodeDetail,
        page: () => const EpisodeDetailPage(),
      ),
    ];
  }
}

class ShowsRoutes {
  static const listShow = '/listShow';
  static const showDetail = '/showDetail';
  static const episodeDetail = '/episodeDetail';
}
