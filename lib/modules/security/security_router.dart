import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:tvmaze_app/core/routes/app_route.dart';
import 'package:tvmaze_app/modules/security/security_config/security_config_bindings.dart';
import 'package:tvmaze_app/modules/security/security_config/security_config_page.dart';

class SecurityRouter implements AppRoute {
  @override
  List<GetPage> getPages() {
    return [
      GetPage(
        name: SecurityRoutes.securityConfig,
        page: () => const SecurityConfigPage(),
        binding: SecurityConfigBindings(),
      ),
    ];
  }
}

class SecurityRoutes {
  static const securityConfig = '/securityConfig';
}
