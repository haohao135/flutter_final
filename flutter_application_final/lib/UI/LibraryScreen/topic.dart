import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/create_folder_firebase.dart';
import 'package:flutter_application_final/FireBase/create_topic_firebase.dart';
import 'package:flutter_application_final/FireBase/register_account.dart';
import 'package:flutter_application_final/UI/CreateTopicScreen/create_topic.dart';
import 'package:flutter_application_final/UI/TopicDetailScreen/topic_detail.dart';
import 'package:flutter_application_final/bloc/TopicManageBloc/topic_manager_bloc.dart';
import 'package:flutter_application_final/model/folder.dart';
import 'package:flutter_application_final/model/topic.dart';
import 'package:flutter_application_final/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TopicList extends StatefulWidget {
  const TopicList({super.key});

  @override
  State<TopicList> createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  
  bool isHasTopic = false;
  List<Topic>? topicList;
  final TopicManagerBloc topicManagerBloc = TopicManagerBloc();
  List<Folder>? folders = [];
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('topics')
        .snapshots()
        .listen((querySnapshot) {
      initializeData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopicManagerBloc, TopicManagerState>(
      bloc: topicManagerBloc,
      listenWhen: (previous, current) => current is TopicManagerActionState,
      buildWhen: (previous, current) => current is! TopicManagerActionState,
      listener: (context, state) {
        if (state is DetailTopicManagerEventClickState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TopicDetail(
                topic: state.topic,
              ),
            ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case TopicManagerNoTopicState:
            return noTopic();
          case TopicManagerSuccessState:
            final successState = state as TopicManagerSuccessState;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: successState.topicList.length,
                itemBuilder: (context, index) {
                  return FutureBuilder(
                    future: topicItem(
                        onTap: () => topicManagerBloc.add(
                            DetailTopicManagerEventClickEvent(
                                topic: successState.topicList[index])),
                        topic: successState.topicList[index],
                        topicManagerBloc: topicManagerBloc),
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
                });
          case TopicManagerLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }

  void initializeData() async {
    await getData(topicManagerBloc);
    await getFolders();
    //await Register.getUserById();
    if (topicList != null && topicList!.isNotEmpty) {
      isHasTopic = true;
      topicManagerBloc.add(
          InitialTopicManagerEvent(hasTopic: isHasTopic, topicList: topicList));
    } else {
      topicManagerBloc.add(InitialTopicManagerEvent(hasTopic: isHasTopic));
    }
  }

  Future<void> getData(TopicManagerBloc bloc) async {
    bloc.add(LoadingTopicManagerEvent());
    List<Topic> li = await CreateTopicFireBase.getTopicData();
    setState(() {
      topicList = li;
    });
  }

  Widget noTopic() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Chưa có chủ đề nào",
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
                        builder: (context) => const CreateTopic()));
                if (rs != null) {
                  Fluttertoast.showToast(
                      backgroundColor: Colors.teal,
                      textColor: Colors.white,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      msg: "Thêm chủ đề thành công");
                }
              },
              child: const Text(
                "Tạo chủ đề",
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }

  Future<Widget> topicItem({Function()? onTap,required Topic topic,required TopicManagerBloc topicManagerBloc}) async {
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
                )
              ),
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

  // Widget lisTileCustom(
  //     {required Topic topic, required TopicManagerBloc topicManagerBloc}) {
  //   return ListTile(
  //     onTap: () {
  //       topicManagerBloc.add(DetailTopicManagerEventClickEvent(topic: topic));
  //     },
  //     leading: const Icon(
  //       Icons.topic,
  //       color: Colors.amber,
  //     ),
  //     title: Text(topic.name),
  //     // trailing: PopupMenuButton(
  //     //   onSelected: (value) {
  //     //     if (value == "Xóa") {
  //     //       showDialog(
  //     //         context: context,
  //     //         builder: (context) => AlertDialog(
  //     //           shape: RoundedRectangleBorder(
  //     //               borderRadius: BorderRadius.circular(0)),
  //     //           content: const Text(
  //     //             "Xóa chủ đề?",
  //     //             style: TextStyle(fontSize: 20),
  //     //           ),
  //     //           contentPadding: const EdgeInsets.all(30),
  //     //           actions: [
  //     //             TextButton(
  //     //                 onPressed: () {
  //     //                   Navigator.pop(context);
  //     //                 },
  //     //                 child: const Text("Hủy")),
  //     //             TextButton(
  //     //                 onPressed: () async {
  //     //                   Navigator.of(context).pop();
  //     //                   await CreateTopicFireBase.deleteTopic(topic);
  //     //                   Fluttertoast.showToast(
  //     //                       backgroundColor: Colors.teal,
  //     //                       textColor: Colors.white,
  //     //                       toastLength: Toast.LENGTH_SHORT,
  //     //                       gravity: ToastGravity.BOTTOM,
  //     //                       msg: "Đã xóa chủ đề");
  //     //                 },
  //     //                 child: const Text("Đồng ý")),
  //     //           ],
  //     //         ),
  //     //       );
  //     //     }
  //     //     if (value == "Thêm vào thư mục") {
  //     //       showFolderSelectionDialog(context, topic);
  //     //     }
  //     //   },
  //     //   itemBuilder: (context) {
  //     //     return [
  //     //       const PopupMenuItem(
  //     //         value: "Thêm vào thư mục",
  //     //         child: Text("Thêm vào thư mục"),
  //     //       ),
  //     //       const PopupMenuItem(
  //     //         value: "Xóa",
  //     //         child: Text("Xóa"),
  //     //       )
  //     //     ];
  //     //   },
  //     // ),
  //   );
  // }

  Future<void> getFolders() async {
    List<Folder> foldersss = await CreateFolderFireBase.getFolderData();
    setState(() {
      folders!.addAll(foldersss);
    });
  }

  void showFolderSelectionDialog(BuildContext context, Topic topic) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          title: const Text('Chọn thư mục'),
          content: SizedBox(
            height: 150,
            width: double.maxFinite,
            child: folders!.isNotEmpty && folders != null
                ? ListView.builder(
                    itemCount: folders!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          if (!folders![index].listTopicId.contains(topic.id)) {
                            folders![index].listTopicId.add(topic.id);
                            CreateFolderFireBase.updateFolder(folders![index]);
                          }
                          Fluttertoast.showToast(
                              backgroundColor: Colors.teal,
                              textColor: Colors.white,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              msg:
                                  "Đã thêm vào folder ${folders![index].name}");
                          Navigator.of(context).pop();
                        },
                        title: Text(folders![index].name),
                        leading: Image.asset("assets/images/folder.png"),
                      );
                    },
                  )
                : const Center(child: Text("Hiện tại chưa có thư mục nào")),
          ),
        );
      },
    );
  }
}
