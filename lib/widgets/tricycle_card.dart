import 'package:flutter/material.dart';

import '../models/tricycle.dart';

class TricycleCard extends StatelessWidget {
  const TricycleCard({
    super.key,
    required this.tricycle,
    required this.onEdit,
    required this.onDelete,
  });

  final Tricycle tricycle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final isActive = tricycle.status == 'Active';
    final statusColor = isActive ? const Color(0xFF168C87) : Colors.orange;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE4F3F1),
          child: Icon(Icons.electric_rickshaw, color: statusColor),
        ),
        title: Text(
          tricycle.plateNumber,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tricycle.driverName),
              Text(tricycle.route),
              Text(
                tricycle.status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          key: ValueKey('actions-${tricycle.plateNumber}'),
          tooltip: 'Tricycle actions',
          onSelected: (action) {
            if (action == 'edit') onEdit();
            if (action == 'delete') onDelete();
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'edit', child: Text('Edit')),
            PopupMenuItem(value: 'delete', child: Text('Delete')),
          ],
          icon: const Icon(Icons.more_horiz),
        ),
      ),
    );
  }
}
