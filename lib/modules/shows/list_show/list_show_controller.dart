import 'package:get/get.dart';
import 'package:tvmaze_app/core/failures/failures.dart';
import 'package:tvmaze_app/modules/shows/shared/model/show.dart';
import 'package:tvmaze_app/modules/shows/shared/repository/show_repository.dart';

import '../../../core/routes/base_controller.dart';

class ListShowController extends BaseController {
  final ShowRepository _showRepository;

  ListShowController(this._showRepository);

  final shows = <Show>[].obs;
  final page = 0.obs;

  void _getShows() async {
    isLoading.value = true;
    final showsEither = await _showRepository.getShows(page.value);
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
    _getShows();
  }

  void nextPage() => changePage(page.value + 1);
  void previousPage() => changePage(page.value - 1);

  @override
  void onInit() {
    _getShows();
    super.onInit();
  }
}
