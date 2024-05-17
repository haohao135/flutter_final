import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/create_topic_firebase.dart';
import 'package:flutter_application_final/model/topic.dart';
import 'package:flutter_application_final/model/user_result.dart';
import 'package:flutter_tts/flutter_tts.dart';
// import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class QuizzResult extends StatefulWidget {
  QuizzResult(
      {super.key,
      required this.topic,
      required this.correctAnswer,
      required this.second,
      required this.answers});
  Topic topic;
  int correctAnswer;
  int second;
  List<String> answers;
  @override
  State<QuizzResult> createState() => _QuizzResultState();
}

class _QuizzResultState extends State<QuizzResult> {
  int? phantram;
  FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    phantram =
        ((widget.correctAnswer / widget.topic.listWords.length) * 100).toInt();
    String rsId = const Uuid().v4();
    DateTime now = DateTime.now();
    UserResult userResult = UserResult(
        id: rsId,
        userId: FirebaseAuth.instance.currentUser!.uid,
        correctAnswers: widget.correctAnswer,
        date: now,
        duration: widget.second,
        attempt: 1, mode: false);
    for (var i in widget.topic.listUserResults) {
      if (i.userId == FirebaseAuth.instance.currentUser!.uid && i.mode == false) {
        userResult.attempt = i.attempt + 1;
        widget.topic.listUserResults.remove(i);
        break;
      }
    }
    updateTopic(widget.topic, userResult);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 221, 239),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 270,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bạn đã hoàn thành!",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Tiếp theo, hãy luyện tập các từ vựng mà bạn đã bỏ lỡ.",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset("assets/images/light-bulb.png")),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Kết quả",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Stack(alignment: Alignment.center, children: [
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        value: (phantram! / 100),
                        strokeWidth: 15,
                        backgroundColor:
                            const Color.fromARGB(255, 243, 164, 158),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Text(
                        "$phantram%",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ]),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 50),
                            child: const Text(
                              "Số câu đúng",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(width: 2, color: Colors.green)),
                            child: Center(
                              child: Text(
                                "${widget.correctAnswer}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 50),
                            child: const Text(
                              "Số câu sai",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(width: 2, color: Colors.red)),
                            child: Center(
                              child: Text(
                                "${widget.topic.listWords.length - widget.correctAnswer}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Thời gian làm bài: ${formatTime(widget.second)}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Bước tiếp theo",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    backgroundColor: const Color.fromARGB(255, 163, 45, 206),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Làm lại",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color.fromARGB(255, 163, 45, 206), width: 2),
                        borderRadius: BorderRadius.circular(4)),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Trở về trang topic",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Câu trả lời của bạn",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: widget.topic.listWords.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.answers[index] ==
                              widget.topic.listWords[index].definition
                          ? Container(
                              padding: const EdgeInsets.all(4),
                              height: 30,
                              width: double.infinity,
                              decoration:
                                  const BoxDecoration(color: Colors.green),
                              child: const Text(
                                "Đúng!",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(4),
                              height: 30,
                              width: double.infinity,
                              decoration:
                                  const BoxDecoration(color: Colors.red),
                              child: const Text(
                                "Sai!",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        margin: const EdgeInsets.only(bottom: 20),
                        height: 115,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 219, 213, 213)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Đáp án: ${widget.topic.listWords[index].definition}",
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Câu trả lời của bạn: ${widget.answers[index]}",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.topic.listWords[index].term,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                IconButton(
                                    onPressed: () {
                                      speak(widget.topic.listWords[index].term);
                                    },
                                    icon: const Icon(Icons.volume_up)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  String formatTime(int seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  Future<void> updateTopic(Topic topic, UserResult userResult) async {
    await addResult(userResult);
    await CreateTopicFireBase.updateTopic(topic);
  }

  Future<void> addResult(UserResult userResult) async {
    widget.topic.listUserResults.add(userResult);
  }
}
