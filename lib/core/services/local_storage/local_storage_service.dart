import 'package:get_storage/get_storage.dart';
import 'package:tvmaze_app/core/services/local_storage/local_storage_keys.dart';

class LocalStorageService {
  final GetStorage _getStorage;

  const LocalStorageService(this._getStorage);

  Set<int> getFavoriteIds() {
    final ids =
        _getStorage.read<List<int>>(LocalStorageKey.favoriteShowIds.name);
    return ids != null ? Set.from(ids) : {};
  }

  void toggleFavorite(int showId) {
    final ids = getFavoriteIds();
    if (ids.contains(showId)) {
      ids.remove(showId);
    } else {
      ids.add(showId);
    }
    _getStorage.write(LocalStorageKey.favoriteShowIds.name, ids.toList());
  }
}
