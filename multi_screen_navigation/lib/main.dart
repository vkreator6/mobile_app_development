import 'package:flutter/material.dart';

void main() => runApp(const StudyTrailApp());

class StudyTrailApp extends StatelessWidget {
  const StudyTrailApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Study Trail',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF176B60)),
      scaffoldBackgroundColor: const Color(0xFFF5F7F2),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF5F7F2)),
    ),
    home: const HomeScreen(),
  );
}

class StudyTopic {
  final String title;
  final String description;
  final IconData icon;
  const StudyTopic(this.title, this.description, this.icon);
}

const topics = [
  StudyTopic(
    'Flutter navigation',
    'Learn how routes form a stack. Push a new screen to move forward, then pop it to return to the previous screen.',
    Icons.alt_route,
  ),
  StudyTopic(
    'Stateful widgets',
    'Explore how local state changes the interface. Practice updating a widget with setState and preserving values while navigating.',
    Icons.tune,
  ),
];

class PageBody extends StatelessWidget {
  final List<Widget> children;
  const PageBody({super.key, required this.children});
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: ListView(padding: const EdgeInsets.all(24), children: children),
      ),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Study Trail')),
    body: PageBody(
      children: [
        const Text(
          'YOUR NEXT SMALL STEP',
          style: TextStyle(
            letterSpacing: 2,
            color: Color(0xFF176B60),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Make time to\nlearn something.',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 16),
        const Text(
          'Choose a topic, explore the details, and plan a focused study session.',
        ),
        const SizedBox(height: 32),
        for (final topic in topics) ...[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(topic.icon, size: 36, color: const Color(0xFF176B60)),
                  const SizedBox(height: 16),
                  Text(
                    topic.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  FilledButton.tonal(
                    onPressed: () => Navigator.push<void>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(topic: topic),
                      ),
                    ),
                    child: Text('Explore ${topic.title}'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ],
    ),
  );
}

class DetailsScreen extends StatefulWidget {
  final StudyTopic topic;
  const DetailsScreen({super.key, required this.topic});
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int? minutes;
  Future<void> planSession() async {
    final result = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            PlannerScreen(topic: widget.topic, initialMinutes: minutes ?? 25),
      ),
    );
    // Back/cancel returns null. Preserve any previously saved session.
    if (!mounted || result == null) return;
    setState(() => minutes = result);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Topic details')),
    body: PageBody(
      children: [
        const Text(
          '01 / EXPLORE',
          style: TextStyle(letterSpacing: 2, color: Color(0xFF176B60)),
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            widget.topic.icon,
            size: 56,
            color: const Color(0xFF176B60),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          widget.topic.title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 16),
        Text(
          widget.topic.description,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 32),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.schedule, color: Color(0xFF176B60)),
                const SizedBox(height: 12),
                Text(
                  minutes == null
                      ? 'Your session awaits'
                      : 'Session saved: $minutes minutes',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pick a duration that fits your day. Your plan stays here while you explore the planner.',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: planSession,
          child: Text(minutes == null ? 'Plan a session' : 'Edit session'),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Back to topics'),
        ),
      ],
    ),
  );
}

class PlannerScreen extends StatefulWidget {
  final StudyTopic topic;
  final int initialMinutes;
  const PlannerScreen({
    super.key,
    required this.topic,
    required this.initialMinutes,
  });
  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  late int selectedMinutes;
  @override
  void initState() {
    super.initState();
    selectedMinutes = widget.initialMinutes;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Session planner')),
    body: PageBody(
      children: [
        const Text(
          '02 / MAKE A PLAN',
          style: TextStyle(letterSpacing: 2, color: Color(0xFF176B60)),
        ),
        const SizedBox(height: 24),
        Text(
          'A little focus.\nReal progress.',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 16),
        Text(
          'Studying: ${widget.topic.title}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 32),
        const Text('Choose your session length'),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          children: [
            for (final value in [15, 25, 45])
              ChoiceChip(
                label: Text('$value minutes'),
                selected: selectedMinutes == value,
                onSelected: (_) => setState(() => selectedMinutes = value),
              ),
          ],
        ),
        const SizedBox(height: 24),
        const Card(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'One topic. One session.\nSet aside distractions and give yourself room to practice.',
            ),
          ),
        ),
        const SizedBox(height: 24),
        FilledButton.icon(
          // Return a typed value to the existing details route, not a new route.
          onPressed: () => Navigator.pop<int>(context, selectedMinutes),
          icon: const Icon(Icons.check),
          label: const Text('Save session'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel and go back'),
        ),
      ],
    ),
  );
}
