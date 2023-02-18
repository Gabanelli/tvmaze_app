abstract class TvMazeConfig {
  static const _baseUrl = 'https://api.tvmaze.com/';

  static const search = '$_baseUrl/search/shows';
  static const shows = '$_baseUrl/shows';
  static String episodes(String showId) => '$_baseUrl/shows/$showId/episodes';
}
