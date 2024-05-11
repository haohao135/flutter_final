import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/create_topic_firebase.dart';
import 'package:flutter_application_final/UI/CreateTopicScreen/create_topic.dart';
import 'package:flutter_application_final/UI/TopicDetailScreen/topic_detail.dart';
import 'package:flutter_application_final/bloc/TopicManageBloc/topic_manager_bloc.dart';
import 'package:flutter_application_final/model/topic.dart';
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
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                indent: 20,
                endIndent: 20,
              ),
              itemCount: successState.topicList.length,
              itemBuilder: (context, index) => lisTileCustom(
                  topic: successState.topicList[index],
                  topicManagerBloc: topicManagerBloc),
            );
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

  Widget lisTileCustom(
      {required Topic topic, required TopicManagerBloc topicManagerBloc}) {
    return ListTile(
      onTap: () {
        topicManagerBloc.add(DetailTopicManagerEventClickEvent(topic: topic));
      },
      leading: const Icon(
        Icons.topic,
        color: Colors.amber,
      ),
      title: Text(topic.name),
      trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
    );
  }
}
