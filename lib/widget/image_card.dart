import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../style/style.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    super.key,
    required this.imageUrl,
    required this.isHaveButton,
    this.onPress,
  });
  final String imageUrl;
  final bool isHaveButton;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: Container(
        color: Style.black.withOpacity(.4),
        child: isHaveButton
            ? IconButton(
                onPressed: onPress,
                icon: const Icon(
                  Icons.delete,
                  color: Style.white,
                ),
              )
            : const SizedBox(),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Card(
          elevation: 3,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
