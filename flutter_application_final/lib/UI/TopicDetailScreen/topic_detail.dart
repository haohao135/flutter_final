import 'package:flutter/material.dart';
import 'package:flutter_application_final/model/topic.dart';
import 'package:flutter_application_final/model/word.dart';

// ignore: must_be_immutable
class TopicDetail extends StatefulWidget {
  TopicDetail({super.key, required this.topic});
  Topic topic;

  @override
  State<TopicDetail> createState() => _TopicDetailState();
}

class _TopicDetailState extends State<TopicDetail> {
  var scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          IconButton(onPressed: (){}, icon: const Icon(Icons.share, color: Colors.white,)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert, color: Colors.white,)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              height: 180,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: widget.topic.listWords.length,
                itemBuilder: (context, index) => wordCard(widget.topic.listWords[index]),),
            )
          ],
        ),
      ),
    );
  }

  Widget wordCard(Word word){
    return AnimatedContainer(
      duration: const Duration(microseconds: 200),
      width: 370,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        shape: BoxShape.rectangle,
        color: Colors.grey[350]
      ),
      child: Center(child: Text(word.term, style: const TextStyle(color: Colors.black, fontSize: 25),)),
    );
  }
}
