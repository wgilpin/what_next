import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaveCancel extends StatelessWidget {
  const SaveCancel(
      {super.key,
      required this.saveLbl,
      this.onSave,
      required this.cancelLbl,
      this.onCancel});

  final String saveLbl;
  final void Function()? onSave;
  final String cancelLbl;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: onSave,
          child: Text(saveLbl),
        ),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
          onPressed: onCancel ?? () => Get.back(),
          child: Text(cancelLbl),
        ),
      ],
    );
  }
}
