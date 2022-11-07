import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  static const String loaderName = 'assets/loader.gif';

  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        loaderName,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Text('Asset not found'),
      ),
    );
  }
}

class Address extends StatelessWidget {
  final String name;
  final String value;

  const Address({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class Services extends StatelessWidget {
  final String title;
  final List<String> body;

  const Services({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...body.map(
            (element) => Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                element,
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FakeDetailButton extends StatelessWidget {
  final bool isGrid;
  final BuildContext context;

  const FakeDetailButton(
      {super.key, required this.isGrid, required this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      alignment: Alignment.center,
      child: isGrid
          ? const SizedBox(child: Text('Подробнее'))
          : const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Подробнее'),
            ),
    );
  }
}
