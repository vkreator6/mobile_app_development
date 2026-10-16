import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const GestureLabApp());

class GestureLabApp extends StatelessWidget {
  const GestureLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const GestureScreen(),
    );
  }
}

class GestureScreen extends StatefulWidget {
  const GestureScreen({super.key});

  @override
  State<GestureScreen> createState() => _GestureScreenState();
}

class _GestureScreenState extends State<GestureScreen> {
  static const _colors = [
    Colors.indigo,
    Colors.teal,
    Colors.deepOrange,
    Colors.purple,
  ];

  int _tapCount = 0;
  int _swipeCount = 0;
  double _dragDistance = 0;
  Color _cardColor = _colors.first;
  String _message = 'Choose a gesture to begin.';

  void _handleTap() {
    HapticFeedback.selectionClick();
    setState(() {
      _tapCount++;
      _cardColor = _colors[_tapCount % _colors.length];
      _message = 'Tap detected. The card changed color.';
    });
  }

  void _handleLongPress() {
    HapticFeedback.mediumImpact();
    setState(() {
      _tapCount = 0;
      _swipeCount = 0;
      _cardColor = _colors.first;
      _message = 'Long press detected. The card and counts reset.';
    });
  }

  void _handleSwipe(DragEndDetails details) {
    final direction = _dragDistance < 0 ? 'left' : 'right';
    HapticFeedback.selectionClick();
    setState(() {
      _swipeCount++;
      _cardColor = _colors[(_tapCount + _swipeCount) % _colors.length];
      _message = 'Swipe $direction detected. Swipe count: $_swipeCount.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gesture Lab')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Try the gestures',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Tap, swipe, or press and hold the card. Each action gives visual and haptic feedback.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _handleTap,
                    onLongPress: _handleLongPress,
                    onHorizontalDragStart: (_) => _dragDistance = 0,
                    onHorizontalDragUpdate: (details) =>
                        _dragDistance += details.delta.dx,
                    onHorizontalDragEnd: _handleSwipe,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      width: double.infinity,
                      constraints: const BoxConstraints(minHeight: 260),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: _cardColor,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.touch_app,
                            size: 52,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Gesture card',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _message,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Taps: $_tapCount     Swipes: $_swipeCount',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              const Text(
                'Tap: change color  •  Swipe: update count  •  Long press: reset',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
