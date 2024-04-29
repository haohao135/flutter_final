import 'package:flutter/material.dart';

class TopicList extends StatelessWidget {
  const TopicList({super.key});

  @override
  Widget build(BuildContext context) {
    return noFolder();
  }
  Widget noFolder(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Chưa có chủ đề nào", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        SizedBox(
          width: 150,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 163, 45, 206),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )
            ),
            onPressed: (){}, child: const Text("Tạo chủ đề", style: TextStyle(color: Colors.white),)),
        )
      ],
    );
  }
}