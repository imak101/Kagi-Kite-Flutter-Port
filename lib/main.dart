import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kagi_kite_demo/routes/routes.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';

void main() {
  GetIt.I.registerSingleton<KiteApiClient>(KiteApiClient());

  runApp(const KiteApp());
}

class KiteApp extends StatelessWidget {
  const KiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    final kiteYellow = Color.fromARGB(255, 244, 182, 68);

    return MaterialApp.router(
      title: 'Kite',
      routerConfig: router,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kiteYellow, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kiteYellow, brightness: Brightness.light),
        useMaterial3: true,
      ),
    );
  }
}