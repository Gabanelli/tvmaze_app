import 'package:get/get.dart';
import 'package:tvmaze_app/modules/shows/list_show/list_show_controller.dart';

import '../shared/repository/impl/show_repository_impl.dart';
import '../shared/repository/show_repository.dart';

class ListShowBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowRepository>(
        () => ShowRepositoryImpl(Get.find(), Get.find()));
    Get.lazyPut<ListShowController>(() => ListShowController(Get.find()));
  }
}
