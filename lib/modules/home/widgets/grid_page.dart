import 'package:flutter/material.dart';
import 'package:perfumei/common/model/grid_model.dart';
import 'package:perfumei/modules/home/widgets/grid_row.dart';

class GridPage extends StatefulWidget {
  const GridPage({
    required this.dados,
    required this.onPressed,
    super.key,
    this.icon = Icons.error,
  });
  final List dados;
  final IconData icon;
  final Function onPressed;

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 1;
    final Size size = MediaQuery.of(context).size;
    double childAspectRatio = size.height / size.width;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      crossAxisCount = 2;
      childAspectRatio = size.width / size.height;
    }

    return GridView.builder(
        shrinkWrap: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 1.0,
          childAspectRatio: childAspectRatio + 0.2,
        ),
        itemCount: widget.dados.length,
        itemBuilder: (context, index) {
          return GridRow(
            grid: GridModel.fromJson(widget.dados[index]),
            icon: widget.icon,
            onPressed: widget.onPressed,
          );
        });
  }
}
