import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:hotels/utils/ui.dart';

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
    final imageName = 'assets/images/${hotel!.poster}';

    return Stack(
      children: [
        Card(
          elevation: 10,
          shadowColor: Colors.black,
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Image.asset(
                  imageName,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Text('Asset not found'),
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
                          child: FakeDetailButton(
                            isGrid: isGrid,
                            context: context,
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(hotel!.name),
                          FakeDetailButton(
                            isGrid: isGrid,
                            context: context,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Material(
            color: const Color.fromARGB(0, 255, 255, 255),
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(15),
            child: InkWell(
              onTap: () => _onDetailPressed(context),
            ),
          ),
        ),
      ],
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
