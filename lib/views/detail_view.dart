import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DetailView extends StatefulWidget {
  static const String route = '/detail';
  final String uuid;
  const DetailView({super.key, required this.uuid});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  bool isLoading = false;
  int errorNum = 0;
  dynamic _detail;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.get(Uri(
        scheme: 'https',
        host: 'run.mocky.io',
        path: 'v3/${widget.uuid}',
      ));
      var data = json.decode(response.body);
      _detail = HotelDetailed.fromJson(data);
    } on ClientException catch (e) {
      errorNum = 1;
    } on FormatException catch (e) {
      errorNum = 2;
    } catch (e) {
      errorNum = 3;
    }
    setState(() {
      isLoading = false;
    });
  }

  Widget switcher(int error) {
    switch (error) {
      case 0:
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                  itemCount: _detail.photos.length,
                  itemBuilder: ((context, index, realIndex) => Image.asset(
                        'assets/images/${_detail.photos[index]}',
                        fit: BoxFit.fill,
                      )),
                  options: CarouselOptions(
                    viewportFraction: 0.8,
                    aspectRatio: 2,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Страна: ',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          '${_detail.address.country}',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Город: ',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          '${_detail.address.city}',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Улица: ',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          '${_detail.address.street}',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Рейтинг: ',
                          style: TextStyle(fontSize: 13),
                        ),
                        Text(
                          '${_detail.rating}',
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 18, 8, 10),
                child: Text(
                  'Сервисы',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Платные',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ..._detail.services.paid.map((element) => Text(
                                  element,
                                  style: const TextStyle(fontSize: 13),
                                )),
                          ]),
                    ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Бесплатно',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            ..._detail.services.free.map((element) => Text(
                                  element,
                                  style: const TextStyle(fontSize: 13),
                                )),
                          ]),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      case 1:
        return const Center(
          child: Text('Неполадки сети или неверный запрос'),
        );
      case 2:
        return const Center(
          child: Text('Контент временно недоступен'),
        );
      case 3:
        return const Center(
          child: Text('Данные повреждены'),
        );
      default:
        return const Center(
          child: Text('Что-то пошло не так'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: isLoading
            ? const Text('')
            : errorNum != 0
                ? const Text('')
                : Text(_detail.name),
      ),
      body: SafeArea(
        child: isLoading
            ? Container(
                padding: const EdgeInsets.all(25),
                child: Image.asset(
                  'assets/loader.gif',
                  fit: BoxFit.cover,
                ),
              )
            : switcher(errorNum),
      ),
    );
  }
}
