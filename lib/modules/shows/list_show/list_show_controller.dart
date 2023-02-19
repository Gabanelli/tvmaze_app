import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvmaze_app/core/failures/failures.dart';
import 'package:tvmaze_app/modules/shows/shared/model/show.dart';
import 'package:tvmaze_app/modules/shows/shared/repository/show_repository.dart';

import '../../../core/routes/base_controller.dart';

typedef _GetShowStrategy = Future<Either<Failure, IList<Show>>> Function();

class ListShowController extends BaseController {
  final ShowRepository _showRepository;

  ListShowController(this._showRepository);

  final searchTextController = TextEditingController();

  final shows = <Show>[].obs;
  final page = 0.obs;
  final searchText = Rxn<String>();
  final isSearchMode = false.obs;

  void _getShows(_GetShowStrategy getShowStrategy) async {
    isLoading.value = true;
    final showsEither = await getShowStrategy();
    showsEither.fold(
      setGenericFailure,
      (shows) {
        this.shows.value = shows.toList();
        isLoading.value = false;
        hasError.value = false;
      },
    );
  }

  void setGenericFailure(Failure failure) {
    super.setFailure(failure,
        'An error was ocurred, please check your connection and try again');
  }

  void changePage(int newPage) {
    page.value = newPage;
    _getShows(() => _showRepository.getShows(page.value));
  }

  void nextPage() => changePage(page.value + 1);
  void previousPage() => changePage(page.value - 1);
  void searchShows() {
    if (searchText.value != null && searchText.value!.isNotEmpty) {
      _getShows(() => _showRepository.searchShows(searchText.value!));
      isSearchMode.value = true;
    }
  }

  void clearSearch() {
    _getShows(() => _showRepository.getShows(page.value));
    searchText.value = null;
    searchTextController.clear();
    isSearchMode.value = false;
  }

  @override
  void onInit() {
    _getShows(() => _showRepository.getShows(page.value));
    isSearchMode.value = false;
    super.onInit();
  }
}
