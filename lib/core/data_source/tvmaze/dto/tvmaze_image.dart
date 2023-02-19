import 'package:json_annotation/json_annotation.dart';

part 'tvmaze_image.g.dart';

@JsonSerializable()
class TvMazeImage {
  final String? medium;
  final String? original;

  const TvMazeImage(this.medium, this.original);

  factory TvMazeImage.fromJson(Map<String, dynamic> json) =>
      _$TvMazeImageFromJson(json);
}
