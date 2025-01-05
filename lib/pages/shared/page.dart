import 'package:flutter/material.dart';

class ScaffoldWrapper extends StatelessWidget {
  const ScaffoldWrapper({
    super.key,
    required this.child,
    this.appBar,
    this.persistentFooterButtons,
    this.persistentFooterAlignment,
  });

  final Widget child;
  final PreferredSizeWidget? appBar;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional? persistentFooterAlignment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery(
        data:
            MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.2)),
        child: child,
      ),
      appBar: appBar,
      persistentFooterButtons: persistentFooterButtons,
      persistentFooterAlignment:
          persistentFooterAlignment ?? AlignmentDirectional.center,
    );
  }
}
