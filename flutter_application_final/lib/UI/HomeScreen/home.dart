import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_final/bloc/TopicDetailBloc/topic_detail_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_final/model/topic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scrollController = ScrollController();
  int currentIndex = 0;
  // Dummy list of tips, replace it with your actual list of tips
  List<String> tips = [
    'Practice speaking every day to improve your fluency',
    'Read English books or articles to expand your vocabulary',
    'Tip 3',
    'Tip 4',
    'Tip 5',
  ];

  List<String> imagePaths = [
    'assets/images/slide1.png',
    'assets/images/slide2.png',
    'assets/images/slide3.png',
    'assets/images/slide4.png',
    'assets/images/slide5.png',
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  int startTimer() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % imagePaths.length;
      });
    });
    return currentIndex;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 235, 221, 239),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        title: const Text(
          "App Name",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
        ), 
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 10.0 ), // Set the preferred height of the widget
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) => Colors.white,
                  ),
                  controller: controller,
                  padding: MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),  
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: Icon(Icons.search),
                  hintText: "Topics, materials, ...",
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(5, (int index) {
                  final String item = 'item $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                      });
                    },
                  );
                });
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // image slideshow
              SizedBox(
                height: 180,
                child:GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: ListView.builder(         
                    itemCount:imagePaths.length,
                    itemBuilder: (BuildContext context, int index){
                      return SizedBox(
                        height: 180,
                        child: Container(
                          width: 365,
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage(imagePaths[currentIndex]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),  
              ),
              SizedBox(height: 25,),

              //topics
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Topics",
                    style: TextStyle(             
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      foregroundColor: Colors.blue,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'View all',
                    ),
                  ),
                ],
              ),
              SizedBox(   
                height: 180,
                child: ListView.builder(         
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: tips.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 270, 
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.7,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            tips[index],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Folders",
                    style: TextStyle(             
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      foregroundColor: Colors.blue,
                    ),
                    onPressed: () {},
                    child: const Text('View all'),
                  ),
                ],
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(         
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: tips.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 270, 
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.7,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            tips[index],
                            style: const TextStyle(
                              
                              color: Colors.black,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),         
        ),
      ),
    );
  }
}