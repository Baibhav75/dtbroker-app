import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dtbroker/main.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const DTBrokerApp());

    // Just verify app loads
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
