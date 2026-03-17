import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/view_models/auth_view_model.dart';
import '../../features/auth/views/login_page.dart';
import '../../features/chat/presentation/chat_list_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isLoginRoute = state.matchedLocation == '/login';

      if (!isAuthenticated && !isLoginRoute) {
        return '/login';
      }
      if (isAuthenticated && isLoginRoute) {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const ChatListScreen(),
      ),
    ],
  );
});
