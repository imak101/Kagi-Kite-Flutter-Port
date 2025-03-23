import 'package:flutter/material.dart';

class KiteBetaBadge extends StatelessWidget {
  const KiteBetaBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: colorScheme.error
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          'BETA',
          style: TextStyle(
            color: colorScheme.onError,
            fontSize: 10
          ),
        ),
      )
    );
  }
}
