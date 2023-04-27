import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:progress_manager/progress_manager.dart';

void main() {
  ///Create widget test
  testWidgets('ProgressManager test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProgressManager(
      child: SizedBox.shrink(),
    ));

  });
}
