import 'package:flutter/material.dart';
import 'package:shop_easy/screens/trang_gio_hang.dart';

class giohang extends StatelessWidget {
  const giohang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  block1(),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        block2(),
                        block3(),
                        block4(),
                        block5(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Ảnh, nhãn giảm giá và biểu tượng yêu thích
  Widget block1() {
    return SizedBox(
      height: 140,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: Image.network(
              'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '-25%',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
            ),
          ),
        ],
      ),
    );
  }

  // Tên sản phẩm
  Widget block2() {
    return const Text(
      'Tai nghe Bluetooth không dây',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  // Đánh giá
  Widget block3() {
    return const Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: 16),
        Icon(Icons.star, color: Colors.amber, size: 16),
        Icon(Icons.star, color: Colors.amber, size: 16),
        Icon(Icons.star, color: Colors.amber, size: 16),
        Icon(Icons.star, color: Colors.amber, size: 16),
        Text(' 4.8 (120)'),
      ],
    );
  }

  // Giá hiện tại và giá cũ
  Widget block4() {
    return const Row(
      children: [
        Text(
          '219.000 đ',
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8),
        Text(
          '299.000 đ',
          style: TextStyle(
            color: Colors.grey,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ],
    );
  }

  // Nút thêm vào giỏ
  Widget block5(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddGioHang(),
            ),
          );
        },
        child: const Text('Thêm vào giỏ'),
      ),
    );
  }
}
