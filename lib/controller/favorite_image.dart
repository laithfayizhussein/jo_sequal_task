import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../database/favorite_images.dart';

final Box favoriteBox = Hive.box<FavoriteImage>('FavoriteBox');

final isImageFavdoriteProvider = StateProvider.family<bool?, int>((ref, id) {
  final response =
      ref.watch(favoriteImageNotifireProvider.notifier).checkFavorite(id);
  debugPrint('response: $response');

  return response;
});

final favoriteImageNotifireProvider = StateNotifierProvider(
  (ref) => FavoriteImageNotifire(),
);

class FavoriteImageNotifire extends StateNotifier<Iterable<dynamic>> {
  FavoriteImageNotifire() : super(favoriteBox.values);

  void addFavorite({
    required String imageUrl,
    required int imageId,
  }) {
    debugPrint('favoriteBox: ${favoriteBox.values}');

    final checkImageId =
        favoriteBox.values.where((element) => element.id == imageId);
    if (checkImageId.isNotEmpty) {
      debugPrint('id is exist ');
      return; // here where i can update the box
    } else {
      debugPrint('id not  exist ');

      favoriteBox.add(
        FavoriteImage(
          imageUrl: imageUrl,
          id: imageId,
        ),
      );
    }
  }

  bool checkFavorite(imageId) {
    final checkImageId =
        favoriteBox.values.where((element) => element.id == imageId);
    if (checkImageId.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
