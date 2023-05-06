import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../controller/favorite_image.dart';
import '../../widget/image_card.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteData = ref.watch(favoriteImageNotifireProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Images'),
        actions: [
          IconButton(
            onPressed: () {
              deleteData.deleteAllFavoriteImage();
              // ignore: unused_result
              ref.refresh(renderFavoriteImage);
            },
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final favooriteData = ref.watch(renderFavoriteImage);
          return favooriteData.when(
            error: ((error, stackTrace) => TextButton(
                  child: const Text('try Again'),
                  onPressed: () => ref.refresh(renderFavoriteImage),
                )),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            data: (data) {
              return data.isEmpty
                  ? const Center(child: Text('No Favorite Images '))
                  : GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        childAspectRatio: 1,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final getImageId = data[index].id;
                        return ImageCard(
                          imageUrl: data[index].imageUrl ?? '',
                          isHaveButton: true,
                          onPress: () {
                            deleteData.deleteImageById(getImageId.toString());
                            ref.refresh(renderFavoriteImage);
                          },
                        );
                      },
                    );
            },
          );
        },
      ),
    );
  }
}
