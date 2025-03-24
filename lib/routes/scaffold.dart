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
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: KiteDrawerView(),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: 200, // ensure we get enough space for the logo and date
          child: KiteTitleView()
        ),
        actions: [
          IconButton(
            onPressed: () => showThemePickerDialog(context),
            icon: Icon(Icons.palette_outlined),
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
