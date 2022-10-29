import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:hotels/utils.dart';
import 'package:hotels/views/my_grid_view.dart';
import 'package:hotels/views/my_list_view.dart';

enum DisplayOption {
  listView,
  gridView,
}

class HomeView extends StatefulWidget {
  static const String route = '/';
  static const String homeUuid = 'ac888dc5-d193-4700-b12c-abb43e289301';

  const HomeView({Key? key}) : super(key: key);

  @override
  State createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final _requestOperation = fetch(HomeView.homeUuid);
  var _displayOption = DisplayOption.listView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => setState(() {
              _displayOption = DisplayOption.listView;
            }),
            icon: const Icon(Icons.list),
          ),
          IconButton(
            onPressed: () => setState(() {
              _displayOption = DisplayOption.gridView;
            }),
            icon: const Icon(Icons.grid_on),
          )
        ],
      ),
      body: FutureBuilder<List<HotelPreview>>(
        future: _requestOperation,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
            case ConnectionState.waiting:
              return makeLoader();
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final hotels = snapshot.data as List<HotelPreview>;
                return _displayOption == DisplayOption.listView
                    ? MyListView(hotels: hotels)
                    : MyGridView(hotels: hotels);
              }
              return Container();
            case ConnectionState.active:
              return makeLoader();
          }
        },
      ),
    );
  }
}
