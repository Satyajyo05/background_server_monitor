import 'package:flutter/material.dart';

Widget _openFields(BuildContext context, bool isDisableChecked, bool isAllSignsreqChecked) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      children: [
        ListTile(
          title: const Text('Disable Order'),
          trailing: isDisableChecked ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
        ),
      ],
    ),
  );
}
