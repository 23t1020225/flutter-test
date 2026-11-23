import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:shop_easy/screens/trang_dang_nhap.dart';

void main() {
  DevicePreview.enable();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE3F2FD),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Color(0xFFE3F2FD),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
