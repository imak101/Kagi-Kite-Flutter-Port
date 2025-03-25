import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kagi_kite_demo/services/provider/theme/theme_provider.dart';

showThemePickerDialog(BuildContext context) {
  return showDialog(context: context, builder: (context) {
    return AlertDialog(
      icon: Icon(Icons.palette_outlined, size: 35,),
      content: SizedBox(
        height: 240,
        width: MediaQuery.of(context).size.width,
        child: KiteThemePickerView(),
      ),
      actions: [
        TextButton( // todo: add 'view source background' button
          onPressed: () => Navigator.pop(context, 'Close'),
          child: const Text('Close'),
        ),
      ],
    );
  });
}

class KiteThemePickerView extends ConsumerStatefulWidget {
  const KiteThemePickerView({super.key});

  @override
  ConsumerState<KiteThemePickerView> createState() => _ColorSchemePickerViewState();
}

class _ColorSchemePickerViewState extends ConsumerState<KiteThemePickerView> {
  String _chosenColor = '';

  void _onRadioPressed(KiteTheme theme, bool isLight) {
    setState(() {
      _chosenColor = '${theme.name} ${isLight ? 'light' : 'dark'}';
    });

    ref.read(kiteThemeNotifierProvider.notifier).updateThemePreference(KiteThemePreference(theme , isLight));
  }

  @override
  void initState() {
    super.initState();
    final currentTheme = ref.read(kiteThemeNotifierProvider).value;
    _chosenColor = '${currentTheme?.kiteTheme.name} ${currentTheme?.brightness == Brightness.light ? 'light' : 'dark'}';
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: kiteThemes.length,
      itemBuilder: (context, index) {
        final thisTheme = kiteThemes[index];
        return IntrinsicHeight(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: thisTheme.colorSeed,
                      ),
                    ),
                  ),
                  Text(
                    thisTheme.name,
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IntrinsicWidth(
                      child: RadioListTile(
                        value: '${thisTheme.name} light',
                        title: Icon(Icons.light_mode_outlined),
                        groupValue: _chosenColor,
                        onChanged: (newValue) {
                          _onRadioPressed(thisTheme, true);
                        },
                      ),
                    ),
                    IntrinsicWidth(
                      child: RadioListTile(
                        value: '${thisTheme.name} dark',
                        title: Icon(Icons.dark_mode_outlined),
                        groupValue: _chosenColor,
                        onChanged: (newValue) {
                          _onRadioPressed(thisTheme, false);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
