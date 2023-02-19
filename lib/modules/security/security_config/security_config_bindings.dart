import 'package:get/get.dart';
import 'package:tvmaze_app/modules/security/security_config/security_config_controller.dart';

class SecurityConfigBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SecurityConfigController>(() => SecurityConfigController());
  }
}
