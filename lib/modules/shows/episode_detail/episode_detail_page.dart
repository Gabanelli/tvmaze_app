import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:tvmaze_app/modules/shows/shared/model/episode.dart';

class EpisodeDetailPage extends StatelessWidget {
  const EpisodeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    if (Get.arguments['episode'] == null) {
      throw 'Episode is a required argument to EpisodeDetailPage';
    }
    final Episode episode = Get.arguments['episode'];

    return Scaffold(
      appBar: AppBar(title: Text('Episode ${episode.number}')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (episode.image?.medium != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image.network(episode.image!.medium!),
                ),
              Text('${episode.name} - S${episode.season}E${episode.number}'),
              Html(data: episode.summary),
            ],
          ),
        ),
      ),
    );
  }
}
