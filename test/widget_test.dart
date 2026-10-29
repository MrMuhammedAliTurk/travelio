import 'package:flutter_test/flutter_test.dart';
import 'package:travelio/main.dart';
import 'package:travelio/data/destination_data.dart';

void main() {
  testWidgets('Travelio keşfet ekranı açılır', (WidgetTester tester) async {
    await tester.pumpWidget(const TravelioApp());
    expect(find.text('Travelio'), findsOneWidget);
    expect(find.text('Rotaları keşfet'), findsOneWidget);
    expect(find.text('Keşfet'), findsOneWidget);
    expect(find.text('Rotanın kapsamı'), findsOneWidget);
    expect(destinations.length, greaterThanOrEqualTo(50));
    expect(destinations.any((destination) => destination.country == 'Türkiye'), isTrue);
    expect(destinations.any((destination) => destination.country != 'Türkiye'), isTrue);
  });
}
