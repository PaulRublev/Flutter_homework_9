import 'package:flutter/material.dart';
import 'package:hotels/models/hotel.dart';
import 'package:hotels/utils/network.dart';
import 'package:hotels/utils/ui.dart';
import 'package:hotels/views/hotels_view.dart';

enum DisplayOption {
  listView,
  gridView,
}

class HomePage extends StatefulWidget {
  static const String route = '/';
  static const String homeUuid = 'ac888dc5-d193-4700-b12c-abb43e289301';

  const HomePage({Key? key}) : super(key: key);

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final _requestOperation = HotelsApi.fetchPreviewList(HomePage.homeUuid);
  var _displayOption = DisplayOption.listView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<HotelPreview>>(
        future: _requestOperation,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container();
            case ConnectionState.waiting:
              return const CustomLoader();
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final hotels = snapshot.data;
                return CustomScrollView(slivers: [
                  SliverAppBar(
                    floating: true,
                    centerTitle: true,
                    title: const Text('Hotels'),
                    pinned:
                        MediaQuery.of(context).size.width < 500 ? true : false,
                    actions: [
                      IconButton(
                          onPressed: () => setState(() {
                                _displayOption =
                                    _displayOption == DisplayOption.gridView
                                        ? DisplayOption.listView
                                        : DisplayOption.gridView;
                              }),
                          icon: _displayOption == DisplayOption.gridView
                              ? const Icon(Icons.list)
                              : const Icon(Icons.grid_on))
                    ],
                  ),
                  _displayOption == DisplayOption.listView
                      ? HotelsView.toSliverList(hotels!)
                      : HotelsView.toSliverGrid(hotels!)
                ]);
              }
              return Container();
            case ConnectionState.active:
              return const CustomLoader();
          }
        },
      ),
    );
  }
}
