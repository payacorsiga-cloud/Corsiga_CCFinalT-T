import 'package:flutter/material.dart';

import '../models/tricycle.dart';
import '../widgets/tricycle_card.dart';

class TricyclesPage extends StatefulWidget {
  const TricyclesPage({
    super.key,
    required this.tricycles,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  final List<Tricycle> tricycles;
  final VoidCallback onAdd;
  final ValueChanged<Tricycle> onEdit;
  final ValueChanged<Tricycle> onDelete;

  @override
  State<TricyclesPage> createState() => _TricyclesPageState();
}

class _TricyclesPageState extends State<TricyclesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final search = _searchController.text.toLowerCase();
    final shownTricycles = widget.tricycles.where((tricycle) {
      final matchesSearch =
          tricycle.plateNumber.toLowerCase().contains(search) ||
          tricycle.driverName.toLowerCase().contains(search) ||
          tricycle.route.toLowerCase().contains(search);
      final matchesFilter = _filter == 'All' || tricycle.status == _filter;
      return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Fleet management')),
      floatingActionButton: FloatingActionButton.extended(
        key: const ValueKey('add-tricycle'),
        onPressed: widget.onAdd,
        icon: const Icon(Icons.add),
        label: const Text('Add tricycle'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search plate, driver, or route',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.clear),
                      ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButtonFormField<String>(
              initialValue: _filter,
              decoration: const InputDecoration(
                labelText: 'Filter by status',
                filled: true,
                fillColor: Colors.white,
              ),
              items: const [
                DropdownMenuItem(value: 'All', child: Text('All')),
                DropdownMenuItem(value: 'Active', child: Text('Active')),
                DropdownMenuItem(value: 'On Break', child: Text('On Break')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _filter = value);
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: shownTricycles.isEmpty
                ? const Center(child: Text('No matching tricycles.'))
                : ListView.builder(
                    key: const ValueKey('fleet-list'),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                    itemCount: shownTricycles.length,
                    itemBuilder: (context, index) {
                      final tricycle = shownTricycles[index];
                      return TricycleCard(
                        tricycle: tricycle,
                        onEdit: () => widget.onEdit(tricycle),
                        onDelete: () => widget.onDelete(tricycle),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
