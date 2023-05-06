import 'package:flutter/material.dart';

import '/models/images_model.dart';
import '/widget/image_card.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key, required this.searchResult});
  final Images searchResult;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: .7,
          mainAxisSpacing: 10,
        ),
        itemCount: searchResult.photos?.length,
        itemBuilder: (context, index) {
          return ImageCard(
            imageUrl: searchResult.photos?[index].src?.tiny ?? '',
            isHaveButton: false,
          );
        },
      ),
    );
  }
}
