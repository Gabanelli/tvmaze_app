import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvmaze_app/modules/shows/list_show/list_show_controller.dart';
import 'package:tvmaze_app/modules/shows/shared/model/show.dart';

import '../../../core/routes/controller_status.dart';

class ListShowPage extends GetView<ListShowController> {
  const ListShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shows List')),
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: controller.searchTextController,
                        onChanged: (text) => controller.searchText.value = text,
                      ),
                    ),
                    if (controller.isSearchMode.value)
                      IconButton(
                        onPressed: controller.clearSearch,
                        icon: const Icon(Icons.clear),
                      ),
                    IconButton(
                      onPressed: controller.searchShows,
                      icon: const Icon(Icons.search),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildList(),
                const SizedBox(height: 16),
                if (!controller.isSearchMode.value)
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
                      Text((controller.page.value + 1).toString()),
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
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    switch (controller.status) {
      case ControllerStatus.loading:
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [CircularProgressIndicator()],
          ),
        );
      case ControllerStatus.error:
        return Text(controller.errorMessage.value);
      case ControllerStatus.success:
        return Flexible(
          child: controller.shows.isEmpty
              ? const Text('No results')
              : GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  children: controller.shows
                      .map((show) => ShowView(
                            show,
                            onTap: controller.navigateToDetails,
                          ))
                      .toList(),
                ),
        );
    }
  }
}

class ShowView extends StatelessWidget {
  final Show show;
  final void Function(Show)? onTap;

  const ShowView(
    this.show, {
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap != null ? onTap!(show) : null,
      child: Column(
        children: [
          if (show.imageUrl != null)
            Image.network(
              show.imageUrl!,
              height: 150,
            ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              show.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
