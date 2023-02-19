import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:tvmaze_app/modules/shows/show_detail/show_detail_controller.dart';

class ShowDetailPage extends GetView<ShowDetailController> {
  const ShowDetailPage({super.key});

  String get _genresText => controller.show.genres.join(', ');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Show details')),
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  if (controller.show.imageUrl != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image.network(controller.show.imageUrl!),
                    ),
                  Text(controller.show.name),
                  Text('Genres: $_genresText'),
                  Html(data: controller.show.summary),
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
    );
  }
}
