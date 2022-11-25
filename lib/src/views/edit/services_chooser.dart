import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/controllers/service_controller.dart';

import '../../models/service.dart';

class ServicesChooser extends StatelessWidget {
  String? initialService;
  ServicesChooser({super.key, this.initialService});

  final services = Get.find<ServiceCtl>().serviceList;

  RxString selectedService = RxString('');
  @override
  Widget build(BuildContext context) {
    selectedService.value = initialService ?? '';

    return Obx(() {
      return DropdownButton<String>(
        value: selectedService.value.isEmpty
            ? services[0].title
            : selectedService.value,
        icon: const Icon(Icons.arrow_downward),
        itemHeight: 70,
        elevation: 16,
        underline: null,
        onChanged: (String? value) {
          // This is called when the user selects an item.
          selectedService.value = value!;
        },
        items: services.map<DropdownMenuItem<String>>((Service value) {
          return DropdownMenuItem<String>(
            value: value.title,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(children: [
                Image.network(
                  value.url ?? '',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(value.title),
              ]),
            ),
          );
        }).toList(),
      );
    });
  }
}
