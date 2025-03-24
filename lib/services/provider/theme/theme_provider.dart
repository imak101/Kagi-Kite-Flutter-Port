import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kagi_kite_demo/services/local_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

final List<KiteTheme> kiteThemes = [ // defines kite themes
  KiteTheme('Kite Yellow', colorSeed: Color.fromARGB(255, 244, 182, 68)),
  KiteTheme('Purple', colorSeed: Colors.purple),
  KiteTheme('Blue', colorSeed: Colors.blue),
];

@immutable
class KiteTheme { // just a container to define what color a theme is, does not carry brightness preference
  const KiteTheme(this.name, {required this.colorSeed});

  final String name;
  final Color colorSeed;
  ColorScheme get light => ColorScheme.fromSeed(seedColor: colorSeed, brightness: Brightness.light);
  ColorScheme get dark => ColorScheme.fromSeed(seedColor: colorSeed, brightness: Brightness.dark);
}

@immutable
class KiteThemePreference { // represents a kitetheme with associated brightness
  const KiteThemePreference(this.kiteTheme, this.isLight);

  final KiteTheme kiteTheme;
  final bool isLight;
  Brightness get brightness => isLight ? Brightness.light : Brightness.dark;
  ThemeMode get themeMode => brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;
  ColorScheme get colorScheme => brightness == Brightness.light ? kiteTheme.light : kiteTheme.dark;

  static KiteThemePreference defaultTheme() => KiteThemePreference(kiteThemes.first, false);
}

@riverpod
class KiteThemeNotifier extends _$KiteThemeNotifier {
  @override
  Future<KiteThemePreference> build() async {
    final colorName = await GetIt.I<ILocalStorage>.call().getString(LocalStorageKeys.strThemeName);
    final isLight = await GetIt.I<ILocalStorage>.call().getBool(LocalStorageKeys.boolThemeIsLight);

    if (colorName != null && isLight != null) {
      return KiteThemePreference(kiteThemes.firstWhere((scheme) => scheme.name == colorName), isLight);
    }

    return KiteThemePreference.defaultTheme();
  }

  Future<void> updateThemePreference(KiteThemePreference newPreference) async {
    await GetIt.I<ILocalStorage>.call().writeSting(LocalStorageKeys.strThemeName, newPreference.kiteTheme.name);
    await GetIt.I<ILocalStorage>.call().writeBool(LocalStorageKeys.boolThemeIsLight, newPreference.isLight);
    state = AsyncData(newPreference);
  }
}
