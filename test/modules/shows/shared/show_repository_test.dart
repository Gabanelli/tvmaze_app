import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_connect.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvmaze_app/core/data_source/local_storage/local_storage_service.dart';
import 'package:tvmaze_app/core/data_source/tvmaze/dto/tvmaze_episode.dart';
import 'package:tvmaze_app/core/data_source/tvmaze/dto/tvmaze_image.dart';
import 'package:tvmaze_app/core/data_source/tvmaze/dto/tvmaze_search_show.dart';
import 'package:tvmaze_app/core/data_source/tvmaze/dto/tvmaze_show.dart';
import 'package:tvmaze_app/core/data_source/tvmaze/tvmaze_service.dart';
import 'package:tvmaze_app/core/failures/failures.dart';
import 'package:tvmaze_app/modules/shows/shared/repository/impl/show_repository_impl.dart';

import 'show_repository_test.mocks.dart';

@GenerateMocks([TvMazeService, LocalStorageService])
void main() {
  final MockTvMazeService mockTvMazeService = MockTvMazeService();
  final MockLocalStorageService mockLocalStorageService =
      MockLocalStorageService();

  setUpAll(() {
    when(mockLocalStorageService.getFavoriteIds()).thenReturn({});
  });

  group('ShowRepository getEpisodesFromShow', () {
    final showRepository =
        ShowRepositoryImpl(mockTvMazeService, mockLocalStorageService);
    test('should return episodes by season of a show', () async {
      when(mockTvMazeService.getEpisodesByShow(any))
          .thenAnswer((_) async => _episodeDtoResponse);
      final episodes = await showRepository.getEpisodesFromShow(1);

      verify(mockTvMazeService.getEpisodesByShow(1)).called(1);
      expect(episodes.isRight(), true);
    });
    test('should return ApiFailure when error in request ocurred', () async {
      when(mockTvMazeService.getEpisodesByShow(any))
          .thenAnswer((_) async => const Response(statusCode: 500));
      final episodes = await showRepository.getEpisodesFromShow(1);

      verify(mockTvMazeService.getEpisodesByShow(1)).called(1);
      expect(episodes.isLeft(), true);
      expect((episodes as Left).value, isA<ApiFailure>());
    });
    test('should return InternalFailure when an unknown error ocurred',
        () async {
      when(mockTvMazeService.getEpisodesByShow(any))
          .thenThrow(Exception('Test error'));
      final episodes = await showRepository.getEpisodesFromShow(1);

      verify(mockTvMazeService.getEpisodesByShow(1)).called(1);
      expect(episodes.isLeft(), true);
      expect((episodes as Left).value, isA<InternalFailure>());
    });
  });
  group('ShowRepository getShows', () {
    final showRepository =
        ShowRepositoryImpl(mockTvMazeService, mockLocalStorageService);
    test('should return shows with pagination', () async {
      when(mockTvMazeService.getShows(any))
          .thenAnswer((_) async => _showDtoResponse);
      final shows = await showRepository.getShows(0);

      verify(mockTvMazeService.getShows(0)).called(1);
      expect(shows.isRight(), true);
    });
    test('should return ApiFailure when error in request ocurred', () async {
      when(mockTvMazeService.getShows(any))
          .thenAnswer((_) async => const Response(statusCode: 500));
      final shows = await showRepository.getShows(0);

      verify(mockTvMazeService.getShows(0)).called(1);
      expect(shows.isLeft(), true);
      expect((shows as Left).value, isA<ApiFailure>());
    });
    test('should return InternalFailure when an unknown error ocurred',
        () async {
      when(mockTvMazeService.getShows(any)).thenThrow(Exception('Test error'));
      final shows = await showRepository.getShows(0);

      verify(mockTvMazeService.getShows(0)).called(1);
      expect(shows.isLeft(), true);
      expect((shows as Left).value, isA<InternalFailure>());
    });
  });
  group('ShowRepository searchShows', () {
    final showRepository =
        ShowRepositoryImpl(mockTvMazeService, mockLocalStorageService);
    test('should return shows by a search string', () async {
      when(mockTvMazeService.searchShows(any))
          .thenAnswer((_) async => _showSearchDtoResponse);
      final shows = await showRepository.searchShows('text');

      verify(mockTvMazeService.searchShows('text')).called(1);
      expect(shows.isRight(), true);
    });
    test('should return ApiFailure when error in request ocurred', () async {
      when(mockTvMazeService.searchShows(any))
          .thenAnswer((_) async => const Response(statusCode: 500));
      final shows = await showRepository.searchShows('text');

      verify(mockTvMazeService.searchShows('text')).called(1);
      expect(shows.isLeft(), true);
      expect((shows as Left).value, isA<ApiFailure>());
    });
    test('should return InternalFailure when an unknown error ocurred',
        () async {
      when(mockTvMazeService.searchShows(any))
          .thenThrow(Exception('Test error'));
      final shows = await showRepository.searchShows('text');

      verify(mockTvMazeService.searchShows('text')).called(1);
      expect(shows.isLeft(), true);
      expect((shows as Left).value, isA<InternalFailure>());
    });
  });
  // TODO: Add favorite tests
  // group('ShowRepository toggleFavoriteShow', () {
  //   test('should return episodes by season of a show', () {});
  //   test('should return ApiFailure when error in request ocurred', () {});
  //   test('should return InternalFailure when an unknown error ocurred', () {});
  // });
}

final _showSearchDtoResponse = Response<List<TvMazeSearchShow>>(
  statusCode: 200,
  body: [
    TvMazeSearchShow(
      1.30,
      TvMazeShow(
        1,
        'Girls',
        ['Drama', 'Romance'],
        DateTime(2012, 4, 15),
        DateTime(2017, 4, 16),
        '<p>This Emmy winning series is a comic look at the assorted humiliations and rare triumphs of a group of girls in their 20s.</p>',
        TvMazeShowSchedule('00:00', ['Sunday']),
        const TvMazeImage(
            'https://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg',
            null),
      ),
    )
  ],
);

final _showDtoResponse = Response<List<TvMazeShow>>(
  statusCode: 200,
  body: [
    TvMazeShow(
      1,
      'Girls',
      ['Drama', 'Romance'],
      DateTime(2012, 4, 15),
      DateTime(2017, 4, 16),
      '<p>This Emmy winning series is a comic look at the assorted humiliations and rare triumphs of a group of girls in their 20s.</p>',
      TvMazeShowSchedule('00:00', ['Sunday']),
      const TvMazeImage(
          'https://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg',
          null),
    )
  ],
);

const _episodeDtoResponse = Response<List<TvMazeEpisode>>(
  statusCode: 200,
  body: [
    TvMazeEpisode(
      1,
      'Pilot',
      1,
      1,
      'The first episode',
      TvMazeImage(
          'https://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg',
          null),
    )
  ],
);
