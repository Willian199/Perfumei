import 'package:flutter/material.dart';
import 'package:flutter_ddi/flutter_ddi.dart';
import 'package:perfumei/common/model/layout.dart';

class RowValue extends StatelessWidget {
  const RowValue({required this.value, required this.icon, super.key});
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final Layout layout = context.get();

    return Row(
      children: <Widget>[
        Text(
          value,
          style: layout.itemsTextStyle,
        ),
      ],
    );
  }
}
