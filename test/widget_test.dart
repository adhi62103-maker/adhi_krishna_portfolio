import 'package:flutter_test/flutter_test.dart';
import 'package:adhi_krishna_portfolio/main.dart';
import 'package:adhi_krishna_portfolio/data/portfolio_data.dart';

void main() {
  testWidgets('Portfolio app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text(PortfolioData.name), findsOneWidget);
  });
}
