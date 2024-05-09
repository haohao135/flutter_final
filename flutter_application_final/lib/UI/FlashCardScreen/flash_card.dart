import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/model/topic.dart';
import 'package:flutter_tts/flutter_tts.dart';

// ignore: must_be_immutable
class FlashCard extends StatefulWidget {
  FlashCard(
      {super.key,
      required this.currentWord,
      required this.totalWord,
      required this.topic});
  int currentWord;
  int totalWord;
  Topic topic;

  @override
  State<FlashCard> createState() => _FlashCardState();
}

class _FlashCardState extends State<FlashCard> {
  FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${widget.currentWord} / ${widget.totalWord}",
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
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (widget.currentWord != widget.totalWord) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FlashCard(
                              currentWord: widget.currentWord + 1,
                              totalWord: widget.totalWord,
                              topic: widget.topic)));
                } else {
                  for (var i = 0; i <= widget.currentWord; i++) {
                    Navigator.pop(context);
                  }
                }
              },
              icon: widget.currentWord == widget.totalWord
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlipCard(
                front: customCard(
                    widget.topic.listWords[widget.currentWord - 1].term, speak),
                back: customCard(
                    widget.topic.listWords[widget.currentWord - 1].definition,
                    speak1)),
            const SizedBox(
              height: 70,
            )
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              content: const Text("Bạn đồng ý thoát?", style: TextStyle(fontSize: 20),),
              contentPadding: const EdgeInsets.all(30),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Hủy")),
                TextButton(
                    onPressed: () {
                      for (var i = 0; i <= widget.currentWord; i++) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Đồng ý")),
              ],
            ),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget customCard(String text, Function onSpeak) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 175, 66, 215)),
      child: Stack(children: [
        Positioned(
            right: 8,
            top: 8,
            child: IconButton(
                onPressed: () {
                  onSpeak(text);
                },
                icon: const Icon(
                  Icons.volume_up,
                  color: Colors.white,
                ))),
        Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
      ]),
    );
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  Future<void> speak1(String text) async {
    await flutterTts.setLanguage('vi-VN');
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }
}
