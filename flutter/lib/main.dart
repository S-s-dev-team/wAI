import 'package:flutter/material.dart';
import 'api/lib/src/api.dart';

final api = WaiApi(
  basePathOverride: 'http://10.0.2.2:4010',
);

void main() {
  runApp(const MaterialApp(
    home: Scaffold(body: Center(child: Text('wAI'))),
  ));
}
