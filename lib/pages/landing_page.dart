import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadow_deals/logic/game/game_bloc.dart';
import 'package:shadow_deals/pages/game/widgets/bullet_point.dart';
import 'package:shadow_deals/pages/game/game_page.dart';
import 'package:shadow_deals/pages/shared/markdown_page.dart';
import 'package:shadow_deals/pages/shared/page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  Widget _buildBody(BuildContext context) {
    final bool usePlayerTerm = Random().nextBool();

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 42),
              Text(
                'Das Spiel ums große Geld',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Willkommen in der dunklen Welt des illegalen Handels – einem Ort, an dem Profit über alles geht und niemandem zu trauen ist. Du bist ein aufstrebender Dealer, der bereit ist, große Risiken einzugehen, um in der Unterwelt zu überleben. Deine Mission ist klar: Sorge dafür, dass am Ende möglichst viel Geld in deiner Tasche landet. Doch Vorsicht – deine Dealer haben dasselbe Ziel wie du.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '1. Deine Mission',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              RichText(
                textScaler: TextScaler.linear(1.2),
                text: TextSpan(
                  style: TextStyle(fontSize: 16),
                  text: 'Dein Ziel ist einfach: ',
                  children: [
                    TextSpan(
                      text: 'Verdiene so viel Profit wie möglich.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          ' Jede Entscheidung, die du triffst, kann dich entweder reicher oder ärmer machen. In jedem Deal entscheidest du, ob du ehrlich bist oder betrügst.',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Je mehr Punkte du sammelst, desto größer wird dein Gewinn. Am Ende wirst du sehen, ob du ein geborener Unterwelt-Boss bist oder auf halbem Weg gescheitert bist.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '2. Das Geschäft',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              RichText(
                textScaler: TextScaler.linear(1.2),
                text: TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      'Das Spiel besteht aus einer Reihe von heißen Deals, bei denen Geld und Ware getauscht werden. Doch in dieser Welt gibt es keine Regeln – nur deinen Instinkt und deine Gier.',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Jede Runde hast du zwei Möglichkeiten:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              BulletPoint(
                text:
                    'Ehrlich handeln: Ihr haltet euch beide an die Abmachung und teilt den Gewinn.',
              ),
              BulletPoint(
                text:
                    'Betrügen: Du nimmst alles für dich – aber wenn dein Dealer dasselbe tut, bleibt kaum etwas übrig.',
              ),
              SizedBox(height: 16),
              RichText(
                textScaler: TextScaler.linear(1.2),
                text: TextSpan(
                  text: 'Der jeweilige Dealer, der im Spiel agiert ',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    if (!usePlayerTerm)
                      TextSpan(
                        text: '(gesteuert vom Computer), ',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    TextSpan(
                      text:
                          'hat eine eigene Strategie${usePlayerTerm ? '' : ', die von uns entwickelt wurde'}. Kannst du ihn durchschauen?',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                '3. Dein Gewinnsystem',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'So funktioniert das Geschäft:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              BulletPoint(
                text:
                    'Ehrlich + Ehrlich: Beide halten sich an den Deal und verdienen solide.',
              ),
              BulletPoint(text: '3 Punkte für beide.'),
              SizedBox(height: 8),
              BulletPoint(
                text:
                    'Ehrlich + Betrügen: Der Betrüger räumt ab, der Ehrliche geht leer aus.',
              ),
              BulletPoint(text: 'Betrüger: 5 Punkte, Ehrlicher: 0 Punkte.'),
              SizedBox(height: 8),
              BulletPoint(
                text:
                    'Betrügen + Betrügen: Ihr versucht beide, euch zu überlisten. Der Deal scheitert, und der Gewinn ist minimal.',
              ),
              BulletPoint(text: '1 Punkt für beide.'),
              SizedBox(height: 16),
              Text(
                'Rundenanzahl:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Das Spiel besteht aus mehreren Deals. Deine Entscheidungen bestimmen, wie viel Profit du am Ende machst.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (_) => GameBloc(),
                      child: GamePage(usePlayerTerm: usePlayerTerm),
                    ),
                  ),
                ),
                child: const Text('Spiel starten'),
              ),
              const SizedBox(height: 140),
            ],
          ),
        ),
      ),
    );
  }

  void routeToMarkdownPages(BuildContext context, bool isImprint) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MarkdownPage(isImprint: isImprint),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Shadow Deals'),
      ),
      persistentFooterButtons: [
        TextButton(
          onPressed: () => routeToMarkdownPages(context, true),
          child: Text('Impressum'),
        ),
        TextButton(
          onPressed: () => routeToMarkdownPages(context, false),
          child: Text('Datenschutzerklärung'),
        )
      ],
      persistentFooterAlignment: AlignmentDirectional.centerEnd,
      child: _buildBody(context),
    );
  }
}
