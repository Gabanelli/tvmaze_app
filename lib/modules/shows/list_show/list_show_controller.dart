import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvmaze_app/core/failures/failures.dart';
import 'package:tvmaze_app/modules/shows/shared/model/show.dart';
import 'package:tvmaze_app/modules/shows/shared/repository/show_repository.dart';
import 'package:tvmaze_app/modules/shows/shows_router.dart';

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

  _GetShowStrategy get _getShowsStrategy =>
      searchText.value != null && searchText.value!.isNotEmpty
          ? () => _showRepository.searchShows(searchText.value!)
          : () => _showRepository.getShows(page.value);

  void _getShows() async {
    isLoading.value = true;
    final showsEither = await _getShowsStrategy();
    showsEither.fold(
      setGenericFailure,
      (shows) {
        this.shows.value = shows.toList();
        isLoading.value = false;
        hasError.value = false;
        setIsSearchMode();
      },
    );
  }

  void setGenericFailure(Failure failure) {
    super.setFailure(failure,
        'An error was ocurred, please check your connection and try again');
  }

  void changePage(int newPage) {
    page.value = newPage;
    _getShows();
  }

  void nextPage() => changePage(page.value + 1);
  void previousPage() => changePage(page.value - 1);
  void searchShows() {
    if (searchText.value != null && searchText.value!.isNotEmpty) {
      _getShows();
    }
  }

  void navigateToDetails(Show show) async {
    final shouldRefresh =
        await Get.toNamed(ShowsRoutes.showDetail, arguments: {'show': show});
    if (shouldRefresh ?? true) {
      _getShows();
    }
  }

  void clearSearch() {
    searchText.value = null;
    searchTextController.clear();
    _getShows();
  }

  @override
  void onInit() {
    _getShows();
    super.onInit();
  }

  void setIsSearchMode() {
    isSearchMode.value =
        searchText.value != null && searchText.value!.isNotEmpty;
  }
}
