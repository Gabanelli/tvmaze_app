import 'package:get/get.dart';
import 'package:tvmaze_app/core/services/tvmaze/tvmaze_config.dart';
import 'package:tvmaze_app/core/services/tvmaze/tvmaze_service.dart';

import 'dto/tvmaze_episode.dart';
import 'dto/tvmaze_show.dart';

class TvMazeServiceImpl implements TvMazeService {
  final GetConnect _getConnect;

  TvMazeServiceImpl(this._getConnect);

  @override
  Future<Response<List<TvMazeShow>>> getShows(int page) {
    return _getConnect.get<List<TvMazeShow>>(
      TvMazeConfig.shows,
      query: {'page': page},
    );
  }

  @override
  Future<Response<List<TvMazeEpisode>>> getEpisodesByShow(int showId) {
    return _getConnect.get<List<TvMazeEpisode>>(
      TvMazeConfig.episodes(showId),
    );
  }
}
