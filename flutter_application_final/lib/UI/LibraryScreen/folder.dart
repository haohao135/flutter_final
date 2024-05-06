import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/create_folder_firebase.dart';
import 'package:flutter_application_final/UI/CreateFolderScreen/create_folder.dart';
import 'package:flutter_application_final/model/folder.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FolderList extends StatefulWidget {
  const FolderList({Key? key}) : super(key: key);

  @override
  State<FolderList> createState() => _FolderListState();
}

class _FolderListState extends State<FolderList> {
  List<Folder>? folders;
  bool isLoading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (folders == null || folders!.isEmpty) {
        return noFolder();
      } else {
        return hasFolder();
      }
    }
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    List<Folder> folderData = await CreateFolderFireBase.getFolderData();
    setState(() {
      folders = folderData;
      isLoading = false;
    });
  }

  Widget hasFolder() {
    return ListView.separated(
        separatorBuilder: (context, index) => const Divider(
              indent: 20,
              endIndent: 20,
            ),
        itemCount: folders!.length,
        itemBuilder: (context, index) => ListTile(
              leading: const Icon(
                Icons.folder,
                color: Colors.amber,
              ),
              title: Text(folders![index].name),
              subtitle: Text(
                folders![index].description,
                maxLines: 1,
              ),
            ));
  }

  Widget noFolder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Chưa có thư mục nào",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 150,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 163, 45, 206),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              onPressed: () async {
                var rs = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateFolder()));
                if (rs != null) {
                  Fluttertoast.showToast(
                      backgroundColor: Colors.teal,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      msg: "Thêm thư mục thành công");
                }
              },
              child: const Text(
                "Tạo thư mục",
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }
}
