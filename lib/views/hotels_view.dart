import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:hotels/views/hotel_card_widget.dart';

class HotelsView {
  static SliverList toSliverList(List<HotelPreview> hotels) {
    return SliverList(
      delegate: SliverChildListDelegate([
        for (final hotel in hotels)
          SizedBox(
            height: 200,
            child: HotelCardWidget(
              isGrid: false,
              hotel: hotel,
            ),
          )
      ]),
    );
  }

  static SliverGrid toSliverGrid(List<HotelPreview> hotels) {
    return SliverGrid.extent(
      maxCrossAxisExtent: 200,
      children: [
        for (final hotel in hotels)
          HotelCardWidget(
            isGrid: true,
            hotel: hotel,
          )
      ],
    );
  }
}
