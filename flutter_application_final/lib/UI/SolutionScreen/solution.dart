

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_final/model/book.dart';

class SolutionPage extends StatefulWidget {
  const SolutionPage({Key ? key}): super(key: key);

  @override
  State<SolutionPage> createState() => _SolutionPageState();
}

class _SolutionPageState extends State<SolutionPage> {
  var scrollController = ScrollController();
  int currentIndex = 0;
  FirebaseAuth? firebaseAuth;
  late FirebaseFirestore firestore;
  late Stream<QuerySnapshot> booksStream;

  // Dummy list of tips, replace it with your actual list of tips
  List<String> tips = [
    'Practice speaking every day to improve your fluency',
    'Read English books or articles to expand your vocabulary',
    'Test 3',
    'Test 4',
    'Test 5',
  ];

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    booksStream = firestore.collection("books").snapshots();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 235, 221, 239),
      appBar: AppBar(       
        // backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        
        title: const Text(
          "Helpful Materials",
          // padding: EdgeInsets.all(12.0),
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),
        ), 
        
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child:SingleChildScrollView(
          child: Column(
            children: [    

              // book slideshow
              SizedBox(
                height: 180,
                child: ListView.builder(         
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: tips.length,
                  itemBuilder: (BuildContext context, int index){
                    return Padding(
                      padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
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
              SizedBox(height: 15,),

              // search bar
              PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight + 10.0 ), // Set the preferred height of the widget
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
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
              SizedBox(height: 10),

              // Tips
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,                
                children: [
                  Text(
                    "Tips",
                    style: TextStyle(             
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
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
                      padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
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
              
              // Videos
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Videos",
                    style: TextStyle(             
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
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
                      padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
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