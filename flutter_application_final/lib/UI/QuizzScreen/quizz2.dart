import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/QuizzScreen/quizz_result.dart';
import 'package:flutter_application_final/model/topic.dart';

// ignore: must_be_immutable
class Quizz2 extends StatefulWidget {
  Quizz2(
      {Key? key,
      required this.topic,
      required this.currentWord,
      required this.seconds,
      required this.correctAnswer, required this.answers})
      : super(key: key);
  Topic topic;
  int currentWord;
  int seconds;
  int correctAnswer;
  List<String> answers = [];
  @override
  State<Quizz2> createState() => _QuizzState();
}

class _QuizzState extends State<Quizz2> {
  
  List<String> selectedAnswers = [];
  String correctAnswer = '';
  int borderColor1 = 0, borderColor2 = 0, borderColor3 = 0, borderColor4 = 0;
  int minutes = 0;
  @override
  void initState() {
    correctAnswer = widget.topic.listWords[widget.currentWord - 1].term;
    if (widget.topic.listWords.length < 4) {
      for (var i in widget.topic.listWords) {
        selectedAnswers.add(i.term);
      }
      while (selectedAnswers.length < 4) {
        selectedAnswers.add('');
      }
      selectedAnswers.shuffle();
    } else {
      List<String> wrongAnswers = [];
      for (var i in widget.topic.listWords) {
        wrongAnswers.add(i.term);
      }
      wrongAnswers.remove(correctAnswer);
      wrongAnswers.shuffle();
      wrongAnswers = wrongAnswers.take(3).toList();
      selectedAnswers.add(correctAnswer);
      selectedAnswers.addAll(wrongAnswers);
      selectedAnswers.shuffle();
    }
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${widget.currentWord} / ${widget.topic.listWords.length}",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                content: const Text(
                  "Xác nhận thoát?",
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
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text("Đồng ý")),
                ],
              ),
            );
          },
        ),
        actions: [
          Text(
            formatTime(widget.seconds),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Chọn nghĩa của từ: ",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(
              height: 80,
            ),
            Center(
                child: Text(
              widget.topic.listWords[widget.currentWord - 1].definition,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            )),
            const SizedBox(
              height: 100,
            ),
            GestureDetector(
                onTap: () {
                  widget.answers.add(selectedAnswers[0]);
                  if (selectedAnswers[0] == correctAnswer) {
                    if(mounted){
                      setState(() {
                      borderColor1 = 1;
                      widget.correctAnswer++;
                      navigate();
                    });
                    }
                  } else {
                    if(mounted){
                      setState(() {
                      borderColor1 = 2;
                      navigate();
                    });
                    }
                  }
                },
                child: answer(selectedAnswers[0], borderColor1)),
            GestureDetector(
                onTap: () {
                  widget.answers.add(selectedAnswers[0]);
                  if (selectedAnswers[1] == correctAnswer) {
                    if(mounted){
                      setState(() {
                      borderColor2 = 1;
                      widget.correctAnswer++;
                      navigate();
                    });
                    }
                  } else {
                    if(mounted){
                      setState(() {
                      borderColor2 = 2;
                      navigate();
                    });
                    }
                  }
                },
                child: answer(selectedAnswers[1], borderColor2)),
            GestureDetector(
                onTap: () {
                  widget.answers.add(selectedAnswers[0]);
                  if (selectedAnswers[2] == correctAnswer) {
                    if(mounted){
                      setState(() {
                      borderColor3 = 1;
                      widget.correctAnswer++;
                      navigate();
                    });
                    }
                  } else {
                    if(mounted){
                      setState(() {
                      borderColor3 = 2;
                      navigate();
                    });
                    }
                  }
                },
                child: answer(selectedAnswers[2], borderColor3)),
            GestureDetector(
                onTap: () {
                  widget.answers.add(selectedAnswers[0]);
                  if (selectedAnswers[3] == correctAnswer) {
                    if(mounted){
                      setState(() {
                      borderColor4 = 1;
                      widget.correctAnswer++;
                      navigate();
                    });
                    }
                  } else {
                    if(mounted){
                      setState(() {
                      borderColor4 = 2;
                      navigate();
                    });
                    }
                  }
                },
                child: answer(selectedAnswers[3], borderColor4))
          ],
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

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        widget.seconds++;
      });
    });
  }

  Widget answer(String text, int color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(
              color: color == 0
                  ? Colors.black
                  : color == 1
                      ? Colors.green
                      : Colors.red,
              width: 4)),
      child: Center(child: Text(text)),
    );
  }

  void checkAnswer(String text, int color) {
    if (text == correctAnswer) {
      if(mounted){
        setState(() {
        color = 1;
      });
      }
    } else {
      if(mounted){
        setState(() {
        color = 2;
      });
      }
    }
  }

  void navigate() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (widget.currentWord == widget.topic.listWords.length) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => QuizzResult(topic: widget.topic, answers: widget.answers, correctAnswer: widget.correctAnswer, second: widget.seconds),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Quizz2(
                answers: widget.answers,
                  topic: widget.topic,
                  currentWord: widget.currentWord + 1,
                  seconds: widget.seconds,
                  correctAnswer: widget.correctAnswer),
            ));
      }
    });
  }
}
