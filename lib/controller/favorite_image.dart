import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/favorite_images.dart';
import '../database/favorite_images.dart';

final isImageFavoriteProvider = StateProvider.autoDispose(
  (ref) => false,
);

final checkFavoriteFromDb = FutureProvider.family<bool, int>((ref, id) async {
  final response =
      ref.watch(favoriteImageNotifireProvider.notifier).checkFavorite(id);
  debugPrint('response: $response');

  return response;
});

final favoriteImageNotifireProvider = StateNotifierProvider(
  (ref) => FavoriteImageNotifire(),
);

class FavoriteImageNotifire extends StateNotifier<Iterable<dynamic>> {
  FavoriteImageNotifire() : super([]);
  SqlDb sql = SqlDb();

  void addFavorite({
    required String imageUrl,
    required int id,
  }) {
    debugPrint('id from riverpod: $id');
    // sql.getPhotos();
    sql.insertData(FavoriteImages(id, imageUrl));
  }

  Future<List<FavoriteImages>> getFavoriteImage() async {
    List<Map> maps = [];
    await sql.getPhotos().then((value) {
      maps.addAll(value?.toList() ?? []);
    });
    debugPrint('maps: ${maps.toString()}');
    List<FavoriteImages> photos = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        photos.add(FavoriteImages.fromMap(Map<String, dynamic>.from(maps[i])));
      }
    }
    debugPrint('photos: $photos');

    return photos;
  }

  Future<bool> checkFavorite(int id) async {
    bool? isFav;

    await sql.checkImageExistance(id).then((value) {
      if (value.isNotEmpty) {
        isFav = true;
      }
    });
    debugPrint('isFav: $isFav');

    return isFav ?? false;
  }

  void deleteAllFavoriteImage() {
    sql.deleteAllData();

    debugPrint('delete all data ');
  }

  void deleteImageById(String id) {
    sql.deleteData(id);
    debugPrint('delete one data ');
  }
}

final renderFavoriteImage = FutureProvider((ref) async {
  final response = await ref
      .watch(favoriteImageNotifireProvider.notifier)
      .getFavoriteImage();
  debugPrint('renderFavoriteImage: $response');

  return response;
});
