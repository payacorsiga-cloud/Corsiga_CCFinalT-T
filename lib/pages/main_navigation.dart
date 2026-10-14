import 'package:flutter/material.dart';

import '../models/tricycle.dart';
import 'about_page.dart';
import 'dashboard_page.dart';
import 'tricycle_form_page.dart';
import 'tricycles_page.dart';
import 'weather_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedTab = 0;
  final List<Tricycle> _tricycles = Tricycle.sampleRecords();

  Future<void> _openForm({Tricycle? tricycle}) async {
    final result = await Navigator.push<Tricycle>(
      context,
      MaterialPageRoute(
        builder: (context) => TricycleFormPage(tricycle: tricycle),
      ),
    );
    if (result == null || !mounted) return;

    setState(() {
      if (tricycle == null) {
        _tricycles.add(result);
      } else {
        tricycle
          ..plateNumber = result.plateNumber
          ..driverName = result.driverName
          ..route = result.route
          ..status = result.status;
      }
    });
  }

  Future<void> _deleteTricycle(Tricycle tricycle) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete tricycle?'),
        content: Text('Remove ${tricycle.plateNumber} from the fleet?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const ValueKey('confirm-delete-tricycle'),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete == true && mounted) {
      setState(() => _tricycles.remove(tricycle));
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      DashboardPage(
        tricycles: _tricycles,
        onEdit: (tricycle) => _openForm(tricycle: tricycle),
        onDelete: _deleteTricycle,
      ),
      TricyclesPage(
        tricycles: _tricycles,
        onAdd: () => _openForm(),
        onEdit: (tricycle) => _openForm(tricycle: tricycle),
        onDelete: _deleteTricycle,
      ),
      const WeatherPage(),
      const AboutPage(),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedTab, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) {
          setState(() => _selectedTab = index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(
            icon: Icon(Icons.electric_rickshaw),
            label: 'Fleet',
          ),
          NavigationDestination(
            icon: Icon(Icons.cloud_outlined),
            label: 'Weather',
          ),
          NavigationDestination(icon: Icon(Icons.info_outline), label: 'About'),
        ],
      ),
    );
  }
}
