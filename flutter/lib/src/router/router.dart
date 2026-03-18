import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/presentation/sign_in_controller.dart';
import '../features/authentication/presentation/sign_in_screen.dart';
import '../features/chat/presentation/chat_list_screen.dart';
import '../features/mentor/presentation/create_mentor_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(signInControllerProvider);

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
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const ChatListScreen(),
      ),
      GoRoute(
        path: '/create-mentor',
        builder: (context, state) => const CreateMentorScreen(),
      ),
    ],
  );
});
