import 'package:hive/hive.dart';

part 'favorite_images.g.dart';

@HiveType(typeId: 1, adapterName: 'FavoriteBox')
class FavoriteImage extends HiveObject {
  @HiveField(0)
  final String? imageUrl;
  @HiveField(1)
  final int? id;

  FavoriteImage({
    this.imageUrl,
    this.id,
  });

  @override
  String toString() {
    return "(imageUrl$imageUrl,id$id,)";
  }
}
