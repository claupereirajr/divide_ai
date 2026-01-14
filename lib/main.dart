import 'package:divide_ai/data/observers/calc_observer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routefly/routefly.dart';
import 'package:flutter/material.dart';

import 'main.route.dart';

part 'main.g.dart';

void main() {
  Bloc.observer = const CalcObserver();
  runApp(const MyApp());
}

@Main('lib/ui')
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Divide Ai',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      routerConfig: Routefly.routerConfig(
        routes: routes,
        initialPath: routePaths.calc,
      ),
    );
  }
}
