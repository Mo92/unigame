import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString(
          isImprint
              ? 'assets/markdown/imprint.md'
              : 'assets/markdown/privacy_policy.md',
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null || snapshot.error != null) {
            return Center(
              child: Text('Fehler, bitte lade die Seite erneut.'),
            );
          }

          return Markdown(data: snapshot.data!);
        },
      ),
    );
  }
}
