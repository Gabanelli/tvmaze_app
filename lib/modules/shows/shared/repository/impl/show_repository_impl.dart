import 'package:tvmaze_app/core/data_source/local_storage/local_storage_service.dart';
import 'package:tvmaze_app/core/data_source/tvmaze/dto/tvmaze_show.dart';
import 'package:tvmaze_app/core/data_source/tvmaze/tvmaze_service.dart';
import 'package:tvmaze_app/core/extensions/iterable_extensions.dart';
import 'package:tvmaze_app/modules/shows/shared/model/show.dart';
import 'package:tvmaze_app/modules/shows/shared/model/episode.dart';
import 'package:tvmaze_app/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tvmaze_app/modules/shows/shared/repository/show_repository.dart';

class ShowRepositoryImpl implements ShowRepository {
  final TvMazeService _tvMazeService;
  final LocalStorageService _localStorageService;

  ShowRepositoryImpl(this._tvMazeService, this._localStorageService);

  @override
  Future<Either<Failure, Map<int, List<Episode>>>> getEpisodesFromShow(
      int showId) async {
    try {
      final response = await _tvMazeService.getEpisodesByShow(showId);
      if (response.hasError) {
        return Left(ApiFailure(response.toString()));
      }
      return Right(response.body!.groupBy((episode) => episode.season));
    } catch (err) {
      return Left(InternalFailure(err.toString()));
    }
  }

  @override
  Future<Either<Failure, IList<Show>>> getShows(int page) async {
    try {
      final response = await _tvMazeService.getShows(page);
      if (response.hasError) {
        return Left(ApiFailure(response.toString()));
      }
      return Right(ilist(response.body!.map(_parseDtoToModel)));
    } catch (err) {
      return Left(InternalFailure(err.toString()));
    }
  }

  @override
  Future<Either<Failure, IList<Show>>> searchShows(String searchText) async {
    try {
      final response = await _tvMazeService.searchShows(searchText);
      if (response.hasError) {
        return Left(ApiFailure(response.toString()));
      }
      return Right(ilist(response.body!
          .map((showSearch) => _parseDtoToModel(showSearch.show))));
    } catch (err) {
      return Left(InternalFailure(err.toString()));
    }
  }

  Show _parseDtoToModel(TvMazeShow tvMazeShow) => Show(
        tvMazeShow.id,
        tvMazeShow.name,
        tvMazeShow.genres,
        tvMazeShow.premiered,
        tvMazeShow.ended,
        tvMazeShow.summary,
        tvMazeShow.image?.medium,
        _localStorageService.getFavoriteIds().contains(tvMazeShow.id),
      );

  @override
  Future<Either<Failure, IList<Show>>> toggleFavoriteShow(
      IList<Show> shows, int showId) async {
    try {
      final ids = _localStorageService.getFavoriteIds();
      if (ids.contains(showId)) {
        ids.remove(showId);
      } else {
        ids.add(showId);
      }
      await _localStorageService.setFavoriteIds(ids);
      return Right(shows.map(
        (show) => show.id == showId
            ? show.copyWith(isFavorite: ids.contains(showId))
            : show,
      ));
    } catch (err) {
      return Left(InternalFailure(err.toString()));
    }
  }
}
