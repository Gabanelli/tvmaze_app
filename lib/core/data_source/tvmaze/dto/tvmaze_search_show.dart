import 'package:json_annotation/json_annotation.dart';
import 'package:tvmaze_app/core/data_source/tvmaze/dto/tvmaze_show.dart';

part 'tvmaze_search_show.g.dart';

@JsonSerializable()
class TvMazeSearchShow {
  final double score;
  final TvMazeShow show;

  const TvMazeSearchShow(this.score, this.show);

  factory TvMazeSearchShow.fromJson(dynamic json) =>
      _$TvMazeSearchShowFromJson(json);
}
