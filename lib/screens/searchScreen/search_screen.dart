import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../widget/error_loading.dart';
import '../../widget/loading_spinner.dart';
import 'widget/search_form_field.dart';
import '../../models/images_model.dart';
import 'widget/search_result.dart';
import '../../controller/wallpaper_provider.dart';
import '../../style/style.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final searchController = useTextEditingController();
    final searchImageData =
        ref.watch(searchImageProvider(searchController.text));
    // if the user search for any key word  images will be shown other wise nothing will not
    final isCorrectSearch = useState(false);
    // this method to check if the form is validate or not
    void _search() {
      if (formKey.currentState!.validate()) {
        updateRenderImageState(isCorrectSearch: isCorrectSearch, state: true);
      } else {
        return;
      }
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
            child: SearchTextFormField(
              searchController: searchController,
              renderImages: isCorrectSearch.value,
              onSearch: _search,
              validator: (String? value) {
                if (value?.isEmpty ?? true) {
                  return 'Field Cant be Empty ';
                } else {
                  return null;
                }
              },
            ),
          ),
          //* button

          TextButton(
            onPressed: () {
              _search();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Style.tertiary,
              ),
            ),
            child: const Text(
              'Search',
              style: TextStyle(color: Style.black),
            ),
          ),
          //  render grid when submit
          isCorrectSearch.value
              ? searchImageData.when(
                  error: ((error, stackTrace) => ErrorLoading(
                        onPressed: () => ref.refresh(
                          searchImageProvider(searchController.text),
                        ),
                      )),
                  loading: (() => const LoadingSpinner()),
                  data: ((data) {
                    updateRenderImageState(
                      state: false,
                      isCorrectSearch: isCorrectSearch,
                    );
                    return SearchResult(
                      searchResult: data ?? const Images(),
                    );
                  }),
                )
              : const Center(),
        ],
      ),
    );
  }

// this method responsible  about change the  state
  void updateRenderImageState({
    required bool state,
    required ValueNotifier<bool> isCorrectSearch,
  }) {
    isCorrectSearch.value = state;
  }
}
