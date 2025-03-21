import 'package:go_router/go_router.dart';
import 'package:kagi_kite_demo/services/network/kite/kite_api_client.dart';
import 'routes.dart';

final router = GoRouter(
  initialLocation: '/feed',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, routerState, shell) {
        return KiteScaffold(shell);
      },
      branches: [
        StatefulShellBranch(
          initialLocation: '/feed',
          routes: [
            GoRoute(
              path: '/feed',
              builder: (context, routerState) => const FeedPage(),
              routes: [
                GoRoute(
                  path: '/categoryDetail',
                  builder: (context, routerState) => CategoryDetailPage(routerState.extra as ShallowKiteCategory),
                )
              ]
            )
          ],
        )
      ],
    )
  ]
);