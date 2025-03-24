import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kagi_kite_demo/services/provider/theme/theme_provider.dart';
import 'package:kagi_kite_demo/widgets/appbar/widgets.dart';

class KiteTitleView extends ConsumerWidget {
  const KiteTitleView({super.key, this.showDate = true});

  final bool showDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLightTheme = ref.watch(kiteThemeNotifierProvider).value?.brightness == Brightness.light;
    final formattedDate = DateTime.now().format(AmericanDateFormats.dayOfWeekShortWithComma);
    final colorScheme = ColorScheme.of(context);

    return Column(
      children: [
        IntrinsicWidth(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4, top: 2),
                child: SvgPicture.asset(isLightTheme ? 'assets/images/kite.svg' : 'assets/images/kite.dark.svg', width: 27),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  'Kite',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.primary
                  ),
                ),
              ),
              KiteBetaBadge(),
            ],
          ),
        ),
        Visibility(
          visible: showDate,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              formattedDate,
              style: TextStyle(
                fontSize: 13,
                color: colorScheme.secondary
              ),
            ),
          ),
        )
      ],
    );
  }
}
