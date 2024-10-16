import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  List renderRows = [];

  void expandChildren(int tappedIndex) {
    // debugPrint('tappedIndex: $tappedIndex');
    setState(() {
      tableRows[tappedIndex] = tableRows[tappedIndex]
          .copyWith(expanded: !tableRows[tappedIndex].expanded);
      // debugPrint('tableRows[tappedIndex]: ${tableRows[tappedIndex].expanded}');

      if (tableRows[tappedIndex].expanded) {
        tableRows = tableRows.map((row) {
          if (row.parentIndex == tappedIndex) {
            return row.copyWith(visible: true);
          }
          return row;
        }).toList();
      } else {
        final currentParentDepth = tableRows[tappedIndex].depth;
        for (int i = tappedIndex + 1; i < tableRows.length; i++) {
          if (tableRows[i].depth == currentParentDepth) {
            break;
          }

          if (tableRows[i].expandable) {
            tableRows[i] =
                tableRows[i].copyWith(visible: false, expanded: false);
          } else {
            tableRows[i] = tableRows[i].copyWith(visible: false);
          }
        }
      }

      renderRows = tableRows.where((row) => row.visible).toList();
    });
  }

  DataCell getCellWithIconButton(bool isExpanded, int index, int depth, String label) {
    return DataCell(SizedBox(width:  300, child: Row(children: [
      SizedBox(width: (20 * depth).toDouble()),
      IconButton(
        icon: Icon(isExpanded ? Icons.remove : Icons.add, size: 20),
        onPressed: () {
          expandChildren(index);
        },
      ),
      SizedBox(width: 10),
      Text(label)
    ])));
  }

  @override
  void initState() {
    setState(() {
      renderRows = [...tableRows].where((row) => row.visible).toList();
    });

    super.initState();
  }

  List<DataCell> getCells(CustomRow row) {
    final firstCell = row.expandable
        ? getCellWithIconButton(
          row.expanded,
            row.index, row.depth, '${row.label} - cell 0')
        : DataCell(SizedBox(width:  300, child: Row(
            children: [
              SizedBox(width: (20 * row.depth + 50).toDouble()), // 50 is size of icon button
              Text('${row.label} - cell 0')
            ]),
          ));
    return [
      firstCell,
      ...List.generate(
          9, (int index) => DataCell(Text('${row.label} - cell ${index + 1}')))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('expandable table')),
      body: Row(
        children: [
          Expanded(
              child: SingleChildScrollView(
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        dataRowMinHeight: 0,
                        columns: List.generate(
                            10,
                            (int index) =>
                                DataColumn(label: Text('Column $index')),
                            growable: false),
                        rows: renderRows.map((row) {
                          return DataRow(cells: getCells(row));
                        }).toList(),
                      ))))
        ],
      ),
    );
  }
}

class CustomRow {
  final int depth;
  final String label;
  final bool expandable;
  final bool expanded;
  final bool visible;
  final int? parentIndex;
  final int index;

  CustomRow(
      {required this.depth,
      required this.index,
      required this.expanded,
      required this.expandable,
      required this.visible,
      required this.label,
      required this.parentIndex});

  CustomRow copyWith(
      {int? depth,
      String? label,
      bool? expandable,
      bool? expanded,
      bool? visible,
      int? parentIndex,
      int? index}) {
    return CustomRow(
        visible: visible ?? this.visible,
        index: index ?? this.index,
        parentIndex: parentIndex ?? this.parentIndex,
        depth: depth ?? this.depth,
        expanded: expanded ?? this.expanded,
        expandable: expandable ?? this.expandable,
        label: label ?? this.label);
  }

  String stringify() {
    return 'index: $index parentIndex: $parentIndex label: $label expanded: $expanded expandable: $expandable';
  }
}
