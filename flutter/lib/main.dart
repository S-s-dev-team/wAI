
import 'package:flutter/material.dart';
import 'core/theme/theme.dart';
import 'dev_preview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wAI',
      theme: AppTheme.light,
      home: const DevPreviewScreen(),
    );
  }
}
