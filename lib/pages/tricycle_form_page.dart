import 'package:flutter/material.dart';

import '../models/tricycle.dart';

class TricycleFormPage extends StatefulWidget {
  const TricycleFormPage({super.key, this.tricycle});

  final Tricycle? tricycle;

  @override
  State<TricycleFormPage> createState() => _TricycleFormPageState();
}

class _TricycleFormPageState extends State<TricycleFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _plateController;
  late final TextEditingController _driverController;
  late final TextEditingController _routeController;
  late String _status;

  @override
  void initState() {
    super.initState();
    _plateController = TextEditingController(
      text: widget.tricycle?.plateNumber ?? '',
    );
    _driverController = TextEditingController(
      text: widget.tricycle?.driverName ?? '',
    );
    _routeController = TextEditingController(
      text: widget.tricycle?.route ?? '',
    );
    _status = widget.tricycle?.status ?? 'Active';
  }

  @override
  void dispose() {
    _plateController.dispose();
    _driverController.dispose();
    _routeController.dispose();
    super.dispose();
  }

  void _saveTricycle() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(
      context,
      Tricycle(
        plateNumber: _plateController.text.trim(),
        driverName: _driverController.text.trim(),
        route: _routeController.text.trim(),
        status: _status,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.tricycle != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit tricycle' : 'Add tricycle')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              key: const ValueKey('plate-number'),
              controller: _plateController,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                labelText: 'Plate number',
                hintText: 'Example: TRI-1234',
                border: OutlineInputBorder(),
              ),
              validator: _requiredField,
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const ValueKey('driver-name'),
              controller: _driverController,
              decoration: const InputDecoration(
                labelText: 'Driver name',
                border: OutlineInputBorder(),
              ),
              validator: _requiredField,
            ),
            const SizedBox(height: 16),
            TextFormField(
              key: const ValueKey('tricycle-route'),
              controller: _routeController,
              decoration: const InputDecoration(
                labelText: 'Route',
                hintText: 'Example: Poblacion - Market',
                border: OutlineInputBorder(),
              ),
              validator: _requiredField,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _status,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Active', child: Text('Active')),
                DropdownMenuItem(value: 'On Break', child: Text('On Break')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => _status = value);
              },
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              key: const ValueKey('save-tricycle'),
              onPressed: _saveTricycle,
              icon: const Icon(Icons.save_outlined),
              label: Text(isEditing ? 'Save changes' : 'Add tricycle'),
            ),
          ],
        ),
      ),
    );
  }

  String? _requiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required.';
    }
    return null;
  }
}
