class TvMazeShow {
  final int id;
  final String name;
  final List<String> genres;
  final DateTime premiered;
  final DateTime? ended;
  final String summary;

  const TvMazeShow(
    this.id,
    this.name,
    this.genres,
    this.premiered,
    this.ended,
    this.summary,
  );
}
