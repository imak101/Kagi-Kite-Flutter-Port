import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class KiteTitleView extends StatefulWidget {
  const KiteTitleView({super.key});

  @override // todo: probably stateless
  State<KiteTitleView> createState() => _KiteTitleViewState();
}

class _KiteTitleViewState extends State<KiteTitleView> {
  @override
  Widget build(BuildContext context) {
    final formattedDate = DateTime.now().format(AmericanDateFormats.dayOfWeekShortWithComma);
    final colorScheme = ColorScheme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4, top: 2),
              child: SvgPicture.asset('assets/images/kite.dark.svg', width: 27),
            ),
            Text(
              'Kite',
              style: TextStyle(
                fontSize: 25,
                color: colorScheme.primary
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            formattedDate,
            style: TextStyle(
              fontSize: 13,
              color: colorScheme.secondary
            ),
          ),
        )
      ],
    );
  }
}
