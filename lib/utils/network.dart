import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hotels/models/hotel.dart';

class HotelsApi {
  static Future<List<HotelPreview>> fetchPreviewList(String uuid) async {
    final data = await _httpGetAndDecode(uuid) as List<dynamic>;
    return data.map((hotel) => HotelPreview.fromJson(hotel)).toList();
  }

  static Future<HotelDetailed> fetchDetails(String uuid) async {
    final data = await _httpGetAndDecode(uuid) as Map<String, dynamic>;
    return HotelDetailed.fromJson(data);
  }

  static dynamic _httpGetAndDecode(String uuid) async {
    final response = await http.get(Uri(
      scheme: 'https',
      host: 'run.mocky.io',
      path: 'v3/$uuid',
    ));
    return json.decode(response.body);
  }
}
