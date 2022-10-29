import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';

class CardWidget extends StatelessWidget {
  final List<HotelPreview>? hotels;
  final int index;
  final bool isGrid;

  const CardWidget({
    super.key,
    required this.index,
    required this.isGrid,
    required this.hotels,
  });

  toDetailPage() {}

  @override
  Widget build(BuildContext context) {
    final assetImage = 'assets/images/${hotels![index].poster}';

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
                      child: Text(hotels![index].name),
                    ),
                    SizedBox(
                      height: 30,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                        ),
                        onPressed: (() {
                          // todo next page
                          Navigator.of(context)
                              .pushNamed('/detail', arguments: {
                            'uuid': hotels![index].uuid,
                          });
                        }),
                        child: const SizedBox(
                          child: Text('Подробнее'),
                        ),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(hotels![index].name),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                        ),
                        onPressed: (() {
                          // todo next page
                          Navigator.of(context)
                              .pushNamed('/detail', arguments: {
                            'uuid': hotels![index].uuid,
                          });
                        }),
                        child: const Text('Подробнее'),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
