import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../controller/wallpaper_provider.dart';
import '../../style.dart';
import '../../widget/image_card.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final nameController = useTextEditingController();
    final searchImageData = ref.watch(searchImageProvider(nameController.text));
    final renderImages = useState(false);

    Future<void>? _search() {
      final isValid = formKey.currentState!.validate();
      debugPrint('isValid: $isValid');
      if (isValid) {
        renderImages.value = true;
      } else {}
      return null;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Search',
          ),
        ),
      ),
      body: Column(
        children: [
          Form(
            key: formKey,
            child: TextFormField(
              // validator if needed
              validator: (value) {
                if (true) {}
                return null;
              },
              controller: nameController,
              keyboardType: TextInputType.text,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: ('write some thing like Nature, Tigers, People'),
                prefixIcon: Icon(
                  Icons.search,
                ),
              ),
              onFieldSubmitted: (value) {
                _search();

                //handel search provider
              },
            ),
          ),
          TextButton(
            onPressed: () {
              _search();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Style.secondary,
              ),
            ),
            child: const Text(
              'Search',
              style: TextStyle(color: Style.black),
            ),
          ),
          renderImages.value
              ? searchImageData.when(
                  error: ((error, stackTrace) => TextButton(
                        child: const Text('try Again'),
                        onPressed: () => ref
                            .refresh(searchImageProvider(nameController.text)),
                      )),
                  loading: (() => const Center(
                        child: CircularProgressIndicator(),
                      )),
                  data: ((data) {
                    renderImages.value = false;

                    debugPrint('datadatadatadata: $data');
                    return Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: data?.photos?.length,
                        itemBuilder: (context, index) {
                          return ImageCard(
                            imageUrl: data?.photos?[index].src?.tiny ?? '',
                          );
                        },
                      ),
                    );
                  }),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
