import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/create_folder_firebase.dart';
import 'package:flutter_application_final/UI/CreateFolderScreen/create_folder.dart';
import 'package:flutter_application_final/UI/FolderDetail/folder_detail.dart';
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
    FirebaseFirestore.instance
        .collection('folders')
        .snapshots()
        .listen((querySnapshot) {
      getData();
    });
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
    if (mounted) {
      setState(() {
        folders = folderData;
        isLoading = false;
      });
    }
  }

  Widget hasFolder() {
    return ListView.separated(
        separatorBuilder: (context, index) => const Divider(
              indent: 20,
              endIndent: 20,
            ),
        itemCount: folders!.length,
        itemBuilder: (context, index) => ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FolderDetail(folder: folders![index]),
                  )),
              leading: Image.asset("assets/images/folder.png"),
              title: Text(folders![index].name),
              subtitle: Text(
                folders![index].description,
                maxLines: 1,
              ),
              trailing: PopupMenuButton(
                onSelected: (value) {
                  if (value == "Xóa") {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        content: const Text(
                          "Xóa thư mục?",
                          style: TextStyle(fontSize: 20),
                        ),
                        contentPadding: const EdgeInsets.all(30),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Hủy")),
                          TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await CreateFolderFireBase.deleteFolder(
                                    folders![index]);
                                Fluttertoast.showToast(
                                    backgroundColor: Colors.teal,
                                    textColor: Colors.white,
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    msg: "Đã xóa thư mục");
                              },
                              child: const Text("Đồng ý")),
                        ],
                      ),
                    );
                  }
                  if (value == "Chỉnh sửa") {
                    updateFol(index, folders![index]);
                  }
                },
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      value: "Chỉnh sửa",
                      child: Text("Chỉnh sửa"),
                    ),
                    const PopupMenuItem(
                      value: "Xóa",
                      child: Text("Xóa"),
                    )
                  ];
                },
              ),
            ));
  }

  Future<void> updateFol(int index, Folder folder) async {
    var rs = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateFolder(
            name: folders![index].name,
            des: folders![index].description,
            folder: folder,
          ),
        ));
    if (rs != null) {
      Fluttertoast.showToast(
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          msg: "Chỉnh sửa thư mục thành công");
    }
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
                        builder: (context) => CreateFolder(
                              name: null,
                              des: null,
                            )));
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
