class Show {
  final int id;
  final String name;
  final List<String> genres;
  final DateTime premiered;
  final DateTime? ended;
  final String summary;
  final String imageUrl;
  final bool isFavorite;

  const Show(
    this.id,
    this.name,
    this.genres,
    this.premiered,
    this.ended,
    this.summary,
    this.imageUrl,
    this.isFavorite,
  );
}
