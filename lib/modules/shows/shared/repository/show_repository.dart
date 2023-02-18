import 'package:dartz/dartz.dart';
import 'package:tvmaze_app/core/failures/failures.dart';
import 'package:tvmaze_app/modules/shows/shared/model/episode.dart';
import 'package:tvmaze_app/modules/shows/shared/model/show.dart';

abstract class ShowRepository {
  Future<Either<Failure, IList<Show>>> getShows(int page);
  Future<Either<Failure, IList<Episode>>> getEpisodesFromShow(int showId);
  Future<Either<Failure, IList<Show>>> toggleFavoriteShow(
      int showId, bool isFavorite);
}
