import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_downloader/image_downloader.dart';
import '../../style/style.dart';
import '../../controller/favorite_image.dart';
import '../../controller/wallpaper_provider.dart';

class DetailesScreen extends StatelessWidget {
  final int imageId;
  final String title;
  const DetailesScreen({super.key, required this.imageId, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Consumer(
        builder: ((context, ref, child) {
          // future provider for check if the image in the favorite screen
          final checkFavoriteFromDbui = ref.watch(checkFavoriteFromDb(imageId));
          //* stateProvider with auto dispose to change the current value for icon button
          final checkFavoriteButton = ref.watch(isImageFavoriteProvider);
          // future provider to render the data
          final singleImage = ref.watch(singleImageProvider(imageId));
          return singleImage.when(
            error: ((error, stackTrace) => TextButton(
                  child: const Text('try Again'),
                  onPressed: () => ref.refresh(singleImageProvider(imageId)),
                )),
            loading: (() => const Center(
                  child: CircularProgressIndicator(),
                )),
            data: (data) {
              // render the data
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Image widget
                  SizedBox(
                    height: 500.h,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: data?.src?.large ?? '',
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Text(
                    data?.alt ?? '',
                    style: const TextStyle(color: Style.secondary),
                  ),
                  // buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Style.secondary),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          iconSize: 20,
                          icon: Icon(
                            checkFavoriteFromDbui.asData?.value == true ||
                                    checkFavoriteButton == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Style.secondary,
                          ),
                          onPressed: () {
                            ref
                                .read(
                                  isImageFavoriteProvider.notifier,
                                )
                                .state = true;

                            ref
                                .watch(favoriteImageNotifireProvider.notifier)
                                .addFavorite(
                                  imageUrl: data?.src?.tiny ?? '',
                                  id: imageId,
                                );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Add To favorite Screen'),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Style.secondary),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          iconSize: 20,
                          icon: const Icon(
                            Icons.download,
                            color: Style.secondary,
                          ),
                          onPressed: () =>
                              _downloadImg(context, data?.src?.large ?? ''),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }

  Future<void> _downloadImg(BuildContext context, String url) async {
    /// start loading
    await ImageDownloader.downloadImage(
      url,
    ).then((value) {
      /// stop loading
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Image downloaded successfully'),
          backgroundColor: Colors.green[700],
        ),
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Something went wronge please try again later'),
          backgroundColor: Colors.red[700],
        ),
      );
    });
  }
}
