import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:hotels/views/card_widget.dart';

class MyListView extends StatefulWidget {
  final List<HotelPreview>? hotels;

  const MyListView({super.key, required this.hotels});

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: widget.hotels?.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 250,
            child: CardWidget(
              index: index,
              isGrid: false,
              hotels: widget.hotels,
            ),
          );
        },
      ),
    );
  }
}
