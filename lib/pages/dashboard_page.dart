import 'package:flutter/material.dart';

import '../models/tricycle.dart';
import '../services/weather_service.dart';
import '../widgets/stat_card.dart';
import '../widgets/tricycle_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    super.key,
    required this.tricycles,
    required this.onEdit,
    required this.onDelete,
  });

  final List<Tricycle> tricycles;
  final ValueChanged<Tricycle> onEdit;
  final ValueChanged<Tricycle> onDelete;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final WeatherService _weatherService = WeatherService();
  late Future<WeatherInfo> _weather;

  @override
  void initState() {
    super.initState();
    _weather = _weatherService.fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    final activeCount = widget.tricycles
        .where((item) => item.status == 'Active')
        .length;
    final breakCount = widget.tricycles
        .where((item) => item.status == 'On Break')
        .length;
    final recentTricycles = widget.tricycles.reversed.take(3).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TrikeFlow'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.electric_rickshaw),
          ),
        ],
      ),
      body: ListView(
        key: const ValueKey('dashboard-list'),
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Fleet overview',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text('A quick look at your tricycle operations.'),
          const SizedBox(height: 12),
          StatCard(
            title: 'Total tricycles',
            value: widget.tricycles.length,
            icon: Icons.electric_rickshaw,
            color: const Color(0xFF17324D),
          ),
          StatCard(
            title: 'Active',
            value: activeCount,
            icon: Icons.check_circle_outline,
            color: const Color(0xFF168C87),
          ),
          StatCard(
            title: 'On break',
            value: breakCount,
            icon: Icons.pause_circle_outline,
            color: Colors.orange,
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.alt_route, color: Color(0xFF168C87)),
                  const SizedBox(width: 12),
                  const Expanded(child: Text('Routes in service')),
                  Text(
                    '${widget.tricycles.map((item) => item.route).toSet().length}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildWeatherCard(),
          const SizedBox(height: 16),
          Text(
            'Recently added',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (recentTricycles.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('No tricycles have been added yet.'),
              ),
            )
          else
            ...recentTricycles.map(
              (tricycle) => TricycleCard(
                tricycle: tricycle,
                onEdit: () => widget.onEdit(tricycle),
                onDelete: () => widget.onDelete(tricycle),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.wb_sunny_outlined, color: Color(0xFF168C87)),
            const SizedBox(width: 12),
            Expanded(
              child: FutureBuilder<WeatherInfo>(
                future: _weather,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final weather = snapshot.data!;
                    return Text(
                      'Weather now: ${weather.temperature}°C, '
                      '${weather.condition}',
                    );
                  }
                  if (snapshot.hasError) {
                    return const Text('Weather is unavailable right now.');
                  }
                  return const Text('Loading current weather...');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
