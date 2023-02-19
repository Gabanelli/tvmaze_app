import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvmaze_app/core/core_bindings.dart';
import 'package:tvmaze_app/modules/shows/shows_router.dart';

import 'core/routes/app_pages.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('TV Maze App')),
        body: Column(
          children: [
            ListTile(
              title: const Text('Shows List'),
              onTap: () => Get.toNamed(ShowsRoutes.listShow),
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
}
