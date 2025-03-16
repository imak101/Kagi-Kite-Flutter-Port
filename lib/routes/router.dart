import 'package:go_router/go_router.dart';
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
                builder: (context, routerState) => FeedPage(),
            )
          ],
        )
      ],
    )
  ]
);