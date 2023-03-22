import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../router/app_router.gr.dart';
import '../../style.dart';
import 'widget/home_image_card.dart';
import '../../models/images_model.dart';
import '../../services/api/wallpaper_api.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('rebuild');
    final PagingController<int, Photo> pagingController = PagingController(
      firstPageKey: 1,
    );
    String? nextPage;

    useEffect(() {
      pagingController.addPageRequestListener((pageKey) {
        final wallpaperImages = ref.watch(
          wallpaperApiNotifierProvider.notifier,
        );

        wallpaperImages.imagesApi(pageKey).then(
          (value) {
            nextPage = value?.nextPage ?? '';
            if (nextPage != null) {
              pagingController.appendPage(value?.photos ?? [], ++pageKey);
            } else {
              pagingController.appendLastPage(value?.photos ?? []);
            }
          },
        );
      });
      return () => pagingController.dispose();
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.router.push(const FavoriteRoute());
            },
            icon: const Icon(
              Icons.favorite,
              color: Style.tertiary,
            ),
          )
        ],
        title: const Center(
          child: Text(
            'Wallpapers',
          ),
        ),
      ),
      body: Column(
        children: [
          TextFormField(
            readOnly: true,
            onTap: () {
              context.router.push(const SearchRoute());
            },
            decoration: const InputDecoration(
              hintText: ('write some thing like Nature, Tigers, People'),
              prefixIcon: Icon(
                Icons.search,
              ),
            ),
          ),
          Expanded(
            child: PagedGridView<int, Photo>(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 00,
                childAspectRatio: 1.0,
                crossAxisCount: 2,
                mainAxisSpacing: 00,

              ),
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate<Photo>(
                noMoreItemsIndicatorBuilder: ((context) =>
                    const Center(child: Text('No More Data '))),
                newPageProgressIndicatorBuilder: ((context) => const Center(
                      child: CircularProgressIndicator(),
                    )),
                itemBuilder: (context, item, index) {
                  return HomeImageCard(photos: item);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
