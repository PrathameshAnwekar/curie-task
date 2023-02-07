import 'package:curie_task/utils/initializer.dart';
import 'package:curie_task/views/home.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff1a73e8),
        ),
      ),
      home: const Initializer(),
      routes: {
        Home.routeName: (context) =>  Home(),
      },
    );
  }
}
