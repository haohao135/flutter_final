import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/create_folder_firebase.dart';
import 'package:flutter_application_final/FireBase/create_topic_firebase.dart';
import 'package:flutter_application_final/FireBase/register_account.dart';
import 'package:flutter_application_final/UI/TopicDetailScreen/topic_detail.dart';
import 'package:flutter_application_final/model/folder.dart';
import 'package:flutter_application_final/model/topic.dart';
import 'package:flutter_application_final/model/user.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class FolderDetail extends StatefulWidget {
  FolderDetail({super.key, required this.folder});
  Folder folder;
  @override
  State<FolderDetail> createState() => _FolderDetailState();
}

class _FolderDetailState extends State<FolderDetail> {
  bool isLoading = false;
  late List<Topic> topicList;
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('folders')
        .snapshots()
        .listen((querySnapshot) {
      getTopic();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Thư mục của tôi",
            style: TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 163, 45, 206),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (widget.folder.listTopicId.isEmpty) {
        return noTopic();
      } else {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Thư mục của tôi",
              style: TextStyle(color: Colors.white),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromARGB(255, 163, 45, 206),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.folder.listTopicId.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: topicItem(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TopicDetail(
                            topic: topicList[index],
                          ),
                        )),
                    topic: topicList[index],
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snapshot.hasError) {
                      return Text('Lỗi: ${snapshot.error}');
                    } else {
                      return snapshot.data!;
                    }
                  },
                );
              }),
        );
      }
    }
  }

  Future<void> getTopic() async {
    setState(() {
      isLoading = true;
    });
    List<Topic> topicList1 = [];
    for (var i in widget.folder.listTopicId) {
      Topic tp = await CreateTopicFireBase.getTopicByTopicId(i);
      topicList1.add(tp);
    }
    setState(() {
      topicList = topicList1;
      isLoading = false;
    });
  }

  Future<Widget> topicItem({Function()? onTap, required Topic topic}) async {
    Users users = await Register.getUserById(topic.userId);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        height: 190,
        width: double.infinity,
        padding: const EdgeInsets.only(right: 8, top: 10, bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey,
            width: 0.7,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            topic.name,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        PopupMenuButton(
                          onSelected: (value) {
                            if (value == "Xóa") {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                  content: const Text(
                                    "Xóa chủ đề?",
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
                                          widget.folder.listTopicId
                                              .remove(topic.id);
                                          await CreateFolderFireBase
                                              .updateFolder(widget.folder);
                                          Fluttertoast.showToast(
                                              backgroundColor: Colors.teal,
                                              textColor: Colors.white,
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              msg:
                                                  "Đã xóa chủ để khỏi thư mục");
                                        },
                                        child: const Text("Đồng ý")),
                                  ],
                                ),
                              );
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem(
                                value: "Xóa",
                                child: Text("Xóa"),
                              )
                            ];
                          },
                        ),
                      ],
                    ),
                    Text(
                      "${topic.listWords.length} từ vựng",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 112, 112, 112),
                        fontSize: 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 15,
                      backgroundImage: AssetImage('assets/images/user1.png'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      users.email,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget noTopic() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Thư mục của tôi",
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: const Center(
        child: Text(
          "Chưa có chủ đề nào",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
