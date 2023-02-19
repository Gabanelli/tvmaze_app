import 'package:get/get.dart';
import 'package:tvmaze_app/core/failures/failures.dart';
import 'package:tvmaze_app/modules/shows/shared/model/episode.dart';
import 'package:tvmaze_app/modules/shows/shared/model/show.dart';
import 'package:tvmaze_app/modules/shows/shared/repository/show_repository.dart';

import '../../../core/routes/base_controller.dart';

class ShowDetailController extends BaseController {
  final ShowRepository _showRepository;

  ShowDetailController(this._showRepository);

  final show = Rxn<Show>();
  final episodes = RxList<Episode>();
  final page = 0.obs;

  void _getEpisodes() async {
    isLoading.value = true;
    final showsEither = await _showRepository.getEpisodesFromShow(page.value);
    showsEither.fold(
      setGenericFailure,
      (episodes) {
        this.episodes.value = episodes.toList();
        isLoading.value = false;
      },
    );
  }

  void setGenericFailure(Failure failure) {
    super.setFailure(failure,
        'An error was ocurred, please check your connection and try again');
  }

  @override
  void onInit() {
    show.value = Get.arguments['show'];
    if (show.value == null) {
      throw 'Show is a required argument to ShowDetailController';
    }
    _getEpisodes();
    super.onInit();
  }
}
