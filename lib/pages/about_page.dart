import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About TrikeFlow')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.electric_rickshaw,
                    size: 48,
                    color: Color(0xFF168C87),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'TrikeFlow - Digital Management System',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'TrikeFlow helps organize tricycles, drivers, routes, '
                    'and vehicle availability in one simple mobile app.',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Card(
            child: ListTile(
              leading: Icon(Icons.people_outline, color: Color(0xFF168C87)),
              title: Text('Intended users'),
              subtitle: Text(
                'Tricycle operators, dispatchers, and local transport teams.',
              ),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.checklist, color: Color(0xFF168C87)),
              title: Text('Main features'),
              subtitle: Text(
                'Fleet search, status filters, driver and route records, '
                'dashboard totals, and current weather.',
              ),
            ),
          ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline, color: Color(0xFF168C87)),
              title: Text('About data storage'),
              subtitle: Text(
                'Fleet records are kept in memory while the app is open. '
                'They reset when the app restarts because permanent database '
                'storage is not included.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
