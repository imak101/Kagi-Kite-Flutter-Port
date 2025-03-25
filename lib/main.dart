import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:kagi_kite_demo/routes/routes.dart';
import 'package:kagi_kite_demo/services/local_storage.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'package:kagi_kite_demo/services/network/wikipedia/wikipedia_api_client.dart';
import 'package:kagi_kite_demo/services/provider/theme/theme_provider.dart';

void main() {
  GetIt.I.registerSingleton<KiteApiClient>(KiteApiClient());
  GetIt.I.registerSingleton<WikipediaApiClient>(WikipediaApiClient());
  GetIt.I.registerSingleton<ILocalStorage>(LocalStorage());

  runApp(ProviderScope(child: const KiteApp()));
}

class KiteApp extends ConsumerWidget {
  const KiteApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(kiteThemeNotifierProvider);

    return MaterialApp.router(
      title: 'Kite',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      themeMode: theme.value?.themeMode,
      darkTheme: ThemeData(
        colorScheme: theme.value?.colorScheme,
        useMaterial3: true,
      ),
      theme: ThemeData(
        colorScheme: theme.value?.colorScheme,
        useMaterial3: true,
      ),
    );
  }
}