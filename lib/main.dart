import 'package:flutter/material.dart';
import 'package:hotels/views/detail_page.dart';
import 'package:hotels/views/home_page.dart';

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
          case HomePage.route:
            return MaterialPageRoute(builder: (context) {
              return const HomePage();
            });
          case HotelDetailPage.route:
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(builder: (context) {
              return HotelDetailPage(uuid: args['uuid']);
            });
          default:
            return MaterialPageRoute(
              builder: (context) => const Center(
                child: Text('Something wrong with pages'),
              ),
            );
        }
      },
    );
  }
}
