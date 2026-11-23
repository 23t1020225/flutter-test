import 'package:flutter/material.dart';

class MyCounter extends StatefulWidget {
  const  MyCounter({super.key});

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int _Counter=0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Counter và thông tin sinhh viên"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Text("bo dem hien tại là: $_Counter"),
            ),
            ElevatedButton(
              onPressed: (){
                setState(() {
                  _Counter++;
                });
                print("Bộ đếm hiện tại là: $_Counter");
              },
              child: Text("Tăng bộ đếm"),
            ),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            child:ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?auto=format&fit=crop&w=1170&q=80"),
              ),
              title: Text("Nguyen Van A"),
              subtitle: Text("0392046613"),
              trailing: IconButton(
                icon: Icon(Icons.phone),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                  content: Text("Đang gọi cho bạn của bạn"),
                  duration: Duration(seconds: 5),
                 
                    ),
                    
                  );
                },
                
              )
            )
          ),
           const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              labelText: "Nhập thông tin",
             border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
            ),
          ),
          ],
          ),
      )
      );
  }
}