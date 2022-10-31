import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:hotels/utils.dart';

class HotelDetailPage extends StatefulWidget {
  static const String route = '/detail';
  final String uuid;

  const HotelDetailPage({super.key, required this.uuid});

  @override
  State<HotelDetailPage> createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  late final _requestOperation = fetchDetails(widget.uuid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<HotelDetailed>(
        future: _requestOperation,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
            case ConnectionState.waiting:
              return makeLoader();
            case ConnectionState.active:
              return makeLoader();
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Scaffold(
                  appBar: AppBar(),
                  body: const Center(
                    child: Text('Контент временно недоступен'),
                  ),
                );
              } else if (snapshot.hasData) {
                final detail = snapshot.data as HotelDetailed;
                return _makeView(detail);
              }
              return Container();
          }
        },
      ),
    );
  }

  Widget _makeView(HotelDetailed detail) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(detail.name),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                itemCount: detail.photos.length,
                // todo exception
                //
                itemBuilder: ((context, index, realIndex) => Image.asset(
                      'assets/images/${detail.photos[index]}',
                      fit: BoxFit.fill,
                    )),
                options: CarouselOptions(
                  viewportFraction: 0.8,
                  aspectRatio: 2,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _makeAddress('Страна: ', detail.address.country),
                  _makeAddress('Город: ', detail.address.city),
                  _makeAddress('Улица: ', detail.address.street),
                  _makeAddress('Рейтинг: ', detail.rating.toString()),
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
                    _makeServices('Платные', detail.services.paid),
                    _makeServices('Бесплатно', detail.services.free),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _makeAddress(String key, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            key,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _makeServices(String title, List<String> body) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...body.map(
            (element) => Text(
              element,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
