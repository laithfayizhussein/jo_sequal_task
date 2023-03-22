import 'package:freezed_annotation/freezed_annotation.dart';

part 'images_model.freezed.dart';

part 'images_model.g.dart';

@freezed
abstract class Images with _$Images {
  const factory Images({
    int? totalResults,
    int? page,
    int? perPage,
    List<Photo>? photos,
    String? nextPage,
  }) = _Images;

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);
}

@freezed
abstract class Photo with _$Photo {
  const factory Photo({
    int? id,
    int? width,
    int? height,
    String? url,
    String? photographer,
    String? photographerUrl,
    int? photographerId,
    String? avgColor,
    Src? src,
    bool? liked,
    String? alt,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}

@freezed
abstract class Src with _$Src {
  const factory Src({
    String? original,
    String? large2X,
    String? large,
    String? medium,
    String? small,
    String? portrait,
    String? landscape,
    String? tiny,
  }) = _Src;

  factory Src.fromJson(Map<String, dynamic> json) => _$SrcFromJson(json);
}
