import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/FlashCardScreen/flash_card.dart';
import 'package:flutter_application_final/UI/QuizzScreen/quizz.dart';
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
      listener: (context, state) {
        if (state is TopicDetailFlashCardClicklState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FlashCard(
                    currentWord: 1, totalWord: state.total, topic: state.topic),
              ));
        }
        if(state is TopicDetailQuizzClicklState){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Quizz(topic: state.topic, currentWord: 1, seconds: 0, correctAnswer: 0,)));
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
                                                successState.topic.listWords[index].term,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25
                                                ),
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
                                  image: AssetImage("assets/images/flash-cards.png"),
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
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              content: const Text(
                                "Vào trang làm trắc nghiệm?",
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
                                    onPressed: () {
                                      topicDetailBloc.add(TopicDetailQuizzClicklEvent(topic: successState.topic));
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Đồng ý")),
                              ],
                            ),
                          );
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
                      Container(
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
                                image: NetworkImage("https://play-lh.googleusercontent.com/uE-rLPFKIsgq4LWhHBOtkvHimgP8v-nKuqMsEZ4QRr4KZLUkJdJpXi5zx09s1YnsHw=w240-h480-rw"),
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

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }
}
