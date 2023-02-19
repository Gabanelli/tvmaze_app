import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvmaze_app/modules/shows/list_show/list_show_controller.dart';

import '../../../core/routes/controller_status.dart';

class ListShowPage extends GetView<ListShowController> {
  const ListShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Shows')),
      body: SafeArea(
        child: Obx(() => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Flexible(
                        child: TextField(),
                      ),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.search))
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildList(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.skip_previous),
                        onPressed: controller.page.value == 0
                            ? null
                            : controller.previousPage,
                        disabledColor: Colors.grey,
                      ),
                      Text(controller.page.value.toString()),
                      IconButton(
                        icon: const Icon(Icons.skip_next),
                        onPressed: controller.shows.isEmpty
                            ? null
                            : controller.nextPage,
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildList() {
    switch (controller.status) {
      case ControllerStatus.loading:
        return const CircularProgressIndicator();
      case ControllerStatus.error:
        return Text(controller.errorMessage.value);
      case ControllerStatus.success:
        return Flexible(
          child: ListView(
            children: controller.shows.map((show) => Text(show.name)).toList(),
          ),
        );
    }
  }
}
