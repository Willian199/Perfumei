import 'package:flutter/material.dart';
import 'package:perfumei/model/GridModel.dart';
import 'package:perfumei/page/GridPage/GridRow.dart';

class GridPage extends StatefulWidget {
  final List dados;
  final IconData icon;
  final Function onPressed;

  const GridPage({
    super.key,
    required this.dados,
    required this.onPressed,
    this.icon = Icons.error,
  });

  @override
  _GridPageState createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int crossAxisCount = 1;
    Size size = MediaQuery.of(context).size;
    double childAspectRatio = size.height / size.width;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      crossAxisCount = 2;
      childAspectRatio = size.width / size.height;
    }

    return GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 0,
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
