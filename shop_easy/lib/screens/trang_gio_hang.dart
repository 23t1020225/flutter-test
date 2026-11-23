import 'package:flutter/material.dart';
import 'package:shop_easy/API/api.dart';

class AddGioHang extends StatefulWidget {
  const AddGioHang({super.key, this.productId});
  final int? productId;

  @override
  State<AddGioHang> createState() {
    return _AddGioHangState();
  }
}

class _AddGioHangState extends State<AddGioHang> {
  static final List<Map<String, dynamic>> products = [];
  void initState() {
    super.initState();
    if (widget.productId != null) _addProduct();
  }
  
  Future<void> _addProduct() async {
    try {
      final p = await getSPById(widget.productId!);
      if (!mounted) return;

      setState(() {
        final index = products.indexWhere((item) => item['id'] == p.id);

        if (index >= 0) {
          products[index]['quantity']++;
        } else {
          products.add({
            'id': p.id,
            'name': p.title,
            'price': (p.price * 25000).round(),
            'quantity': 1,
            'imageUrl': p.thumbnail,
          });
        }
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Không tải được sản phẩm.')));
    }
  }

  int get subtotal {
    int total = 0;
    for (final product in products) {
      final int price = product['price'] as int;
      final int quantity = product['quantity'] as int;
      final int productTotal = price * quantity;
      total = total + productTotal;
    }
    return total;
  }

  int get shipping {
    if (products.isEmpty || subtotal >= 500000) {
      return 0;
    }
    return 30000;
  }

 String money(num value) {
  final amount = value.round().toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+$)'),
    (match) => '${match[1]}.',
  );
  return '$amount đ';
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Giỏ hàng')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              block2(),
              if (products.isNotEmpty) ...[
                const SizedBox(height: 8),
                block3(),
                const SizedBox(height: 8),
                block4(),
              ],
            ],
          ),
        ),
      ),
      bottomNavigationBar: block5(),
    );
  }

  // Block 2: Danh sách sản phẩm hoặc thông báo giỏ trống
  Widget block2() {
    if (products.isEmpty) {
      return Expanded(child: emptyCart());
    }

    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Dismissible(
            key: ValueKey(product['id']),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              removeProduct(product);
            },
            child: productCard(product),
          );
        },
      ),
    );
  }

  // Thẻ sản phẩm được gọi cho từng dòng trong block2()
  Widget productCard(Map<String, dynamic> product) {
    final int quantity = product['quantity'] as int;
    final VoidCallback? onDecrease;
    if (quantity > 1) {
      onDecrease = () {
        setState(() {
          final int currentQuantity = product['quantity'] as int;
          product['quantity'] = currentQuantity - 1;
        });
      };
    } else {
      onDecrease = null;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Image.network(
              product['imageUrl'] as String,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  width: 64,
                  height: 64,
                  child: Icon(Icons.image_outlined),
                );
              },
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'] as String,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(money(product['price'] as num)),
                  Row(
                    children: [
                      IconButton(
                        tooltip: 'Giảm số lượng',
                        visualDensity: VisualDensity.compact,
                        onPressed: onDecrease,
                        icon: const Icon(Icons.remove),
                      ),
                      Text(quantity.toString()),
                      IconButton(
                        tooltip: 'Tăng số lượng',
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          setState(() {
                            final int currentQuantity =
                                product['quantity'] as int;
                            product['quantity'] = currentQuantity + 1;
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                      const Spacer(),
                      IconButton(
                        tooltip: 'Xóa sản phẩm',
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          removeProduct(product);
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Block 3: Tạm tính và phí vận chuyển
  Widget block3() {
    final int shippingFee = shipping;
    final String shippingText;
    if (shippingFee == 0) {
      shippingText = 'Miễn phí';
    } else {
      shippingText = money(shippingFee);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(),
        Row(
          children: [
            const Text('Tạm tính'),
            const Spacer(),
            Text(money(subtotal)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('Phí vận chuyển'),
            const Spacer(),
            Text(shippingText),
          ],
        ),
        const SizedBox(height: 8),
        const Text('Miễn phí vận chuyển cho đơn từ 500.000 đ'),
      ],
    );
  }

  // Block 4: Tổng số tiền cần thanh toán
  Widget block4() {
    final int total = subtotal + shipping;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(),
        Row(
          children: [
            const Text(
              'Tổng cộng',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              money(total),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  // Block 5: Nút thanh toán ở cuối màn hình
  Widget block5() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bạn đã chọn thanh toán')),
              );
            },
            child: const Text('Thanh toán'),
          ),
        ),
      ),
    );
  }

  // Nội dung block2() hiển thị khi giỏ hàng trống
  Widget emptyCart() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.shopping_cart_outlined,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          const Text('Giỏ hàng của bạn đang trống'),
          const SizedBox(height: 12),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Tiếp tục mua sắm'),
          ),
        ],
      ),
    );
  }

  // Xóa bằng nút hoặc vuốt đều có thể hoàn tác
  void removeProduct(Map<String, dynamic> product) {
    final index = products.indexOf(product);
    if (index == -1) {
      return;
    }
    setState(() {
      products.removeAt(index);
    });
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 6),
        content: Text('Đã xóa ${product['name']}'),
        action: SnackBarAction(
          label: 'Hoàn tác',
          onPressed: () {
            if (!mounted) {
              return;
            }
            setState(() {
              int insertIndex = index;
              if (insertIndex > products.length) {
                insertIndex = products.length;
              }
              products.insert(insertIndex, product);
            });
          },
        ),
      ),
    );
  }
}
