import 'package:flutter/material.dart';

import '../style/assets.dart';

class ErrorLoading extends StatelessWidget {
  final VoidCallback onPressed;
  const ErrorLoading({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset(
            ImageAssets.error,
            height: 120,
          ),
          const SizedBox(height: 16),
          const Text(
            'somethingWentWrong',
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onPressed,
            child: const Text('tryAgain'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
