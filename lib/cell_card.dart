import 'package:flutter/material.dart';

class DefaultCellCard extends StatelessWidget {
  final Widget child;

  const DefaultCellCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        margin: const EdgeInsets.all(1),
        child: child,
      );
}