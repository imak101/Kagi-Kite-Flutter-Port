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
                GoRoute( // expects called to provide a [ShallowKiteCategory] object in the context.go(extra: ) parameter
                  path: '/categoryDetail',
                  builder: (context, routerState) => CategoryDetailPage(routerState.extra as ShallowKiteCategory),
                )
              ]
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/onThisDay',
              builder: (context, routerState) => const OnThisDayPage(),
            )
          ]
        )
      ],
    )
  ]
);