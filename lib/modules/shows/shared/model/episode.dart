import '../../../../core/data_source/tvmaze/dto/tvmaze_show.dart';

class Episode {
  final int id;
  final String name;
  final int number;
  final int season;
  final String? summary;
  final TvMazeShowImage? image;

  const Episode(
    this.id,
    this.name,
    this.number,
    this.season,
    this.summary,
    this.image,
  );
}
