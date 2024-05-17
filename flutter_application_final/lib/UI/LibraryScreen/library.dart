import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/CreateFolderScreen/create_folder.dart';
import 'package:flutter_application_final/UI/CreateTopicScreen/create_topic.dart';
import 'package:flutter_application_final/UI/LibraryScreen/class.dart';
import 'package:flutter_application_final/UI/LibraryScreen/folder.dart';
import 'package:flutter_application_final/UI/LibraryScreen/topic.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class LibraryPage extends StatefulWidget {
  int? pos;
  LibraryPage({super.key, this.pos});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 3, vsync: this);
  late int p;
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    p = widget.pos ?? -1;
    if (p != -1) {
      _tabController.animateTo(p);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        title: const Text(
          "Thư viện",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if (p == 0 || p == -1) {
                  var rs = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateFolder(name: null, des: null,)));
                  if (rs != null) {
                    Fluttertoast.showToast(
                        backgroundColor: Colors.teal,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        msg: "Thêm thư mục thành công");
                  }
                }
                if (p == 1) {
                  // ignore: use_build_context_synchronously
                  var rs = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateTopic()));
                  if (rs != null) {
                    Fluttertoast.showToast(
                        backgroundColor: Colors.teal,
                        textColor: Colors.white,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        msg: "Thêm chủ đề thành công");
                  }
                }
                if (p == 2) {}
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
        bottom: TabBar(
            onTap: (value) {
              setState(() {
                p = value;
              });
            },
            indicatorColor: Colors.amber,
            controller: _tabController,
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.white,
            tabs: const [
              Tab(
                text: "Thư mục",
                icon: Icon(
                  Icons.folder,
                  color: Colors.white,
                ),
              ),
              Tab(
                text: "Chủ đề",
                icon: Icon(
                  Icons.topic,
                  color: Colors.white,
                ),
              ),
              Tab(
                text: "Lớp",
                icon: Icon(
                  Icons.people,
                  color: Colors.white,
                ),
              ),
            ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          FolderList(),
          TopicList(),
          ClassList(),
        ],
      ),
    );
  }
}
