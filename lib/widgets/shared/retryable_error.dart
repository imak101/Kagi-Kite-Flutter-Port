import 'package:flutter/material.dart';

class RetryableNetworkErrorView extends StatelessWidget {
  const RetryableNetworkErrorView({super.key, this.errorMessage, this.onRetry});

  final String? errorMessage;
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.error_outline, size: 100),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            errorMessage ?? 'An error occurred',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(onPressed: () => onRetry?.call(), child: Text('Retry')),
        ),
      ],
    );
  }
}
