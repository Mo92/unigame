import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shadow_deals/core/mdstring.dart';

class MarkdownPage extends StatelessWidget {
  MarkdownPage({super.key, required this.isImprint});

  final bool isImprint;
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(isImprint ? 'Impressum' : 'Datenschutzerklärung'),
      ),
      body: Markdown(data: isImprint ? imprintMarkdown : privacyPolicyMarkdown),
    );
  }
}
