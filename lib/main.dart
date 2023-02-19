import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvmaze_app/core/core_bindings.dart';
import 'package:tvmaze_app/modules/shows/shows_router.dart';

import 'core/routes/app_pages.dart';
import 'modules/security/security_router.dart';

void main() {
  registerRoutes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      title: 'TV Maze App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('TV Maze App')),
        body: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.movie),
              title: const Text('Shows List'),
              onTap: () => Get.toNamed(ShowsRoutes.listShow),
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Security'),
              onTap: () => Get.toNamed(SecurityRoutes.securityConfig),
            ),
          ],
        ),
      ),
    );
  }
}

void registerRoutes() {
  CoreBindings().setDependencies();
  AppPages.registerPages(ShowsRouter().getPages());
  AppPages.registerPages(SecurityRouter().getPages());
}
