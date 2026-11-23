import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool showAll = false;

  // Dữ liệu mẫu; có thể thay bằng dữ liệu đơn hàng thực tế sau này.
  final List<Map<String, dynamic>> orders = [
    {
      'id': 'DH006',
      'customer': 'Trần Văn Huy',
      'date': '02/11/2026',
      'total': 8990000,
      'status': 'Chờ xử lý',
    },
    {
      'id': 'DH005',
      'customer': 'Nguyễn Thị Mai',
      'date': '02/11/2026',
      'total': 1290000,
      'status': 'Đang giao',
    },
    {
      'id': 'DH004',
      'customer': 'Lê Minh Anh',
      'date': '01/11/2026',
      'total': 19990000,
      'status': 'Hoàn thành',
    },
    {
      'id': 'DH003',
      'customer': 'Phạm Văn Nam',
      'date': '01/11/2026',
      'total': 250000,
      'status': 'Đã hủy',
    },
    {
      'id': 'DH002',
      'customer': 'Nguyễn Thị Mai',
      'date': '31/10/2026',
      'total': 1290000,
      'status': 'Hoàn thành',
    },
    {
      'id': 'DH001',
      'customer': 'Hoàng Thanh Hà',
      'date': '30/10/2026',
      'total': 500000,
      'status': 'Chờ xử lý',
    },
  ];

  String money(int value) {
    return '${value.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+$)'), (match) => '${match[1]}.')} đ';
  }

Color statusColor(String status) {
  if (status == 'Chờ xử lý') return Colors.orange.shade800;
  if (status == 'Đang giao') return Colors.blue.shade700;
  if (status == 'Hoàn thành') return Colors.green.shade700;
  
  return Colors.red.shade700; 
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: block1(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.constrainWidth(
            MediaQuery.sizeOf(context).width,
          );
          final columnCount = width > 600 ? 4 : 2;

          return SafeArea(
            child: CustomScrollView(
              slivers: [
                block2(columnCount),
                block3(),
                block4(),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            ),
          );
        },
      ),
    );
  }

  // Block 1: Thanh tiêu đề
  AppBar block1() {
    return AppBar(title: const Text('Tổng quan quản lý'));
  }

  // Block 2: Lưới bốn ô thống kê
  Widget block2(int columnCount) {
    final revenue = orders
        .where((order) => order['status'] == 'Hoàn thành')
        .fold<int>(0, (total, order) => total + (order['total'] as int));
    final customers = orders.map((order) => order['customer']).toSet().length;
    final pending = orders
        .where((order) => order['status'] == 'Chờ xử lý')
        .length;

    final statistics = [
      {
        'label': 'Tổng đơn hàng',
        'value': '${orders.length}',
        'icon': Icons.receipt_long_outlined,
      },
      {
        'label': 'Doanh thu hoàn thành',
        'value': money(revenue),
        'icon': Icons.payments_outlined,
      },
      {
        'label': 'Khách hàng',
        'value': '$customers',
        'icon': Icons.people_outline,
      },
      {
        'label': 'Đơn chờ xử lý',
        'value': '$pending',
        'icon': Icons.hourglass_empty,
      },
    ];

    final cards = statistics.map((statistic) {
      return Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blue.shade50,
                foregroundColor: Colors.blue.shade800,
                child: Icon(statistic['icon'] as IconData, size: 20),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    statistic['value'] as String,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                statistic['label'] as String,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
    }).toList();

    return SliverToBoxAdapter(
      //danh sách dạng lưới với số lượng cột cố định
      child: GridView.count(
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        crossAxisCount: columnCount,
        mainAxisExtent: 160,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        children: cards,
      ),
    );
  }

  // Block 3: Tiêu đề danh sách và nút xem tất cả
  Widget block3() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'Đơn hàng gần đây',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () => setState(() => showAll = !showAll),
              child: Text(showAll ? 'Thu gọn' : 'Xem tất cả'),
            ),
          ],
        ),
      ),
    );
  }

  // Block 4: Danh sách cuộn cùng toàn bộ màn hình
  Widget block4() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => block5(orders[index]),
          childCount: showAll ? orders.length : orders.take(4).length,
        ),
      ),
    );
  }

  // Block 5: Một dòng đơn hàng và nhãn trạng thái có màu riêng
  Widget block5(Map<String, dynamic> order) {
    final color = statusColor(order['status'] as String);
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.receipt_long_outlined, color: Colors.blue),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#${order['id']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    order['customer'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    order['date'] as String,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    order['status'] as String,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  money(order['total'] as int),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
