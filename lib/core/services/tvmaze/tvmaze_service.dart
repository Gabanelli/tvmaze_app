import 'package:get/get.dart';
import 'package:tvmaze_app/core/services/tvmaze/tvmaze_config.dart';
import 'package:tvmaze_app/modules/shows/shared/model/show.dart';

class TvMazeService {
  final GetConnect _getConnect;

  TvMazeService(this._getConnect);

  // Future<Response<List<TvMazeShow>>> getShows({int page = 0}) {
  //   return _getConnect.get<List<TvMazeShow>>(
  //     TvMazeConfig.shows,
  //     query: {'page': page},
  //   );
  // }
}
