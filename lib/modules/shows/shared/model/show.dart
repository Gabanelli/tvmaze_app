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

  Show copyWith({
    int? id,
    String? name,
    List<String>? genres,
    DateTime? premiered,
    DateTime? ended,
    String? summary,
    String? imageUrl,
    bool? isFavorite,
  }) =>
      Show(
        id ?? this.id,
        name ?? this.name,
        genres ?? this.genres,
        premiered ?? this.premiered,
        ended ?? this.ended,
        summary ?? this.summary,
        imageUrl ?? this.imageUrl,
        isFavorite ?? this.isFavorite,
      );
}
