import 'package:get/get.dart';
import 'package:tvmaze_app/core/failures/failures.dart';
import 'package:tvmaze_app/modules/shows/shared/model/episode.dart';
import 'package:tvmaze_app/modules/shows/shared/model/show.dart';
import 'package:tvmaze_app/modules/shows/shared/repository/show_repository.dart';
import 'package:tvmaze_app/modules/shows/shows_router.dart';

import '../../../core/routes/base_controller.dart';

class ShowDetailController extends BaseController {
  final ShowRepository _showRepository;

  ShowDetailController(this._showRepository);

  late final Show show;
  final episodesBySeason = RxMap<int, List<Episode>>();

  void _getEpisodes() async {
    isLoading.value = true;
    final episodesEither = await _showRepository.getEpisodesFromShow(show.id);
    episodesEither.fold(
      setGenericFailure,
      (episodes) {
        episodesBySeason.value = episodes;
        isLoading.value = false;
      },
    );
  }

  void setGenericFailure(Failure failure) {
    super.setFailure(failure,
        'An error was ocurred, please check your connection and try again');
  }

  void navigateToEpisodeDetail(Episode episode) =>
      Get.toNamed(ShowsRoutes.episodeDetail, arguments: {'episode': episode});

  @override
  void onInit() {
    if (Get.arguments['show'] == null) {
      throw 'Show is a required argument to ShowDetailController';
    }
    show = Get.arguments['show'];
    _getEpisodes();
    super.onInit();
  }
}
