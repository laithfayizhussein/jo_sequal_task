import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../models/images_model.dart';
import 'endpoints.dart';
import '../dio_client.dart';

String apiKey = 'jLRKBthTV1s5ujmGGh6PZwFRNdCVmbnUFArcxWzRORjkGTtsjKRwHTZG';
Map<String, dynamic> header = {'Authorization': apiKey};

final wallpaperApiNotifierProvider =
    StateNotifierProvider((ref) => WallpaperApiNotifire());

class WallpaperApiNotifire extends StateNotifier<List<Images>> {
  WallpaperApiNotifire() : super([]);

  // import dio
  DioClient dioClient = DioClient();

// render all images
  Future<Images?> imagesApi(int page) async {
    Images images = const Images();

    try {
      final response = await dioClient.get(
        '${Endpoints.allImageUrl}?page=$page',
        options: Options(headers: header),
      );
      images = Images.fromJson(response.data);
      debugPrint('images: $images');
      log('images: $images');
    } catch (e) {
      debugPrint('ImagesERROE: $e');
    }
    return images;
  }

  // in case big app this will be seprated as class notifire
  Future<Photo?> singleImageApi(int id) async {
    Photo photo = const Photo();

    try {
      final response = await dioClient.get(
        '${Endpoints.singleImageUrl}/$id',
        options: Options(headers: header),
      );
      photo = Photo.fromJson(response.data);
      debugPrint('image: $photo');
      log('image: $photo');
    } catch (e) {
      debugPrint('ImageERROE: $e');
    }
    return photo;
  }

  Future<Images?> searchImagesApi(String query) async {
    Images search = const Images();

    try {
      final response = await dioClient.get(
        '${Endpoints.searchImageUrl}?query=$query',
        options: Options(headers: header),
      );
      search = Images.fromJson(response.data);
      debugPrint('searchImagesApi: $search');
      log('searchImagesApi: $search');
    } catch (e) {
      debugPrint('searchERROE: $e');
    }
    return search;
  }
}
