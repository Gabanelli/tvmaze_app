import 'package:json_annotation/json_annotation.dart';
import 'package:tvmaze_app/modules/shows/shared/model/show_schedule.dart';

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
  final TvMazeShowImage? image;

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
class TvMazeShowImage {
  final String? medium;
  final String? original;

  const TvMazeShowImage(this.medium, this.original);

  factory TvMazeShowImage.fromJson(Map<String, dynamic> json) =>
      _$TvMazeShowImageFromJson(json);
}

@JsonSerializable()
class TvMazeShowSchedule extends ShowSchedule {
  TvMazeShowSchedule(super.time, super.days);

  factory TvMazeShowSchedule.fromJson(dynamic json) =>
      _$TvMazeShowScheduleFromJson(json);
}
