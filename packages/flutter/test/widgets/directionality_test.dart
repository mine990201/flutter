// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

void main() {
  testWidgets('Directionality', (WidgetTester tester) async {
    final List<TextDirection> log = <TextDirection>[];
    final Widget inner = new Builder(
      builder: (BuildContext context) {
        log.add(Directionality.of(context));
        return const Placeholder();
      }
    );
    await tester.pumpWidget(
      new Directionality(
        textDirection: TextDirection.ltr,
        child: inner,
      ),
    );
    expect(log, <TextDirection>[TextDirection.ltr]);
    await tester.pumpWidget(
      new Directionality(
        textDirection: TextDirection.ltr,
        child: inner,
      ),
    );
    expect(log, <TextDirection>[TextDirection.ltr]);
    await tester.pumpWidget(
      new Directionality(
        textDirection: TextDirection.rtl,
        child: inner,
      ),
    );
    expect(log, <TextDirection>[TextDirection.ltr, TextDirection.rtl]);
    await tester.pumpWidget(
      new Directionality(
        textDirection: TextDirection.rtl,
        child: inner,
      ),
    );
    expect(log, <TextDirection>[TextDirection.ltr, TextDirection.rtl]);
    await tester.pumpWidget(
      new Directionality(
        textDirection: TextDirection.ltr,
        child: inner,
      ),
    );
    expect(log, <TextDirection>[TextDirection.ltr, TextDirection.rtl, TextDirection.ltr]);
  });

  testWidgets('Directionality default', (WidgetTester tester) async {
    bool good = false;
    await tester.pumpWidget(new Builder(
      builder: (BuildContext context) {
        expect(Directionality.of(context), isNull);
        good = true;
        return const Placeholder();
      },
    ));
    expect(good, isTrue);
  });

  testWidgets('Directionality can\'t be null', (WidgetTester tester) async {
    expect(() {
      final TextDirection textDirection = null; // we don't want this instance to be const because otherwise it would throw at compile time.
      new Directionality(textDirection: textDirection, child: const Placeholder());
    }, throwsAssertionError);
  });
}
