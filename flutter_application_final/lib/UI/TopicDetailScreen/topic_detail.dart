import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/create_folder_firebase.dart';
import 'package:flutter_application_final/FireBase/create_topic_firebase.dart';
import 'package:flutter_application_final/FireBase/register_account.dart';
import 'package:flutter_application_final/UI/CreateTopicScreen/update_topic.dart';
import 'package:flutter_application_final/UI/FlashCardScreen/before_flash_card.dart';
import 'package:flutter_application_final/UI/QuizzScreen/before_quizz.dart';
import 'package:flutter_application_final/UI/TypingPracticsScreen/before_typing.dart';
import 'package:flutter_application_final/bloc/TopicDetailBloc/topic_detail_bloc.dart';
import 'package:flutter_application_final/model/folder.dart';
import 'package:flutter_application_final/model/topic.dart';
import 'package:flutter_application_final/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../TopicRankingScreen/topic_ranking.dart';

// ignore: must_be_immutable
class TopicDetail extends StatefulWidget {
  TopicDetail({super.key, required this.topic});
  Topic topic;
  @override
  State<TopicDetail> createState() => _TopicDetailState();
}

class _TopicDetailState extends State<TopicDetail> {
  var scrollController = ScrollController();
  final TopicDetailBloc topicDetailBloc = TopicDetailBloc();
  int selectedVocabularyIndex = -1;
  FirebaseAuth? firebaseAuth;
  String avatarUrl = "";
  FlutterTts flutterTts = FlutterTts();
  Users? user;
  List<Folder>? folders = [];
  List<String> popUpItem = ["Thêm vào thư mục", "Xem bảng xếp hạng"];
  @override
  void initState() {
    topicDetailBloc.add(TopicDetailInitialEvent(topic: widget.topic));
    firebaseAuth = FirebaseAuth.instance;
    if (firebaseAuth!.currentUser!.photoURL != null &&
        firebaseAuth!.currentUser!.photoURL!.isNotEmpty) {
      avatarUrl = firebaseAuth!.currentUser!.photoURL ?? "";
    }
    if (firebaseAuth!.currentUser!.uid == widget.topic.userId) {
      popUpItem.add("Sửa chủ đề");
      popUpItem.add("Xóa chủ đề");
    }
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopicDetailBloc, TopicDetailState>(
      bloc: topicDetailBloc,
      listenWhen: (previous, current) => current is TopicDetailActionState,
      buildWhen: (previous, current) => current is! TopicDetailActionState,
      listener: (context, state) {
        if (state is TopicDetailFlashCardClicklState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BeforeFlashCard(topic: state.topic),
              ));
        }
        if (state is TopicDetailQuizzClicklState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BeforeQuizz(topic: state.topic)));
        }
        if (state is TopicDetailTypingPracticeClicklState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BeforeTyping(topic: state.topic)));
        }
        if (state is TopicDetailUpdateClicklState) {
          updateTopic(state.topic);
        }

        if (state is TopicDetailResultUserClicklState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TopicRanking(topic: state.topic),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case TopicDetailSuccesslState:
            final successState = state as TopicDetailSuccesslState;
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 235, 221, 239),
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 163, 45, 206),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white,
                      )),
                  PopupMenuButton(
                    onSelected: (value) {
                      if (value == "Thêm vào thư mục") {
                        showFolderSelectionDialog(context);
                      }
                      if (value == "Xem bảng xếp hạng") {
                        topicDetailBloc.add(TopicDetailResultUserClicklEvent(topic: widget.topic));
                      }
                      if (value == "Sửa chủ đề") {
                        topicDetailBloc.add(
                            TopicDetailUpdateClicklEvent(topic: widget.topic));
                      }
                      if (value == "Xóa chủ đề") {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            content: const Text(
                              "Xác nhận xóa chủ đề?",
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
                                    Navigator.pop(context);
                                    await CreateTopicFireBase.deleteTopic(
                                        widget.topic);
                                  },
                                  child: const Text("Đồng ý")),
                            ],
                          ),
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                    itemBuilder: (context) => popUpItem
                        .map((e) => PopupMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                            controller: scrollController,
                            scrollDirection: Axis.horizontal,
                            itemCount: successState.topic.listWords.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selectedVocabularyIndex == index) {
                                        selectedVocabularyIndex = -1;
                                      } else {
                                        selectedVocabularyIndex = index;
                                      }
                                    });
                                  },
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    transitionBuilder: (child, animation) {
                                      return ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      );
                                    },
                                    child: selectedVocabularyIndex == index
                                        ? Container(
                                            key: UniqueKey(),
                                            width: 370,
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                shape: BoxShape.rectangle,
                                                color: Colors.white),
                                            child: Center(
                                                child: Text(
                                              successState.topic
                                                  .listWords[index].definition,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                          )
                                        : Container(
                                            key: UniqueKey(),
                                            width: 370,
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                shape: BoxShape.rectangle,
                                                color: Colors.white),
                                            child: Center(
                                              child: Text(
                                                successState.topic
                                                    .listWords[index].term,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 25),
                                              ),
                                            ),
                                          ),
                                  ));
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            successState.topic.name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.download,
                                color: Colors.red,
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          // CircleAvatar(
                          //   backgroundImage: AssetImage(avatarUrl),
                          // ),
                          Text(
                            firebaseAuth!.currentUser!.email.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            " | ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${successState.topic.listWords.length} từ",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          topicDetailBloc.add(TopicDetailFlashCardClicklEvent(
                              topic: successState.topic,
                              total: successState.topic.listWords.length));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          height: 60,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: const Row(children: [
                            SizedBox(
                                height: 40,
                                width: 40,
                                child: Image(
                                  image: AssetImage(
                                      "assets/images/flash-cards.png"),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "FlashCard",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            )
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          topicDetailBloc.add(TopicDetailQuizzClicklEvent(
                              topic: successState.topic));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          height: 60,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: const Row(children: [
                            SizedBox(
                                height: 40,
                                width: 40,
                                child: Image(
                                  image: AssetImage("assets/images/quizz.png"),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Quizz",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            )
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          topicDetailBloc.add(
                              TopicDetailTypingPracticeClicklEvent(
                                  topic: successState.topic));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          height: 60,
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: const Row(children: [
                            SizedBox(
                                height: 40,
                                width: 40,
                                child: Image(
                                  image: NetworkImage(
                                      "https://play-lh.googleusercontent.com/uE-rLPFKIsgq4LWhHBOtkvHimgP8v-nKuqMsEZ4QRr4KZLUkJdJpXi5zx09s1YnsHw=w240-h480-rw"),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Typing Practice",
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            )
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Từ vựng",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: successState.topic.listWords.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                  content: const Text(
                                    "Xác nhận xóa từ vựng?",
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
                                          setState(() {
                                            widget.topic.listWords.remove(
                                                widget.topic.listWords[index]);
                                          });
                                          await CreateTopicFireBase.updateTopic(
                                              widget.topic);
                                        },
                                        child: const Text("Đồng ý")),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    successState.topic.listWords[index].term,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 163, 45, 206),
                                        fontSize: 20),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            speak(successState
                                                .topic.listWords[index].term);
                                          },
                                          icon: const Icon(Icons.volume_up)),
                                      IconButton(
                                          onPressed: () {
                                            topicDetailBloc.add(
                                                TopicDetailStarClicklEvent(
                                                    topic: successState.topic,
                                                    index: index));
                                          },
                                          icon: successState
                                                  .topic.listWords[index].isStar
                                              ? const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                )
                                              : const Icon(
                                                  Icons.star_border_outlined,
                                                  color: Colors.amber,
                                                )),
                                      IconButton(
                                          onPressed: () async {
                                            await getUser(
                                                firebaseAuth!.currentUser!.uid);
                                            bool a = user!.listFavouriteWord
                                                .any((element) =>
                                                    element.term ==
                                                    successState.topic
                                                        .listWords[index].term);
                                            if (!a) {
                                              user!.listFavouriteWord.add(
                                                  successState
                                                      .topic.listWords[index]);
                                            }
                                            await updateUser(user!);
                                            Fluttertoast.showToast(
                                                backgroundColor: Colors.teal,
                                                textColor: Colors.white,
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                msg:
                                                    "Đã thêm vào danh sách yêu thích");
                                          },
                                          icon: const Icon(
                                            Icons.favorite_border_rounded,
                                            color: Colors.red,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          case TopicDetailLoadinglState:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  Future<void> getUser(String id) async {
    user = await Register.getUserById(id);
  }

  Future<void> initializeData() async {
    await getFolders();
  }

  Future<void> getFolders() async {
    List<Folder> foldersss = await CreateFolderFireBase.getFolderData();
    setState(() {
      folders!.addAll(foldersss);
    });
  }

  Future<void> updateUser(Users user) async {
    await Register.updateUser(user);
  }

  void showFolderSelectionDialog(BuildContext context) {
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
                          if (!folders![index]
                              .listTopicId
                              .contains(widget.topic.id)) {
                            folders![index].listTopicId.add(widget.topic.id);
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

  void updateTopic(Topic thisTopic) async {
    var rs = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => UpdateTopic(topic: thisTopic)));
    if (rs != null) {
      Fluttertoast.showToast(
          backgroundColor: Colors.teal,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          msg: "Cập nhật thành công");
    }
  }
}
