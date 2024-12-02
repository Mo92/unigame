import 'package:flutter/material.dart';

class AnimatedButtonsRow extends StatefulWidget {
  const AnimatedButtonsRow({super.key});

  @override
  AnimatedButtonsRowState createState() => AnimatedButtonsRowState();
}

class AnimatedButtonsRowState extends State<AnimatedButtonsRow> {
  bool _isFirstButtonActive = true; // Steuert, welcher Button aktiv ist

  @override
  void initState() {
    super.initState();
    _startAnimation();
  }

  // Die Animation wechseln
  void _startAnimation() {
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isFirstButtonActive = !_isFirstButtonActive;
        });
        _startAnimation();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: AnimatedContainer(
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: _isFirstButtonActive
                  ? Colors.transparent
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ElevatedButton(
              onPressed: null,
              child: Text(
                'Ehrlich handeln',
                style: TextStyle(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Flexible(
          child: AnimatedContainer(
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: !_isFirstButtonActive
                  ? Colors.transparent
                  : Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: Text('Betrügen', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }
}
