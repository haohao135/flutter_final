

import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/CreateTopicScreen/create_topic.dart';
import 'package:fluttertoast/fluttertoast.dart';


class TopicList extends StatefulWidget {
  const TopicList({super.key});

  @override
  State<TopicList> createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  bool hasTopic = false;

  @override
  Widget build(BuildContext context) {
    return hasTopic ? const Text("hi") : noTopic();
  }

  Widget noTopic(){
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
            onPressed: () async{
              var rs = await Navigator.push(context, MaterialPageRoute(builder: (context)=> const CreateTopic()));
              if(rs!=null){
                Fluttertoast.showToast(
                  backgroundColor: Colors.green[600],
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  msg: "Thêm chủ đề thành công");
              }
            }, child: const Text("Tạo chủ đề", style: TextStyle(color: Colors.white),)),
        )
      ],
    );
  }
}