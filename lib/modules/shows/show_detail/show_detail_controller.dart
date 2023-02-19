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

  final show = Rx<Show>(Get.arguments['show']);
  final episodesBySeason = RxMap<int, List<Episode>>();
  bool hasChanges = false;

  void _getEpisodes() async {
    isLoading.value = true;
    final episodesEither =
        await _showRepository.getEpisodesFromShow(show.value.id);
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

  void toggleShowFavorite() async {
    final toggleFavoriteEither =
        await _showRepository.toggleFavoriteShow(show.value);
    toggleFavoriteEither.fold(setGenericFailure, (show) {
      this.show.value = show;
      hasChanges = true;
    });
  }

  void navigateToEpisodeDetail(Episode episode) =>
      Get.toNamed(ShowsRoutes.episodeDetail, arguments: {'episode': episode});

  @override
  void onInit() {
    _getEpisodes();
    super.onInit();
  }
}
