import 'package:flutter/material.dart';

const List<String> productCategories = [
  'Tất cả',
  'Điện thoại',
  'Laptop',
  'Phụ kiện',
];

const List<Map<String, dynamic>> productData = [
  {
    'name': 'Điện thoại',
    'category': 'Điện thoại',
    'price': '8.990.000 đ',
    'oldPrice': '9.990.000 đ',
    'description': 'Điện thoại thông minh, thiết kế hiện đại.',
    'discount': 10,
    'rating': 4.8,
    'reviews': 120,
    'imageUrl':
        'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500',
    'icon': Icons.phone_android,
  },
  {
    'name': 'Laptop',
    'category': 'Laptop',
    'price': '19.990.000 đ',
    'oldPrice': '22.990.000 đ',
    'description': 'Laptop mỏng nhẹ, phù hợp học tập và công việc.',
    'discount': 13,
    'rating': 4.7,
    'reviews': 86,
    'imageUrl':
        'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500',
    'icon': Icons.laptop,
  },
  {
    'name': 'Tai nghe',
    'category': 'Phụ kiện',
    'price': '1.290.000 đ',
    'oldPrice': '1.590.000 đ',
    'description': 'Tai nghe không dây với thiết kế gọn nhẹ.',
    'discount': 19,
    'rating': 4.9,
    'reviews': 210,
    'imageUrl':
        'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
    'icon': Icons.headphones,
  },
  {
    'name': 'Ốp lưng',
    'category': 'Phụ kiện',
    'price': '250.000 đ',
    'oldPrice': '350.000 đ',
    'description': 'Ốp lưng bảo vệ điện thoại, kiểu dáng gọn nhẹ.',
    'discount': 29,
    'rating': 4.6,
    'reviews': 45,
    'imageUrl':
        'https://images.unsplash.com/photo-1601593346740-925612772716?w=500',
    'icon': Icons.phone_iphone,
  },
];
