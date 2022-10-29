import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:hotels/views/my_grid_view.dart';
import 'package:hotels/views/my_list_view.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  static const String route = '/';
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int index = 0;
  bool isLoading = false;
  late List<dynamic> _hotels;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri(
      scheme: 'https',
      host: 'run.mocky.io',
      path: 'v3/ac888dc5-d193-4700-b12c-abb43e289301',
    ));
    var data = json.decode(response.body);
    _hotels = data.map((hotel) => HotelPreview.fromJson(hotel)).toList();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => setState(() {
                    index = 0;
                  }),
              icon: const Icon(Icons.list)),
          IconButton(
              onPressed: () => setState(() {
                    index = 1;
                  }),
              icon: const Icon(Icons.grid_on))
        ],
      ),
      body: isLoading
          ? SafeArea(
              child: Container(
                padding: const EdgeInsets.all(25),
                child: Image.asset(
                  'assets/loader.gif',
                  fit: BoxFit.cover,
                ),
              ),
            )
          : index == 0
              ? MyListView(hotels: _hotels)
              : MyGridView(hotels: _hotels),
    );
  }
}
