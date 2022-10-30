import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';

Future<List<HotelPreview>> fetchPreview(String uuid) async {
  final data = await httpGetAndDecode(uuid) as List<dynamic>;
  return data.map((hotel) => HotelPreview.fromJson(hotel)).toList();
}

Future<HotelDetailed> fetchDetails(String uuid) async {
  final data = await httpGetAndDecode(uuid) as Map<String, dynamic>;
  return HotelDetailed.fromJson(data);
}

httpGetAndDecode(String uuid) async {
  final response = await http.get(Uri(
    scheme: 'https',
    host: 'run.mocky.io',
    path: 'v3/$uuid',
  ));
  return json.decode(response.body);
}

Widget makeLoader() {
  return Center(
    child: Image.asset(
      'assets/loader.gif',
      fit: BoxFit.cover,
    ),
  );
}
