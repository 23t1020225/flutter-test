import 'package:flutter/material.dart';
import 'package:shop_easy/API/api.dart';
import 'package:shop_easy/data/product.dart';
import 'package:shop_easy/exercises/trang_cai_dat.dart';
import 'package:shop_easy/exercises/trang_ho_so.dart';
import 'package:shop_easy/screens/trang_gio_hang.dart';
import 'package:shop_easy/widgets/the_san_pham.dart';
import 'package:shop_easy/screens/trang_dasboard.dart';
import 'package:shop_easy/screens/trang_chi_tiet_san_pham.dart';

class DanhSachPage extends StatefulWidget {
  const DanhSachPage({super.key});

  @override
  State<DanhSachPage> createState() {
    return _DanhSachPageState();
  }
}

class _DanhSachPageState extends State<DanhSachPage> {
  String _searchText = '';
  String _selectedCategory = 'Tất cả';

  late Future<List<Product>> _futureProducts;
  final List<String> categories = [
    'Tất cả',
    'beauty',
    'fragrances',
    'furniture',
    'groceries',
  ];
  @override
  void initState() {
    super.initState();
    // Gọi API 1 lần duy nhất khi màn hình khởi tạo
    _futureProducts = getSP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: block1(context),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            block2(),
            const SizedBox(height: 8),
            block3(),
            const SizedBox(height: 8),
            block4(),
          ],
        ),
      ),
      bottomNavigationBar: block5(),
    );
  }

  // Block 1: Tiêu đề, nút dashboard và giỏ hàng
  AppBar block1(BuildContext context) {
    return AppBar(
      title: const Text('ShopEasy'),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: Badge(
            label: const Text('2'),
            child: IconButton(
              tooltip: 'Giỏ hàng',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddGioHang()),
                );
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
        ),
        IconButton(
          tooltip: 'Tài khoản',
          icon: const Icon(Icons.person_outline),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Myin4()),
            );
          },
        ),
      ],
    );
  }

  // Block 2: Ô tìm kiếm
  Widget block2() {
    return TextField(
      onChanged: (value) {
        setState(() {
          _searchText = value.toLowerCase();
        });
      },
      decoration: InputDecoration(
        hintText: 'Tìm kiếm sản phẩm...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }

  // Block 3: Danh mục cuộn ngang
  Widget block3() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(category),
              selected: _selectedCategory == category,
              selectedColor: Colors.blue,
              labelStyle: TextStyle(
                color: _selectedCategory == category ? Colors.white : null,
              ),
              onSelected: (_) {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  // Block 4: Lưới sản phẩm, lọc theo danh mục và từ khóa
  Widget block4() {
    return Expanded(
      child: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _futureProducts = getSP();
                  });
                },
                child: const Text('Tải thất bại. Nhấn để thử lại'),
              ),
            );
          }

          final products = snapshot.data ?? [];
          final filteredProducts = products.where((product) {
            final matchesCategory =
                _selectedCategory == 'Tất cả' ||
                product.category == _selectedCategory;
            final matchesSearch = product.title.toLowerCase().contains(
              _searchText,
            );
            return matchesCategory && matchesSearch;
          }).toList();
          if (filteredProducts.isEmpty) {
            return const Center(child: Text('Không có sản phẩm phù hợp.'));
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];

              return productCard(context, {
                'id': product.id,
                'name': product.title,
                'description': product.description,
                'category': product.category,
                'imageUrl': product.thumbnail,
                'icon': Icons.image_outlined,
                'images': product.images,
                'price':
                    '${(product.price * 25000).round().toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (match) => '${match[1]}.')} đ',
                'oldPrice':
                    product.discountPercentage > 0 &&
                        product.discountPercentage < 100
                    ? '${(product.price * 25000 / (1 - product.discountPercentage / 100)).round().toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (match) => '${match[1]}.')} đ'
                    : '',
                'discount': product.discountPercentage.round(),
                'rating': product.rating,
              });
            },
          );
        },
      ),
    );
  }

  // Thẻ sản phẩm dùng chung
  Widget productCard(BuildContext context, Map<String, dynamic> product) {
    return ProductCard(
      product: product,
      onTap: () async {
        try {
          final getid = await getSPById(product['id'] as int);
          if (!context.mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChiTietSP(product: product),
            ),
          );
        } catch (e) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lỗi khi lấy dữ liệu sản phẩm.')),
          );
        }
      },
    );
  }

  // Block 5: Thanh điều hướng dưới
  Widget block5() {
    return NavigationBar(
      indicatorColor: Colors.transparent,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          label: 'Trang chủ',
        ),
        NavigationDestination(
          icon: IconButton(
            tooltip: 'Quản lý dashboard',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DashboardPage()),
              );
            },
            icon: const Icon(Icons.dashboard_outlined),
          ),
          label: 'quản lý',
        ),
        NavigationDestination(
          icon: IconButton(
            tooltip: 'Danh sách sản phẩm',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddGioHang()),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          label: 'Giỏ hàng',
        ),
        NavigationDestination(
          icon: IconButton(
            tooltip: 'Cài đặt',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CaiDatScreen()),
              );
            },
            icon: const Icon(Icons.settings_outlined),
          ),
          label: 'Cài đặt',
        ),
      ],
    );
  }
}
