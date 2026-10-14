import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finalcoriga/main.dart';

void main() {
  testWidgets('Shows the dashboard and bottom navigation', (tester) async {
    await tester.pumpWidget(const TrikeFlowApp());

    expect(find.text('Fleet overview'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Fleet'), findsOneWidget);
    expect(find.text('Weather'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });

  testWidgets('Fleet tab shows sample tricycles', (tester) async {
    await tester.pumpWidget(const TrikeFlowApp());
    await tester.tap(find.text('Fleet'));
    await tester.pumpAndSettle();

    expect(find.text('TRI-1024'), findsOneWidget);
    expect(find.text('TRI-2048'), findsOneWidget);
    expect(find.text('Fleet management'), findsOneWidget);
  });

  testWidgets('Can edit and delete a tricycle from Home', (tester) async {
    await tester.pumpWidget(const TrikeFlowApp());
    await tester.drag(
      find.byKey(const ValueKey('dashboard-list')),
      const Offset(0, -1000),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('actions-TRI-3072')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('driver-name')),
      'Pedro Updated',
    );
    await tester.ensureVisible(find.byKey(const ValueKey('save-tricycle')));
    await tester.tap(find.byKey(const ValueKey('save-tricycle')));
    await tester.pumpAndSettle();
    expect(find.text('Pedro Updated'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('actions-TRI-3072')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('confirm-delete-tricycle')));
    await tester.pumpAndSettle();
    expect(find.text('TRI-3072'), findsNothing);
  });

  testWidgets('Can add, edit, and delete a tricycle', (tester) async {
    await tester.pumpWidget(const TrikeFlowApp());
    await tester.tap(find.text('Fleet'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('add-tricycle')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('save-tricycle')));
    await tester.pumpAndSettle();
    expect(find.text('This field is required.'), findsNWidgets(3));

    await tester.enterText(
      find.byKey(const ValueKey('plate-number')),
      'TRI-9999',
    );
    await tester.enterText(
      find.byKey(const ValueKey('driver-name')),
      'Alex Rivera',
    );
    await tester.enterText(
      find.byKey(const ValueKey('tricycle-route')),
      'Town - Port',
    );
    expect(
      tester
          .widget<TextFormField>(find.byKey(const ValueKey('plate-number')))
          .controller!
          .text,
      'TRI-9999',
    );
    await tester.ensureVisible(find.byKey(const ValueKey('save-tricycle')));
    await tester.tap(find.byKey(const ValueKey('save-tricycle')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('save-tricycle')), findsNothing);
    await tester.drag(
      find.byKey(const ValueKey('fleet-list')),
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();
    expect(find.text('TRI-9999'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('actions-TRI-9999')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const ValueKey('driver-name')),
      'Alex Santos',
    );
    await tester.ensureVisible(find.byKey(const ValueKey('save-tricycle')));
    await tester.tap(find.text('Save changes'));
    await tester.pumpAndSettle();
    expect(find.text('Alex Santos'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('actions-TRI-9999')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('confirm-delete-tricycle')));
    await tester.pumpAndSettle();
    expect(find.text('TRI-9999'), findsNothing);
  });
}
