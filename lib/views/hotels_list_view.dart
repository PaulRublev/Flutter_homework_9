import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:hotels/views/hotel_card_widget.dart';

class HotelsListView extends StatefulWidget {
  final List<HotelPreview>? hotels;

  const HotelsListView({super.key, required this.hotels});

  @override
  State<HotelsListView> createState() => _HotelsListViewState();
}

class _HotelsListViewState extends State<HotelsListView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: widget.hotels?.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 250,
            child: HotelCardWidget(
              isGrid: false,
              hotel: widget.hotels![index],
            ),
          );
        },
      ),
    );
  }
}
