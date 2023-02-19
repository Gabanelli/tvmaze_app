import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tvmaze_app/core/data_source/local_storage/local_storage_service.dart';
import 'package:tvmaze_app/core/data_source/tvmaze/tvmaze_service.dart';
import 'package:tvmaze_app/core/data_source/tvmaze/tvmaze_service_impl.dart';

class CoreBindings {
  void setDependencies() {
    // Data sources
    Get.put<LocalStorageService>(LocalStorageService(GetStorage()));
    Get.put<TvMazeService>(TvMazeServiceImpl(GetConnect()));
  }
}
