import 'package:get/get.dart';
import 'package:tvmaze_app/modules/shows/show_detail/show_detail_controller.dart';

import '../shared/repository/impl/show_repository_impl.dart';
import '../shared/repository/show_repository.dart';

class ShowDetailBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowRepository>(
        () => ShowRepositoryImpl(Get.find(), Get.find()));
    Get.lazyPut<ShowDetailController>(() => ShowDetailController(Get.find()));
  }
}
