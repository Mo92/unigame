import 'package:flutter/material.dart';

class ResponsiveSelectionList extends StatelessWidget {
  const ResponsiveSelectionList({
    super.key,
    required this.children,
    this.widthTolerance = 350,
    this.verticalMainAxisAlignment = MainAxisAlignment.start,
    this.verticalMainAxisSize = MainAxisSize.min,
    this.horizontallMainAxisAlignment = MainAxisAlignment.start,
    this.horizontallMainAxisAxisSize = MainAxisSize.min,
  });

  final List<Widget> children;
  final int widthTolerance;
  final MainAxisAlignment verticalMainAxisAlignment;
  final MainAxisSize verticalMainAxisSize;
  final MainAxisAlignment horizontallMainAxisAlignment;
  final MainAxisSize horizontallMainAxisAxisSize;

  @override
  Widget build(BuildContext context) {
    /// Prüft die breite des Geräts und gibt dementsprechend eine vertikale
    /// oder horizontale Liste zurück.
    return MediaQuery.of(context).size.width < widthTolerance
        ? Column(
            mainAxisAlignment: verticalMainAxisAlignment,
            mainAxisSize: verticalMainAxisSize,
            children: children,
          )
        : Row(
            mainAxisAlignment: horizontallMainAxisAlignment,
            mainAxisSize: horizontallMainAxisAxisSize,
            children: children,
          );
  }
}
