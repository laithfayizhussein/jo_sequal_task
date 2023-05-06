import 'package:flutter/material.dart';

class SearchTextFormField extends StatelessWidget {
  const SearchTextFormField({
    super.key,
    required this.searchController,
    required this.renderImages,
    required this.onSearch,
    required this.validator,
  });

  final TextEditingController searchController;
  final bool renderImages;
  final Function onSearch;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // validator for empty field  case
      validator: validator,
      controller: searchController,
      keyboardType: TextInputType.text,
      autofocus: renderImages ? false : true,
      decoration: const InputDecoration(
        hintText: ('write some thing like Nature, Tigers, People'),
        prefixIcon: Icon(
          Icons.search,
        ),
      ),
      onFieldSubmitted: (value) {
        onSearch();
      },
    );
  }
}
