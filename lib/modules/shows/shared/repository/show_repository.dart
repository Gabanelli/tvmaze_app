import 'package:dartz/dartz.dart';
import 'package:tvmaze_app/core/failures/failures.dart';
import 'package:tvmaze_app/modules/shows/shared/model/episode.dart';
import 'package:tvmaze_app/modules/shows/shared/model/show.dart';

abstract class ShowRepository {
  Future<Either<Failure, IList<Show>>> getShows(int page);
  Future<Either<Failure, IList<Show>>> searchShows(String searchText);
  Future<Either<Failure, Map<int, List<Episode>>>> getEpisodesFromShow(
      int showId);
  Future<Either<Failure, IList<Show>>> toggleFavoriteShow(
      IList<Show> shows, int showId);
}
