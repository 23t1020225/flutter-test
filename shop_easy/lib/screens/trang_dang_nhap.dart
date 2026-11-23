import 'package:flutter/material.dart';
import 'package:shop_easy/API/api.dart';
import 'package:shop_easy/screens/trang_danh_sach_san_pham.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  block1(), // Block 1: Biểu tượng và Tiêu đề
                  const SizedBox(height: 24),
                  block2(), // Block 2: Các ô nhập tài khoản và mật khẩu
                  const SizedBox(height: 24),
                  block3(context), // Block 3: Nút bấm đăng nhập
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Block 1: Tiêu đề và Icon
  Widget block1() {
    return const Column(
      children: [
        Icon(Icons.lock_outline, size: 60, color: Colors.blue),
        SizedBox(height: 12),
        Text(
          'ĐĂNG NHẬP HỆ THỐNG',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  // Block 2: Ô nhập liệu (TextField) tài khoản & mật khẩu
  Widget block2() {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            setState(() {
              _username = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Tài khoản',
            prefixIcon: const Icon(Icons.person),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          obscureText: true,
          onChanged: (value) {
            setState(() {
              _password = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Mật khẩu',
            prefixIcon: const Icon(Icons.lock),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  // Block 3: Nút bấm đăng nhập
  Widget block3(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          // Tạo khoảng đệm 14 ở phía trên và phía dưới nội dung nút.
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {
          try {
            await guidata1(_username.trim(), _password.trim());
          } catch (_) {
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đăng nhập thất bại.')),
            );
            return;
          }

          if (!context.mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DanhSachPage()),
          );
        },
        child: const Text(
          'Đăng nhập',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
