import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:tvmaze_app/modules/shows/show_detail/show_detail_controller.dart';

class ShowDetailPage extends GetView<ShowDetailController> {
  const ShowDetailPage({super.key});

  String get _genresText => controller.show.value.genres.join(', ');

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back<bool>(result: controller.hasChanges);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Show Details')),
        body: Obx(
          () => SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.topRight,
                      child: Theme(
                        data: ThemeData(
                          primarySwatch: controller.show.value.isFavorite
                              ? Colors.green
                              : Colors.grey,
                        ),
                        child: TextButton.icon(
                          onPressed: controller.toggleShowFavorite,
                          icon: Icon(
                            controller.show.value.isFavorite
                                ? Icons.star
                                : Icons.star_border,
                          ),
                          label: const Text('Favorite'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (controller.show.value.imageUrl != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Image.network(controller.show.value.imageUrl!),
                      ),
                    Text(controller.show.value.name),
                    Text('Genres: $_genresText'),
                    Text(
                        '${controller.show.value.schedule.days.join(", ")} at ${controller.show.value.schedule.time}'),
                    controller.show.value.summary == null
                        ? const Text('No summary provided')
                        : Html(data: controller.show.value.summary),
                    ...controller.episodesBySeason.entries.map((season) {
                      return Column(
                        children: [
                          Text(
                            'Season ${season.key}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          ...season.value.map(
                            (episode) => Card(
                              child: InkWell(
                                onTap: () =>
                                    controller.navigateToEpisodeDetail(episode),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(episode.name),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    }),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
