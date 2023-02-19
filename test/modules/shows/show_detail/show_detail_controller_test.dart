import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvmaze_app/core/failures/failures.dart';
import 'package:tvmaze_app/core/routes/base_controller.dart';
import 'package:tvmaze_app/core/routes/controller_status.dart';
import 'package:tvmaze_app/modules/shows/shared/model/episode.dart';
import 'package:tvmaze_app/modules/shows/shared/model/show.dart';
import 'package:tvmaze_app/modules/shows/shared/model/show_schedule.dart';
import 'package:tvmaze_app/modules/shows/shared/repository/show_repository.dart';
import 'package:tvmaze_app/modules/shows/show_detail/show_detail_controller.dart';

import 'show_detail_controller_test.mocks.dart';

@GenerateMocks([ShowRepository])
void main() {
  late final MockShowRepository mockShowRepository;

  setUpAll(() {
    mockShowRepository = MockShowRepository();
    Get.routing.args = {'show': _showMock};
  });

  tearDownAll(() {
    Get.routing.args = null;
  });

  group('ShowDetailController class', () {
    test('should be created successfully', () {
      final controller = ShowDetailController(mockShowRepository);
      expect(controller, isA<BaseController>());
    });
  });
  group('ShowDetailController onInit', () {
    test('should fill shows list when request is successfully', () async {
      when(mockShowRepository.getEpisodesFromShow(any))
          .thenAnswer((_) async => Right(_episodesMock));

      final controller = ShowDetailController(mockShowRepository);
      controller.onInit();

      expect(controller.show, _showMock);
      expect(controller.isLoading.value, true);
      expect(controller.status, ControllerStatus.loading);
      await Future.delayed(Duration.zero);
      verify(mockShowRepository.getEpisodesFromShow(any)).called(1);
      expect(controller.isLoading.value, false);
      expect(controller.hasError.value, false);
      expect(controller.status, ControllerStatus.success);
      expect(controller.episodesBySeason.length, 1);
    });
    test('should set as error, with a message, when request fail', () async {
      when(mockShowRepository.getEpisodesFromShow(any))
          .thenAnswer((_) async => Left(ApiFailure('')));

      final controller = ShowDetailController(mockShowRepository);
      controller.onInit();

      expect(controller.show, _showMock);
      expect(controller.isLoading.value, true);
      expect(controller.status, ControllerStatus.loading);
      await Future.delayed(Duration.zero);
      verify(mockShowRepository.getEpisodesFromShow(any)).called(1);
      expect(controller.isLoading.value, false);
      expect(controller.hasError.value, true);
      expect(controller.errorMessage.value, isNotEmpty);
      expect(controller.status, ControllerStatus.error);
    });
  });
}

final _showMock = Show(
  1,
  'Girls',
  ['Drama', 'Romance'],
  DateTime(2012, 4, 15),
  DateTime(2017, 4, 16),
  '<p>This Emmy winning series is a comic look at the assorted humiliations and rare triumphs of a group of girls in their 20s.</p>',
  'https://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg',
  const ShowSchedule('00:00', ['Sunday']),
  false,
);

final _episodesMock = {
  1: [
    const Episode(
      1,
      'Pilot',
      1,
      1,
      'The first episode',
      'https://static.tvmaze.com/uploads/images/original_untouched/31/78286.jpg',
    ),
  ],
};
