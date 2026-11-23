import 'package:flutter/material.dart';
import 'package:shop_easy/screens/trang_dang_nhap.dart';

class MyPage extends StatelessWidget {
  const MyPage ({super.key});
String getUrlImage() {
  return "https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?auto=format&fit=crop&w=1170&q=80";
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    leading: const Icon(Icons.travel_explore_sharp,size: 30),
    title: const Text('Vancouver'),
    actions: [
      Icon(Icons.search),
      Icon(Icons.more_vert),
      IconButton(
        tooltip: 'Đăng nhập',
        icon: const Icon(Icons.login),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        },
      ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            block1(),
            block2(),
            block3(),
            block4(),
            block5(),
          ],
        ),
      ),
    );
  }
  Widget block1() {
    return Image.network(getUrlImage(),height: 300,);
}
Widget block2() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
      // Bổ sung cột chữ ở đây
     const Text(
      "Vancouver xinh đẹp - Trần Văn Huy", 
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
     const Spacer(),
      // Giữ nguyên phần cũ của bạn
      const Icon(
        Icons.star,
        color: Color.fromARGB(255, 235, 10, 10),
      ),
      const Text("41"),
        ],
      ),
    );
}
Widget block3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:[
        icontText(Icons.call,"Call"),
        icontText(Icons.near_me,"Route"), 
        icontText(Icons.share,"Share"),

      ],
    );
}
Widget block4() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        "Vancouver, thành phố lớn thứ ba của Canada, nổi tiếng với cảnh quan tuyệt đẹp, núi non hùng vĩ và bờ biển tuyệt vời. Thành phố này là điểm đến lý tưởng cho những ai yêu thích thiên nhiên và các hoạt động ngoài trời.",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
  Widget block5() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
    
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
              labelText: 'Add a review',
            ),
          ),
      
        const SizedBox(height: 8), // Tạo khoảng hở nhỏ giữa 2 ô nhập liệu cho đẹp mắt
          TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
              labelText: 'tên tài khoản',
            ),
          ),
      ],
    ),
  );
}

  Widget textField({required InputDecoration decoration}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: decoration,
      ),
    );
  }
Widget icontText(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Thu gọn Column vừa bằng nội dung
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.blue),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}