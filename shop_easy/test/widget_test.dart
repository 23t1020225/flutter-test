// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_easy/screens/trang_dang_nhap.dart';
import 'package:shop_easy/screens/trang_danh_sach_san_pham.dart';

import 'package:shop_easy/main.dart';

void main() {
  testWidgets('Giữ màn hình đăng nhập khi tài khoản và mật khẩu trống', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));

    await tester.tap(find.widgetWithText(ElevatedButton, 'Đăng nhập'));
    await tester.pumpAndSettle();

    expect(find.text('Vui lòng nhập tài khoản và mật khẩu.'), findsOneWidget);
    expect(find.byType(DanhSachPage), findsNothing);
    expect(find.byType(LoginPage), findsOneWidget);
  });
}
