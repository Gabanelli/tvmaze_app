import 'package:get/get.dart';
import 'package:tvmaze_app/core/data_source/tvmaze/dto/tvmaze_search_show.dart';

import 'dto/tvmaze_episode.dart';
import 'dto/tvmaze_show.dart';

abstract class TvMazeService {
  Future<Response<List<TvMazeShow>>> getShows(int page);
  Future<Response<List<TvMazeSearchShow>>> searchShows(String searchText);
  Future<Response<List<TvMazeEpisode>>> getEpisodesByShow(int showId);
}
