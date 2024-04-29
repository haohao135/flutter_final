import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/LibraryScreen/class.dart';
import 'package:flutter_application_final/UI/LibraryScreen/folder.dart';
import 'package:flutter_application_final/UI/LibraryScreen/topic.dart';

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
    if(p != -1){
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
        bottom: TabBar(
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
