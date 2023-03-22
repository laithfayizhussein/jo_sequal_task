import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/images_model.dart';
import '../services/api/wallpaper_api.dart';

//* render signal Image by id
final singleImageProvider = FutureProvider.family<Photo?, int>((ref, id) async {
  final response =
      await ref.watch(wallpaperApiNotifierProvider.notifier).singleImageApi(id);
  debugPrint('singleImageProvider: $response');

  return response;
});
//* search by query
final searchImageProvider =
    FutureProvider.family<Images?, String>((ref, query) async {
  final response = await ref
      .watch(wallpaperApiNotifierProvider.notifier)
      .searchImagesApi(query);
  debugPrint('searchImageProvider: $response');

  return response;
});
