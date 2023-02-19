import 'package:get/get.dart';

import 'dto/tvmaze_episode.dart';
import 'dto/tvmaze_show.dart';

abstract class TvMazeService {
  Future<Response<List<TvMazeShow>>> getShows(int page);
  Future<Response<List<TvMazeEpisode>>> getEpisodesByShow(int showId);
}
