import 'package:dio/dio.dart';
import 'package:shop_easy/data/Users.dart';
import 'package:shop_easy/data/product.dart';

// Cấu hình dùng chung cho các hàm API.
final Dio _dio = Dio(
  BaseOptions(
    baseUrl: 'https://dummyjson.com',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ),
);

Future<void> guidata1(String username, String password) async {
  final response = await _dio.post(
    '/auth/login',
    data: {'username': username, 'password': password},
  );
  if (response.statusCode == 200) {
    final accessToken = response.data['accessToken'] as String;
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    return;
  }
  throw Exception('Đăng nhập thất bại.');
}

Future<List<Product>> getSP() async {
  final response = await _dio.get('/products');

  if (response.statusCode == 200) {
    final List products = response.data['products'];
    return products.map((json) => Product.fromJson(json)).toList();
  }
  throw Exception('Không tải được danh sách sản phẩm.');
}

Future<Product> getSPById(int id) async {
  final response = await _dio.get('/products/$id');
  if (response.statusCode == 200) {
    return Product.fromJson(response.data);
  }
  throw Exception('Không tải được chi tiết sản phẩm.');
}

Future<Users> getProfile() async {
  final response = await _dio.get('/auth/me');

  if (response.statusCode == 200) {
    return Users.fromJson(response.data);
  }

  throw Exception('Không tải được hồ sơ.');
}
