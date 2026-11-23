import 'package:flutter/material.dart';
import 'package:shop_easy/screens/trang_gio_hang.dart';

class ChiTietSP extends StatefulWidget {
  const ChiTietSP({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  State<ChiTietSP> createState() => _ChiTietSPState();
}

class _ChiTietSPState extends State<ChiTietSP> {
  int _anhHienTai = 0;
  bool _xemThem = false;
  late final List<String> _images;
  Map<String, dynamic> get product {
    return widget.product;
  }
  @override
  void initState() {
    super.initState();
    _images = List<String>.from(product['images'] ?? []);
    if (_images.isEmpty) {
      _images.add(product['imageUrl'] as String);
    }
  }

  // Hàm build() và các block hiện tại đặt tiếp bên dưới.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [block1(context), block2(), block3(), block4()],
                ),
              ),
            ),
            block5(context),
          ],
        ),
      ),
    );
  }

  // Block 1: Ảnh sản phẩm, nút quay lại và giỏ hàng
  Widget block1(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            child: PageView.builder(
              itemCount: _images.length,
              onPageChanged: (index) {
                setState(() => _anhHienTai = index);
              },
              itemBuilder: (context, index) {
                return Image.network(
                  _images[index],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.image_outlined, size: 80),
                    );
                  },
                );
              },
            ),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                tooltip: 'Quay lại',
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, size: 20),
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                tooltip: 'Yêu thích',
                onPressed: () {},
                icon: const Icon(Icons.favorite_border, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Block 2: Dấu chấm ảnh
  Widget block2() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_images.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Icon(
              Icons.circle,
              size: 7,
              color: index == _anhHienTai ? Colors.blue : Colors.grey,
            ),
          );
        }),
      ),
    );
  }

  // Block 3: Đánh giá, giảm giá, tên và giá
  Widget block3() {
    final rating = (product['rating'] as num).toDouble();
    final discount = product['discount'] as int;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const Icon(Icons.star, color: Colors.amber, size: 18),
              const SizedBox(width: 6),
              Text(rating.toStringAsFixed(1)),
              const Spacer(),
              Text(
                '-' + discount.toString() + '%',
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            product['name'] as String,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            product['category'] as String,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                product['price'] as String,
                style: const TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  product['oldPrice'] as String,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Block 4: Mô tả sản phẩm
  Widget block4() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product['description'] as String? ?? '',
            maxLines: _xemThem ? null : 3,
            overflow: _xemThem ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
          TextButton(
            onPressed: () {
              setState(() => _xemThem = !_xemThem);
            },
            child: Text(_xemThem ? 'Thu gọn' : 'Xem thêm'),
          ),
        ],
      ),
    );
  }

  // Block 5: Hai nút cố định phía dưới
  Widget block5(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddGioHang(productId: product['id'] as int),
                    ),
                  );
                },
                child: const Text('Thêm vào giỏ'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Đã chọn mua ngay')),
                  );
                },
                child: const Text('Mua ngay'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
