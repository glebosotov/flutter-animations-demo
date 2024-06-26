import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hero demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HeroPage(
        heroType: HeroType.from,
      ),
    );
  }
}

enum HeroType { from, to }

class HeroPage extends StatelessWidget {
  final HeroType heroType;
  const HeroPage({
    required this.heroType,
    super.key,
  });

  static const fromLetters = [
    ('T', 'T'),
    ('O', 'O1'),
    ('M ', 'M1'),
    ('M', 'M2'),
    ('A', 'A'),
    ('R', 'R1'),
    ('V', 'V'),
    ('O', 'O2'),
    ('L', 'L1'),
    ('O ', 'O'),
    ('R', 'R2'),
    ('I', 'I'),
    ('D', 'D1'),
    ('D', 'D2'),
    ('L', 'L2'),
    ('E', 'E'),
  ];

  static const toLetters = [
    ('I ', 'I'),
    ('A', 'A'),
    ('M ', 'M1'),
    ('L', 'L1'),
    ('O', 'O1'),
    ('R', 'R1'),
    ('D ', 'D1'),
    ('V', 'V'),
    ('O', 'O2'),
    ('L', 'L2'),
    ('D', 'D2'),
    ('E', 'E'),
    ('M', 'M2'),
    ('O', 'O'),
    ('R', 'R2'),
    ('T', 'T'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onTap(context),
        child: const Icon(Icons.flip),
      ),
      body: Center(
        child: Text.rich(
          TextSpan(
            children: (heroType == HeroType.from ? fromLetters : toLetters)
                .map(
                  (e) => WidgetSpan(
                    child: _HeroLetter(letter: e.$1, tag: e.$2),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context) => Navigator.of(context).push(
        CustomPageRoute(
          builder: (context) => HeroPage(
            heroType: heroType == HeroType.from ? HeroType.to : HeroType.from,
          ),
        ),
      );
}

class _HeroLetter extends StatelessWidget {
  static final textStyle =
      GoogleFonts.slacksideOne(fontSize: 40, color: Colors.black);
  final String letter;
  final String tag;

  const _HeroLetter({
    required this.letter,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) => Hero(
        tag: tag,
        // Important to provide this [DefaultTextStyle] so that in-flight
        // widget is wrapped into a theme
        child: DefaultTextStyle(
          style: textStyle,
          child: Text(
            letter,
            style: textStyle,
          ),
        ),
      );
}

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({required super.builder});

  @override
  Duration get transitionDuration => const Duration(seconds: 3);
}
