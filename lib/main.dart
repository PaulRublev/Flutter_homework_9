import 'package:flutter/material.dart';
import 'package:hotels/views/detail_view.dart';
import 'package:hotels/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case HomeView.route:
            return MaterialPageRoute(builder: (context) {
              return const HomeView();
            });
          case DetailView.route:
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(builder: (context) {
              return DetailView(uuid: args['uuid']);
            });
          default:
            return MaterialPageRoute(
                builder: (context) => const Center(
                      child: Text('Someting wrong with pages'),
                    ));
        }
      },
    );
  }
}
