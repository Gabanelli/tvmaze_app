import 'package:json_annotation/json_annotation.dart';
import 'package:tvmaze_app/modules/shows/shared/model/show_schedule.dart';

import 'tvmaze_image.dart';

part 'tvmaze_show.g.dart';

@JsonSerializable()
class TvMazeShow {
  final int id;
  final String name;
  final List<String> genres;
  final DateTime? premiered;
  final DateTime? ended;
  final String? summary;
  final TvMazeShowSchedule schedule;
  final TvMazeImage? image;

  const TvMazeShow(
    this.id,
    this.name,
    this.genres,
    this.premiered,
    this.ended,
    this.summary,
    this.schedule,
    this.image,
  );

  factory TvMazeShow.fromJson(dynamic json) => _$TvMazeShowFromJson(json);
}

@JsonSerializable()
class TvMazeShowSchedule extends ShowSchedule {
  TvMazeShowSchedule(super.time, super.days);

  factory TvMazeShowSchedule.fromJson(dynamic json) =>
      _$TvMazeShowScheduleFromJson(json);
}
