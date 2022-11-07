import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:hotels/utils/network.dart';
import 'package:hotels/utils/ui.dart' as ui;

class HotelDetailPage extends StatefulWidget {
  static const String route = '/detail';
  final String uuid;

  const HotelDetailPage({super.key, required this.uuid});

  @override
  State<HotelDetailPage> createState() => _HotelDetailPageState();
}

class _HotelDetailPageState extends State<HotelDetailPage> {
  late final _requestOperation = HotelsApi.fetchDetails(widget.uuid);

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
              return const ui.CustomLoader();
            case ConnectionState.active:
              return const ui.CustomLoader();
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
                return _DetailView(detail: detail);
              }
              return Container();
          }
        },
      ),
    );
  }
}

class _DetailView extends StatelessWidget {
  final HotelDetailed detail;
  static const String assetsPath = 'assets/images/';

  const _DetailView({required this.detail});

  @override
  Widget build(BuildContext context) {
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
                itemBuilder: ((context, index, realIndex) => Image.asset(
                      '$assetsPath${detail.photos[index]}',
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) => const Text(
                        'Asset not found',
                      ),
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
                  ui.Address(
                    name: 'Страна: ',
                    value: detail.address.country,
                  ),
                  ui.Address(
                    name: 'Город: ',
                    value: detail.address.city,
                  ),
                  ui.Address(
                    name: 'Улица: ',
                    value: detail.address.street,
                  ),
                  ui.Address(
                    name: 'Рейтинг: ',
                    value: detail.rating.toString(),
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
                    ui.Services(
                      title: 'Платные',
                      body: detail.services.paid,
                    ),
                    ui.Services(
                      title: 'Бесплатно',
                      body: detail.services.free,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
