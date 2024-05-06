import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/bloc/TopicDetailBloc/topic_detail_bloc.dart';
import 'package:flutter_application_final/model/topic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

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
  @override
  void initState() {
    topicDetailBloc.add(TopicDetailInitialEvent(topic: widget.topic));
    firebaseAuth = FirebaseAuth.instance;
    if (firebaseAuth!.currentUser!.photoURL != null &&
        firebaseAuth!.currentUser!.photoURL!.isNotEmpty) {
      avatarUrl = firebaseAuth!.currentUser!.photoURL ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopicDetailBloc, TopicDetailState>(
      bloc: topicDetailBloc,
      listenWhen: (previous, current) => current is TopicDetailActionState,
      buildWhen: (previous, current) => current is! TopicDetailActionState,
      listener: (context, state) {},
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
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      )),
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
                                              successState
                                                  .topic.listWords[index].term,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25),
                                            )),
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
                      Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: const Row(children: [
                          SizedBox(
                              height: 40,
                              width: 40,
                              child: Image(
                                image: AssetImage("assets/images/card.jpg"),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "FlasCard",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: const Row(children: [
                          SizedBox(
                              height: 40,
                              width: 40,
                              child: Image(
                                image: AssetImage("assets/images/card.jpg"),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "FlasCard",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: const Row(children: [
                          SizedBox(
                              height: 40,
                              width: 40,
                              child: Image(
                                image: AssetImage("assets/images/card.jpg"),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "FlasCard",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: const Row(children: [
                          SizedBox(
                              height: 40,
                              width: 40,
                              child: Image(
                                image: AssetImage("assets/images/card.jpg"),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "FlasCard",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          )
                        ]),
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
                          return Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  successState.topic.listWords[index].term,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 163, 45, 206),
                                      fontSize: 20),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          speak(successState
                                                .topic.listWords[index].term);
                                        },
                                        icon: const Icon(Icons.volume_up)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: successState
                                                .topic.listWords[index].isStar
                                            ? const Icon(
                                                Icons.star_border_outlined,
                                                color: Colors.amber,
                                              )
                                            : const Icon(
                                                Icons.star_border_outlined,
                                                color: Colors.amber,
                                              ))
                                  ],
                                )
                              ],
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

  Future<void> speak(String text) async{
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }
}
