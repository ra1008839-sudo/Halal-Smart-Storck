import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:halal_smart_stock/main.dart';

void main() {
  testWidgets('App initializes correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HalalSmartStockApp());

    // Verify that login screen is shown initially
    expect(find.text('Welcome Back'), findsOneWidget);
  });
}
