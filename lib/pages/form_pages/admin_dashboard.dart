import 'package:flutter/material.dart';


class ObjectDataTable extends StatelessWidget {
  final List<String> columnNames;
  final List<List<Widget>> rowData;
  final BoxConstraints constraint;
  const ObjectDataTable(
      {Key? key,
      required this.constraint,
      required this.rowData,
      required this.columnNames})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = constraint.maxWidth-50;
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: DataTable(
          dataRowHeight: 100,
          columnSpacing: 0,
          dividerThickness: 0,
          columns: List<DataColumn>.generate(
            columnNames.length,
            (int index,) => DataColumn(
              label: CustomCell(
                isHeader: true,
                width: width,
                columnCnt: columnNames.length,
                start: (index == 0),
                end: (index == columnNames.length - 1),
                color: Colors.black,
                child: Text(
                  columnNames[index],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.amber
                  ),
                ),
              ),
              numeric: false,
            ),
          ),
          rows: List<DataRow>.generate(
            rowData.length, (int index1,) => DataRow(
              cells: List<DataCell>.generate(
                rowData[index1].length, (int index,) => DataCell(
                CustomCell(
                  width: width,
                  columnCnt: rowData[index1].length,
                  start: (index == 0),
                  end: (index == rowData[index1].length - 1),
                  child:
                  rowData[index1][index],
                ),
              ),
              ),
            ),
          ),
      ),
    );
  }
}

class CustomCell extends StatelessWidget {
  final double width;
  final bool start;
  final bool end;
  final Widget? child;
  final int columnCnt;
  final Color? color;
  final bool isHeader;

  const CustomCell(
      {Key? key,
      this.isHeader=false,  
      required this.width,
      required this.columnCnt,
      this.color,
      this.child,
      this.start = false,
      this.end = false})
      : super(key: key);

  BorderRadius getBorderRadius() {
    BorderRadius borderRadius = BorderRadius.zero;
    if (!(start && end)) {
      if (start) {
        borderRadius = const BorderRadius.only(
            bottomLeft: Radius.circular(10), topLeft: Radius.circular(10));
      } else if (end) {
        borderRadius = const BorderRadius.only(
            bottomRight: Radius.circular(10), topRight: Radius.circular(10));
      }
    }
    return borderRadius;
  }

  Color getColor() {
    Color myColor = Colors.grey;
    if (color != null) {
      myColor = color!;
    }
    return myColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isHeader?40:70,
      width: width / columnCnt,
      decoration: BoxDecoration(
        color: getColor(),
        borderRadius: getBorderRadius(),
      ),
      child: Center(
          child: child),
    );
  }
}