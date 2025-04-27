// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:performance_flutter/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Performance Tests', () {
    const int testRuns = 100;
    final List<Map<String, int>> allResults = [];

    for (int run = 0; run < testRuns; run++) {
      testWidgets('Run $run: Measure app launch and data load time', (WidgetTester tester) async {
        // Wait briefly to ensure clean state between runs
        await Future.delayed(const Duration(seconds: 1));

        // Record the start time
        final stopwatch = Stopwatch()..start();

        // Start the app
        await tester.pumpWidget(MyApp());

        // Time until "this is a test" text appears
        bool textFound = false;
        while (!textFound && stopwatch.elapsedMilliseconds < 10000) {
          await tester.pump(const Duration(milliseconds: 100));
          textFound = find.text('this is a test').evaluate().isNotEmpty;
        }

        final time = stopwatch.elapsedMilliseconds;
        print('Text "this is a test" appeared in: $time ms');

        // Verify that the text was found
        expect(textFound, true, reason: 'Text "this is a test" should appear');

        // Record results for this run
        allResults.add({'time': time});
      });
    }

    tearDownAll(() {
      // Calculate statistics
      final times = allResults.map((r) => r['time']!).toList();

      // Average
      final avg = times.reduce((a, b) => a + b) / testRuns;
      final avgSeconds = avg / 1000;

      // Print results
      print('\n===== PERFORMANCE RESULTS ($testRuns runs) =====');
      print('Average time: ${avg.toStringAsFixed(2)} ms / ${avgSeconds.toStringAsFixed(2)} seconds');
    });
  });
}
