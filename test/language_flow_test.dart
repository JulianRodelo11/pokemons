import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemons/presentation/screens/home/pages/perfil_page.dart';
import 'test_utils.dart';

void main() {
  testWidgets('Language selection flow: changing to English updates UI',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      createTestWidget(
        child: const PerfilPage(),
      ),
    );

    // Initial language (Spanish)
    expect(find.text('Cambiar idioma'), findsOneWidget);
    expect(find.text('Español'), findsOneWidget);
    expect(find.text('Inglés'), findsOneWidget);

    // Tap English
    await tester.tap(find.text('Inglés'));
    await tester.pumpAndSettle();

    // Verify UI updated to English
    expect(find.text('Change language'), findsOneWidget);
    expect(find.text('Spanish'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    
    // Check that Spanish is also an option but in English
    expect(find.text('Cambiar idioma'), findsNothing);
  });
}
