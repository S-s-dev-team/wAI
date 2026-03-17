import 'package:flutter/material.dart';

import 'core/router/router.dart';
import 'core/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AI先輩',
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
