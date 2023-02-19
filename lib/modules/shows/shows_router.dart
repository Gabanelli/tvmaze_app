import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/instance_manager.dart';
import 'package:tvmaze_app/core/routes/app_route.dart';
import 'package:tvmaze_app/modules/shows/list_show/list_show_bindings.dart';
import 'package:tvmaze_app/modules/shows/list_show/list_show_page.dart';
import 'package:tvmaze_app/modules/shows/shared/repository/impl/show_repository_impl.dart';
import 'package:tvmaze_app/modules/shows/shared/repository/show_repository.dart';

class ShowsRouter implements AppRoute {
  @override
  List<GetPage> getPages() {
    return [
      GetPage(
        name: ShowsRoutes.listShow,
        page: () => const ListShowPage(),
        binding: ListShowBindings(),
      ),
    ];
  }
}

class ShowsRoutes {
  static const listShow = '/listShow';
  static const showDetail = '/showDetail';
}
