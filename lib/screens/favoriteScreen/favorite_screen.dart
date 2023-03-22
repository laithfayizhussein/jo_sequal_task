import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../database/favorite_images.dart';
import '../../widget/image_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Images'),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<FavoriteImage>('FavoriteBox').listenable(),
        builder: (context, Box<FavoriteImage> box, _) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              childAspectRatio: 1,
              mainAxisSpacing: 20,
            ),
            itemCount: box.length,
            itemBuilder: (context, index) {
              final favoriteImage = box.getAt(index);
              return ImageCard(imageUrl: favoriteImage?.imageUrl ?? '');
            },
          );
        },
      ),
    );
  }
}
