import 'package:flutter/material.dart';
import 'package:shop_easy/API/api.dart';
import 'package:shop_easy/data/Users.dart';

class Myin4 extends StatefulWidget {
  const Myin4({super.key});

  @override
  State<Myin4> createState() => _Myin4State();
}

class _Myin4State extends State<Myin4> {
  late Future<Users> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text('Thẻ hồ sơ cá nhân'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                block1(),
                const SizedBox(height: 48),
                block2(),
                const SizedBox(height: 24),
                block3(),
                const SizedBox(height: 16),
                const Divider(height: 1),
                block4(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Ảnh bìa và ảnh đại diện từ API
  Widget block1() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 120,
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),
        Positioned(
          bottom: -40,
          child: FutureBuilder<Users>(
            future: _futureUser,
            builder: (context, snapshot) {
              return CircleAvatar(
                radius: 40,
                backgroundImage: snapshot.hasData
                    ? NetworkImage(snapshot.data!.image)
                    : null,
                child: snapshot.hasData
                    ? null
                    : const Icon(Icons.person, size: 40, color: Colors.white),
              );
            },
          ),
        ),
      ],
    );
  }

  // Họ tên và email từ API
  Widget block2() {
    return FutureBuilder<Users>(
      future: _futureUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return TextButton(
            onPressed: () {
              setState(() => _futureUser = getProfile());
            },
            child: const Text('Không tải được hồ sơ. Nhấn để thử lại.'),
          );
        }

        final user = snapshot.data!;
        return Column(
          children: [
            Text(
              '${user.firstName} ${user.lastName}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Tuổi: ${user.age.toString()}',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            Text(
              'Giới tính: ${user.gender}',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            Text(
              'Ngày sinh: ${user.birthDate}',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            Text(
              'Email: ${user.email}',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        );
      },
    );
  }

  // Yêu cầu 4: Ba cột số liệu chia đều chiều ngang
  Widget block3() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          statColumn('120', 'Bài viết'),
          statColumn('2.5K', 'Người theo dõi'),
          statColumn('150', 'Đang theo dõi'),
        ],
      ),
    );
  }

  // Yêu cầu 5: Hai nút ở đáy thẻ theo tỉ lệ 3:2
  Widget block4() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            flex: 3, // Tỉ lệ 3
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Theo dõi'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2, // Tỉ lệ 2
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Nhắn tin'),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm tái sử dụng cho block3 để code gọn hơn
  Widget statColumn(String number, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
