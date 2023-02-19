import 'package:json_annotation/json_annotation.dart';
import 'package:tvmaze_app/core/data_source/tvmaze/dto/tvmaze_show.dart';
import 'package:tvmaze_app/modules/shows/shared/model/episode.dart';

part 'tvmaze_episode.g.dart';

@JsonSerializable()
class TvMazeEpisode extends Episode {
  const TvMazeEpisode(
    super.id,
    super.name,
    super.number,
    super.season,
    super.summary,
    super.image,
  );

  factory TvMazeEpisode.fromJson(dynamic json) => _$TvMazeEpisodeFromJson(json);
}
