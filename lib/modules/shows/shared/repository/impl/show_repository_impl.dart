import 'package:tvmaze_app/core/data_source/local_storage/local_storage_service.dart';
import 'package:tvmaze_app/core/data_source/tvmaze/dto/tvmaze_episode.dart';
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
      return Right(response.body!
          .map(_parseEpisodeDtoToModel)
          .groupBy((episode) => episode.season));
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
      return Right(ilist(response.body!.map(_parseShowDtoToModel)));
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
          .map((showSearch) => _parseShowDtoToModel(showSearch.show))));
    } catch (err) {
      return Left(InternalFailure(err.toString()));
    }
  }

  @override
  Future<Either<Failure, Show>> toggleFavoriteShow(Show show) async {
    try {
      final ids = _localStorageService.getFavoriteIds();
      if (ids.contains(show.id)) {
        ids.remove(show.id);
      } else {
        ids.add(show.id);
      }
      await _localStorageService.setFavoriteIds(ids);
      return Right(show.copyWith(isFavorite: ids.contains(show.id)));
    } catch (err) {
      return Left(InternalFailure(err.toString()));
    }
  }

  Show _parseShowDtoToModel(TvMazeShow tvMazeShow) => Show(
        tvMazeShow.id,
        tvMazeShow.name,
        tvMazeShow.genres,
        tvMazeShow.premiered,
        tvMazeShow.ended,
        tvMazeShow.summary,
        tvMazeShow.image?.medium,
        tvMazeShow.schedule,
        _localStorageService.getFavoriteIds().contains(tvMazeShow.id),
      );

  Episode _parseEpisodeDtoToModel(TvMazeEpisode tvMazeEpisode) => Episode(
        tvMazeEpisode.id,
        tvMazeEpisode.name,
        tvMazeEpisode.number,
        tvMazeEpisode.season,
        tvMazeEpisode.summary,
        tvMazeEpisode.image.medium,
      );
}
