import 'package:flutter/material.dart';
import 'package:shop_easy/exercises/trang_ho_so.dart';
import 'package:shop_easy/exercises/trang_du_lich.dart';
import 'package:shop_easy/exercises/bo_dem.dart';
import 'package:shop_easy/screens/trang_dang_nhap.dart';

class CaiDatScreen extends StatefulWidget {
  const CaiDatScreen({super.key});

  @override
  State<CaiDatScreen> createState() => _CaiDatScreenState();
}

class _CaiDatScreenState extends State<CaiDatScreen> {
  // Khai báo trạng thái cho các công tắc (Switch)
  bool _nhanThongBao = true;
  bool _cheDoToi = false;
  bool _nhoDangNhap = true;

  @override
  Widget build(BuildContext context) {
    ThemeData giaoDien = Theme.of(context)
        .copyWith(scaffoldBackgroundColor: Colors.grey[200]);
    if (_cheDoToi==true) {
      giaoDien = ThemeData.dark(); // Chế độ tối: màu hồng
    }

    return Theme(
      data: giaoDien,
      child: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Màn hình Cài đặt'),
              centerTitle: true,
            ),
            body: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      block1(), // Nhóm 1: TÀI KHOẢN (SwitchListTile)
                      const Divider(height: 1),
                      block2(
                        context,
                      ), // Nhóm 2: ỨNG DỤNG (ListTile & BottomSheet)
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                block3(context), // Nút Đăng xuất viền đỏ ở cuối
              ],
            ),
          );
        },
      ),
    );
  }

  // Yêu cầu 1 & 2: Nhóm TÀI KHOẢN dùng SwitchListTile, thay đổi trạng thái ngay lập tức
  Widget block1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('TÀI KHOẢN'),
        SwitchListTile(
          title: const Text('Nhận thông báo'),
          value: _nhanThongBao,
          onChanged: (bool value) {
            setState(() {
              _nhanThongBao = value;
            });
          },
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
        SwitchListTile(
          title: const Text('Chế độ tối'),
          value: _cheDoToi,
          onChanged: (bool value) {
            setState(() {
              _cheDoToi = value;
            });
          },
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
        SwitchListTile(
          title: const Text('Nhớ đăng nhập'),
          value: _nhoDangNhap,
          onChanged: (bool value) {
            setState(() {
              _nhoDangNhap = value;
            });
          },
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
        // Mục mới thêm vào để link sang trang Thẻ hồ sơ cá nhân
        ListTile(
          leading: const Icon(Icons.person, color: Colors.blue),
          title: const Text('Thông tin của tôi'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            // Lệnh điều hướng sang trang Myin4
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Myin4()),
            );
          },
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
        ListTile(
          leading: const Icon(Icons.travel_explore, color: Colors.teal),
          title: const Text('Trang du lịch Vancouver'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyPage()),
            );
          },
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
        ListTile(
          leading: const Icon(Icons.add_circle_outline, color: Colors.indigo),
          title: const Text('Bộ đếm & Danh bạ (Counter)'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyCounter()),
            );
          },
        ),
      ],
    );
  }

  // Yêu cầu 3 & 4: Nhóm ỨNG DỤNG dùng ListTile có mũi tên, bấm vào hiện BottomSheet, không có kẻ ngang ở cuối nhóm
  Widget block2(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('ỨNG DỤNG'),
        ListTile(
          title: const Text('Ngôn ngữ'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showBottomSheet(context, 'Ngôn ngữ'),
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
        ListTile(
          title: const Text('Cỡ chữ'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showBottomSheet(context, 'Cỡ chữ'),
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
        ListTile(
          title: const Text('Về ứng dụng'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _showBottomSheet(context, 'Về ứng dụng'),
        ),
      ],
    );
  }

  // Yêu cầu 5: Nút Đăng xuất viền đỏ ở cuối, bấm vào hiện AlertDialog xác nhận
  Widget block3(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () => _showLogoutDialog(context),
        child: const Text(
          'Đăng xuất',
          style: TextStyle(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Hàm tái sử dụng cho tiêu đề nhóm (chữ in hoa nhỏ màu xám)
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  // Hàm hiển thị BottomSheet khi nhấn vào các mục ứng dụng
  void _showBottomSheet(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chọn giá trị cho $title',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text('Lựa chọn 1'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: const Text('Lựa chọn 2'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  // Hàm hiển thị AlertDialog khi bấm nút Đăng xuất
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn có chắc chắn muốn đăng xuất không?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Đồng ý', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
