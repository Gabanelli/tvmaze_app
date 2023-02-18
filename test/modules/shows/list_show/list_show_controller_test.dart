import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tvmaze_app/core/controller/base_controller.dart';
import 'package:tvmaze_app/core/controller/controller_status.dart';
import 'package:tvmaze_app/core/failures/failures.dart';
import 'package:tvmaze_app/modules/shows/list_show/list_show_controller.dart';
import 'package:tvmaze_app/modules/shows/shared/model/show.dart';
import 'package:tvmaze_app/modules/shows/shared/repository/show_repository.dart';

import 'list_show_controller_test.mocks.dart';

@GenerateMocks([ShowRepository])
void main() {
  late final MockShowRepository mockShowRepository;

  setUpAll(() {
    mockShowRepository = MockShowRepository();
  });

  group('ListShowController class', () {
    test('should be created successfully', () {
      final controller = ListShowController(mockShowRepository);
      expect(controller, isA<BaseController>());
    });
  });
  group('ListShowController onInit', () {
    test('should fill shows list when request is successfully', () async {
      when(mockShowRepository.getShows(any))
          .thenAnswer((_) async => Right(ilist(_showsMock)));

      final controller = ListShowController(mockShowRepository);
      controller.onInit();

      expect(controller.isLoading.value, true);
      expect(controller.status, ControllerStatus.loading);
      await Future.delayed(Duration.zero);
      verify(mockShowRepository.getShows(any)).called(1);
      expect(controller.isLoading.value, false);
      expect(controller.hasError.value, false);
      expect(controller.status, ControllerStatus.success);
      expect(controller.shows.length, 1);
    });
    test('should set as error, with a message, when request fail', () async {
      when(mockShowRepository.getShows(any))
          .thenAnswer((_) async => Left(ApiFailure('')));

      final controller = ListShowController(mockShowRepository);
      controller.onInit();

      expect(controller.isLoading.value, true);
      expect(controller.status, ControllerStatus.loading);
      await Future.delayed(Duration.zero);
      verify(mockShowRepository.getShows(any)).called(1);
      expect(controller.isLoading.value, false);
      expect(controller.hasError.value, true);
      expect(controller.errorMessage.value, isNotEmpty);
      expect(controller.status, ControllerStatus.error);
    });
  });
  group('ListShowController onChangePage', () {
    test('should change page and do request', () async {
      when(mockShowRepository.getShows(any))
          .thenAnswer((_) async => Right(ilist(_showsMock)));

      final controller = ListShowController(mockShowRepository);
      controller.changePage(1);

      expect(controller.isLoading.value, true);
      await Future.delayed(Duration.zero);
      verify(mockShowRepository.getShows(1)).called(1);
      expect(controller.isLoading.value, false);
      expect(controller.hasError.value, false);
      expect(controller.status, ControllerStatus.success);
      expect(controller.shows.length, 1);
    });
  });
}

final _showsMock = [
  Show(
    1,
    'Girls',
    ['Drama', 'Romance'],
    DateTime(2012, 4, 15),
    DateTime(2017, 4, 16),
    '<p>This Emmy winning series is a comic look at the assorted humiliations and rare triumphs of a group of girls in their 20s.</p>',
    'https://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg","original":"https://static.tvmaze.com/uploads/images/original_untouched/31/78286.jpg',
    false,
  )
];
