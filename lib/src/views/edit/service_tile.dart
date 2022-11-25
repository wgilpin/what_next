import 'package:flutter/material.dart';
import 'package:what_next/src/models/service.dart';

class ServiceTile extends StatelessWidget {
  final Service service;

  const ServiceTile({
    Key? key,
    required this.service,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Image.network(
        service.url ?? '',
        width: 50,
        height: 50,
      ),
      const SizedBox(
        width: 10,
      ),
      Text(service.title),
    ]);
  }
}
