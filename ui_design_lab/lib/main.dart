import 'package:flutter/material.dart';

void main() => runApp(const LabApp());

class LabApp extends StatelessWidget {
  const LabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UI Lab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter UI Lab')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.touch_app, size: 64, color: Colors.indigo),
            const SizedBox(height: 20),
            const Text('Welcome!', style: TextStyle(fontSize: 28)),
            const SizedBox(height: 12),
            const Text('Open the counter and try the buttons.'),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const CounterScreen(),
                ),
              ),
              child: const Text('Open counter'),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tap Counter')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Button taps', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 12),
            Text('$_count', style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 12),
            Text(
              _count == 0
                  ? 'Tap the button to begin.'
                  : 'The counter has updated!',
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => setState(() => _count++),
              child: const Text('Add one'),
            ),
            TextButton(
              onPressed: () => setState(() => _count = 0),
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
