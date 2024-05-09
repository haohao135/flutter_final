import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/FlashCardScreen/flash_card.dart';
import 'package:flutter_application_final/model/topic.dart';
import 'package:flutter_application_final/model/word.dart';

// ignore: must_be_immutable
class BeforeFlashCard extends StatelessWidget {
  BeforeFlashCard({super.key, required this.topic});
  Topic topic;

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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Học từ vựng theo Flash Card",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 163, 45, 206),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FlashCard(
                          currentWord: 1,
                          totalWord: topic.listWords.length,
                          topic: topic),
                    ));
              },
              child: const Text(
                "Tất cả",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 163, 45, 206),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              onPressed: () {
                Topic topic2 = newTopic(topic.id, topic.name, topic.listWords, topic.mode, topic.author, topic.userId);
                if(topic2.listWords.isEmpty){
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      content: const Text(
                        "Chưa có từ nào được đánh dấu",
                        style: TextStyle(fontSize: 20),
                      ),
                      contentPadding: const EdgeInsets.all(30),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK")),
                      ],
                    ),
                  );
                } else{
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FlashCard(
                          currentWord: 1,
                          totalWord: topic2.listWords.length,
                          topic: topic2),
                    ));
                }
                
              },
              child: const Text(
                "Từ được gắn sao",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
        ],
      ),
    );
  }
  Topic newTopic(String id, String name, List<Word> listWords, bool mode, String? author, String userId){
    Topic topic = Topic(id: id, name: name, listWords: listWords, mode: mode, author: author, userId: userId);
    List<Word> newListWord = [];
    for(var i in topic.listWords){
      if(i.isStar){
        newListWord.add(i);
      }
    }
    topic.listWords.clear();
    topic.listWords.addAll(newListWord);
    return topic;
  }
}
