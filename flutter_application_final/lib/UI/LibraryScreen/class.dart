import 'package:flutter/material.dart';

class ClassList extends StatefulWidget {
  const ClassList({super.key});

  @override
  State<ClassList> createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.network("https://cdn.thoitiet247.edu.vn/wp-content/uploads/2024/04/hinh-anh-xin-loi-1.jpg"),
        const SizedBox(height: 30,),
        const Text("Chưa phát triển", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        const SizedBox(height: 60,),
      ],
    );
  }
}