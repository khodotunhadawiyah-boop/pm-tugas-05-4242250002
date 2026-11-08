import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pm_tugas_05/main.dart';

void main() {
  testWidgets('Ikon favorit berubah setelah ditekan', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: TombolFavorit(nama: 'Soto Medan')),
      ),
    );

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);

    await tester.tap(find.byType(IconButton));
    await tester.pump();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
  });
}