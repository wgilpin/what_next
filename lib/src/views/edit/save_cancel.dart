import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:what_next/src/utils/layout.dart';

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
        addVerticalSpace(20),
        ElevatedButton(
          onPressed: onCancel ?? () => Get.back(),
          child: Text(cancelLbl),
        ),
      ],
    );
  }
}
