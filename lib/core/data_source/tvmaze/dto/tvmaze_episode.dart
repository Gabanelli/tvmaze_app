import 'package:json_annotation/json_annotation.dart';

import 'tvmaze_image.dart';

part 'tvmaze_episode.g.dart';

@JsonSerializable()
class TvMazeEpisode {
  final int id;
  final String name;
  final int number;
  final int season;
  final String? summary;
  final TvMazeImage image;

  const TvMazeEpisode(
    this.id,
    this.name,
    this.number,
    this.season,
    this.summary,
    this.image,
  );

  factory TvMazeEpisode.fromJson(dynamic json) => _$TvMazeEpisodeFromJson(json);
}
