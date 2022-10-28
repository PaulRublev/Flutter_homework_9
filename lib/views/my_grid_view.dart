import 'package:flutter/material.dart';
import 'package:hotels/views/card_widget.dart';

class MyGridView extends StatefulWidget {
  final List<dynamic> hotels;

  const MyGridView({super.key, required this.hotels});

  @override
  State<MyGridView> createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: widget.hotels.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
            child: CardWidget(
              index: index,
              isGrid: true,
              hotels: widget.hotels,
            ),
          );
        },
      ),
    );
  }
}
