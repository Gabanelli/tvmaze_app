import 'package:get/get.dart';
import 'package:tvmaze_app/core/failures/failures.dart';

import 'controller_status.dart';

class BaseController extends GetxController {
  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  ControllerStatus get status {
    if (isLoading.value) return ControllerStatus.loading;
    if (hasError.value) return ControllerStatus.error;
    return ControllerStatus.success;
  }

  void setFailure(Failure failure, String message) {
    isLoading.value = false;
    hasError.value = true;
    errorMessage.value = message;
    print(failure.toString());
    //TODO: Store errors
  }
}
