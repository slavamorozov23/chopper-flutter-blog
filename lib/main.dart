import 'package:logging/logging.dart';

import 'data/post_api_service.dart';
import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  _initLogging();
  runApp(const MainApp());
}

void _initLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord
      .listen((rec) => print("${rec.level.name}: ${rec.time}: ${rec.message}"));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) => PostApiService.create(),
        dispose: (_, PostApiService service) => service.client.dispose(),
        child: const MaterialApp(
          title: 'Дом ',
          home: HomePage(),
        ));
  }
}

//--------------------------------------------------------------------------------
// лучшим вариантом реализации будет BLoC-Cubit + get_it для иньекции зависимостей