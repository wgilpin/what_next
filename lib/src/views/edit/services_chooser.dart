import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/service_controller.dart';
import 'package:what_next/src/views/edit/service_tile.dart';

import '../../models/service.dart';

class ServicesChooser extends StatelessWidget {
  final String? initialService;
  final Function(String) onChanged;

  ServicesChooser({super.key, this.initialService, required this.onChanged});

  // state
  final services = Get.find<ServiceCtl>().serviceList;
  final RxString selectedService = RxString('');

  @override
  Widget build(BuildContext context) {
    selectedService.value = initialService ?? '';

    return Obx(() {
      return DropdownButton<String>(
        value: selectedService.value.isEmpty
            ? services[0].title
            : selectedService.value,
        icon: const Icon(Icons.expand_more),
        itemHeight: 70,
        elevation: 16,
        underline: null,
        onChanged: (String? value) {
          // This is called when the user selects an item.
          selectedService.value = value!;
          onChanged(value);
        },
        items: services.map<DropdownMenuItem<String>>((Service value) {
          return DropdownMenuItem<String>(
            value: value.title,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ServiceTile(
                service: value,
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}
