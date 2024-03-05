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
      title: 'Flutter Demo',
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
        onPressed: () {
          Navigator.of(context).push(
            MyRoute(
              builder: (context) => HeroPage(
                heroType:
                    heroType == HeroType.from ? HeroType.to : HeroType.from,
              ),
            ),
          );
        },
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
}

class _HeroLetter extends StatelessWidget {
  final String letter;
  final String tag;

  const _HeroLetter({
    required this.letter,
    required this.tag,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Hero(
        tag: tag,
        child: Text(
          letter,
          style: GoogleFonts.slacksideOne(fontSize: 40, color: Colors.black),
        ),
        flightShuttleBuilder: (flightContext, animation, flightDirection,
            fromHeroContext, toHeroContext) {
          final Hero toHero = toHeroContext.widget as Hero;
          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return DefaultTextStyle(
                style: GoogleFonts.slacksideOne(fontSize: 40, color: Colors.black),
                child: toHero,
              );
            },
          );
        },
      );
}

class MyRoute extends MaterialPageRoute {
  MyRoute({required super.builder});

  @override
  Duration get transitionDuration => const Duration(seconds: 3);
}
