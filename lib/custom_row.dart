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