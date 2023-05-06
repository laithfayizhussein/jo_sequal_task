import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../controller/favorite_image.dart';
import '../../../models/images_model.dart';
import '../../../router/app_router.gr.dart';

class HomeImageCard extends StatelessWidget {
  const HomeImageCard({super.key, required this.photos});
  final Photo photos;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: ((context, ref, child) {
        return GestureDetector(
          onTap: () {
            // to refresh the fav button icon 
            ref.refresh(checkFavoriteFromDb(photos.id ?? 1));

            context.router.push(
              DetailesRoute(
                imageId: photos.id ?? 1,
                title: photos.photographer ?? '',
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            child: GridTile(
              child: CachedNetworkImage(
                imageUrl: photos.src?.tiny ?? '',
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
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        );
      }),
    );
  }
}
