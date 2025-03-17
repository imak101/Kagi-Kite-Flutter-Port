import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kagi_kite_demo/widgets/appbar/widgets.dart';

class KiteScaffold extends StatelessWidget {
  const KiteScaffold(this.navigationShell, {super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: 200,
          child: KiteTitleView()
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu)
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.dark_mode_outlined),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => navigationShell.goBranch(index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Feed'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Today in History'
          )
        ],
      ),
    );
  }
}
