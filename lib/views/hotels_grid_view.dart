import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:hotels/views/hotel_card_widget.dart';

class HotelsGridView extends StatefulWidget {
  final List<HotelPreview>? hotels;

  const HotelsGridView({super.key, required this.hotels});

  @override
  State<HotelsGridView> createState() => _HotelsGridViewState();
}

class _HotelsGridViewState extends State<HotelsGridView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: widget.hotels?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
            child: HotelCardWidget(
              isGrid: true,
              hotel: widget.hotels![index],
            ),
          );
        },
      ),
    );
  }
}
