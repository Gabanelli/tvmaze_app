import 'package:get/get.dart';
import 'package:tvmaze_app/core/data_source/tvmaze/tvmaze_config.dart';
import 'package:tvmaze_app/core/data_source/tvmaze/tvmaze_service.dart';

import 'dto/tvmaze_episode.dart';
import 'dto/tvmaze_search_show.dart';
import 'dto/tvmaze_show.dart';

class TvMazeServiceImpl implements TvMazeService {
  final GetConnect _getConnect;

  TvMazeServiceImpl(this._getConnect);

  @override
  Future<Response<List<TvMazeShow>>> getShows(int page) {
    return _getConnect.get<List<TvMazeShow>>(
      TvMazeConfig.shows,
      query: <String, String>{'page': page.toString()},
      decoder: (jsonList) =>
          jsonList.map<TvMazeShow>(TvMazeShow.fromJson).toList(),
    );
  }

  @override
  Future<Response<List<TvMazeEpisode>>> getEpisodesByShow(int showId) {
    return _getConnect.get<List<TvMazeEpisode>>(
      TvMazeConfig.episodes(showId),
      decoder: (jsonList) =>
          jsonList.map<TvMazeEpisode>(TvMazeEpisode.fromJson).toList(),
    );
  }

  @override
  Future<Response<List<TvMazeSearchShow>>> searchShows(String searchText) {
    return _getConnect.get<List<TvMazeSearchShow>>(
      TvMazeConfig.search,
      query: <String, String>{'q': searchText},
      decoder: (jsonList) =>
          jsonList.map<TvMazeSearchShow>(TvMazeSearchShow.fromJson).toList(),
    );
  }
}
