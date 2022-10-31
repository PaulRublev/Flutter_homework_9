import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';

class HotelCardWidget extends StatelessWidget {
  final HotelPreview? hotel;
  final bool isGrid;

  const HotelCardWidget({
    super.key,
    required this.isGrid,
    required this.hotel,
  });

  @override
  Widget build(BuildContext context) {
    final assetImage = 'assets/images/${hotel!.poster}';

    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Image.asset(
              assetImage,
              fit: BoxFit.cover,
            ),
          ),
          isGrid
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.topCenter,
                      height: 50,
                      child: Text(hotel!.name),
                    ),
                    SizedBox(
                      height: 30,
                      child: _makeDetailButton(isGrid, context),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(hotel!.name),
                      _makeDetailButton(isGrid, context),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget _makeDetailButton(bool isGrid, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      onPressed: (() => _onDetailPressed(context)),
      child: isGrid
          ? const SizedBox(child: Text('Подробнее'))
          : const Text('Подробнее'),
    );
  }

  void _onDetailPressed(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/detail',
      arguments: {
        'uuid': hotel!.uuid,
      },
    );
  }
}
