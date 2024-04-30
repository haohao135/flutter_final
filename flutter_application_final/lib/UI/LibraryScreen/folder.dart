import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/CreateFolderScreen/create_folder.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FolderList extends StatefulWidget {
  const FolderList({super.key});

  @override
  State<FolderList> createState() => _FolderListState();
}

class _FolderListState extends State<FolderList> {
  bool hasFolder = false;
  @override
  Widget build(BuildContext context) {
    return !hasFolder ? noFolder() : const Text("hi");
  }
  Widget noFolder(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Chưa có thư mục nào", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
        SizedBox(
          width: 150,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 163, 45, 206),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )
            ),
            onPressed: ()async{
              var rs = await Navigator.push(context, MaterialPageRoute(builder: (context)=> const CreateFolder()));
              if(rs!=null){
                Fluttertoast.showToast(
                  backgroundColor: Colors.green[600],
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  msg: "Thêm thư mục thành công");
              }
            }, child: const Text("Tạo thư mục", style: TextStyle(color: Colors.white),)),
        )
      ],
    );
  }
}