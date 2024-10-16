import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_table/flutter_expandable_table.dart';
import './custom_row.dart';
import './cell_card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<CustomRow> tableRows = [
    CustomRow(
        index: 0,
        depth: 0,
        parentIndex: null,
        expanded: false,
        expandable: true,
        visible: true,
        label: 'Row 1'),
    CustomRow(
        index: 1,
        depth: 1,
        parentIndex: 0,
        visible: false,
        expanded: false,
        expandable: false,
        label: 'Row 1.1'),
    CustomRow(
        index: 2,
        depth: 1,
        parentIndex: 0,
        visible: false,
        expanded: false,
        expandable: false,
        label: 'Row 1.2'),
    CustomRow(
        index: 3,
        depth: 0,
        parentIndex: null,
        visible: true,
        expanded: false,
        expandable: true,
        label: 'Row 2'),
    CustomRow(
        index: 4,
        depth: 1,
        parentIndex: 3,
        visible: false,
        expanded: false,
        expandable: true,
        label: 'Row 2.1'),
    CustomRow(
        index: 5,
        depth: 2,
        parentIndex: 4,
        visible: false,
        expanded: false,
        expandable: false,
        label: 'Row 2.1.1'),
    CustomRow(
        index: 6,
        depth: 2,
        parentIndex: 4,
        visible: false,
        expanded: false,
        expandable: false,
        label: 'Row 2.1.2'),
    CustomRow(
        index: 7,
        depth: 2,
        parentIndex: 4,
        visible: false,
        expanded: false,
        expandable: false,
        label: 'Row 2.1.3'),
    CustomRow(
        index: 8,
        depth: 1,
        parentIndex: 3,
        visible: false,
        expanded: false,
        expandable: false,
        label: 'Row 2.2'),
    CustomRow(
        index: 9,
        parentIndex: null,
        visible: true,
        depth: 0,
        expanded: false,
        expandable: false,
        label: 'Row 3'),
    CustomRow(
        index: 10,
        parentIndex: null,
        depth: 0,
        expanded: false,
        expandable: true,
        visible: true,
        label: 'Row 4'),
    CustomRow(
        index: 11,
        parentIndex: 10,
        depth: 1,
        expanded: false,
        expandable: false,
        visible: false,
        label: 'Row 4.1'),
    CustomRow(
        index: 12,
        parentIndex: 10,
        depth: 1,
        expanded: false,
        expandable: false,
        visible: false,
        label: 'Row 4.2'),
    CustomRow(
        index: 13,
        parentIndex: 10,
        visible: false,
        depth: 1,
        expanded: false,
        expandable: false,
        label: 'Row 4.3'),
    CustomRow(
        index: 14,
        parentIndex: 10,
        visible: false,
        depth: 1,
        expanded: false,
        expandable: false,
        label: 'Row 4.4'),
    CustomRow(
        index: 15,
        parentIndex: null,
        visible: true,
        depth: 0,
        expanded: false,
        expandable: true,
        label: 'Row 5'),
    CustomRow(
        index: 16,
        parentIndex: 15,
        visible: false,
        depth: 1,
        expanded: false,
        expandable: true,
        label: 'Row 5.1'),
    CustomRow(
        index: 17,
        parentIndex: 16,
        visible: false,
        depth: 2,
        expanded: false,
        expandable: false,
        label: 'Row 5.1.1'),
    CustomRow(
        index: 18,
        parentIndex: 16,
        visible: false,
        depth: 2,
        expanded: false,
        expandable: false,
        label: 'Row 5.1.2'),
    CustomRow(
        index: 19,
        parentIndex: 15,
        visible: false,
        depth: 1,
        expanded: false,
        expandable: true,
        label: 'Row 5.2'),
    CustomRow(
        index: 20,
        parentIndex: 19,
        visible: false,
        depth: 2,
        expanded: false,
        expandable: false,
        label: 'Row 5.2.1'),
    CustomRow(
        index: 21,
        parentIndex: 19,
        visible: false,
        depth: 2,
        expanded: false,
        expandable: false,
        label: 'Row 5.2.2'),
  ];

  List <CustomRow> renderRows = [];
  List<ExpandableTableHeader> headers = [];
  final int columnsCount = 20;
  final int subRowsCount = 2;

  @override
  void initState() {
    setState(() {
      renderRows = [...tableRows].where((row) => row.visible).toList();
      headers = List.generate(
        columnsCount - 1,
        (index) => ExpandableTableHeader(
          width: index % 2 == 0 ? 200 : 150,
          cell: buildCell('Column $index'),
        ),
      );
    });

    super.initState();
  }

  ExpandableTableCell buildCell(String content, {CellBuilder? builder}) {
    return ExpandableTableCell(
      child: builder != null
          ? null
          : DefaultCellCard(
              child: Center(
                child: Text(
                  content,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
      builder: builder,
    );
  }

  ExpandableTableCell buildFirstRowCell() => ExpandableTableCell(
        builder: (context, details) => DefaultCellCard(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Row(
              children: [
                SizedBox(
                  width: 24 * details.row!.address.length.toDouble(),
                  child: details.row?.children != null
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: AnimatedRotation(
                            duration: const Duration(milliseconds: 500),
                            turns: details.row?.childrenExpanded == true
                                ? 0.25
                                : 0,
                            child: const Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : null,
                ),
                Text(
                  '${details.row!.address.length > 1 ? details.row!.address.skip(1).map((e) => 'Sub ').join() : ''}Row ${details.row!.address.last}',
                ),
              ],
            ),
          ),
        ),
      );

  List<ExpandableTableRow> generateRows(int quantity, {int depth = 0}) {
    final bool generateLegendRow = (depth == 0 || depth == 2);
    return renderRows.map((row) => ExpandableTableRow(
        firstCell: buildFirstRowCell(),
        children: ((row.index < renderRows.length) && depth < 3)
            ? generateRows(subRowsCount, depth: depth + 1)
            : null,
        cells: 
             List<ExpandableTableCell>.generate(
                columnsCount,
                (columnIndex) => buildCell('${row.label}- cell $columnIndex'),
              ),
        legend: null,
      ),
    ).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('expandable table')),
        body: Row(children: [
          Expanded(
              child: SingleChildScrollView(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: buildExpandableTable())))
        ]));
  }

  ExpandableTable buildExpandableTable() {
    return ExpandableTable(
      firstHeaderCell: buildCell('Simple\nTable'),
      rows: generateRows(renderRows.length),
      headers: headers,
      // defaultsRowHeight: 60,
      // defaultsColumnWidth: 150,
      // firstColumnWidth: 250,
      scrollShadowColor: Colors.grey,
      visibleScrollbar: true,
      expanded: false,
    );
  }
}
