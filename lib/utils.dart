import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';

Future<List<HotelPreview>> fetch(String uuid) async {
  final response = await http.get(Uri(
    scheme: 'https',
    host: 'run.mocky.io',
    path: 'v3/$uuid',
  ));
  final data = json.decode(response.body) as List<dynamic>;
  return data.map((hotel) => HotelPreview.fromJson(hotel)).toList();
}

Widget makeLoader() {
  return Center(
    child: Image.asset(
      'assets/loader.gif',
      fit: BoxFit.cover,
    ),
  );
}
