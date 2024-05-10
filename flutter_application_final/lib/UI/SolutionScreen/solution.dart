
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
  late ScrollController scrollController;

  int currentIndex = 0;
  // Dummy list of tips, replace it with your actual list of tips
  List<String> tips = [
    'Practice speaking every day to improve your fluency',
    'Read English books or articles to expand your vocabulary',
    'Test 3',
    'Test 4',
    'Test 5',
  ];

  List<Book> books = [
    Book(
      id:"3Q4iwZvPBDVahdMCTzMF",
      image: 'assets/images/book1.png',
      name: 'Mathematics Extended',
      price: 22,
    ),
    Book(
      id:"nU6W38aPniHSz0rV6mej",
      image: 'assets/images/book2.png',
      name: 'IELTS Test Practice Book 2',
      price: 10,
    ),
    Book(
      id:"okDw7revv8bh42jjrhlf",
      image: 'assets/images/book3.png',
      name: 'Mcmillan English 1',
      price: 15,
    ),
    Book(
      id:"v9U3l89mlrS5rCVC2HOf",
      image: 'assets/images/book4.png',
      name: 'Eloquent JavaScript',
      price: 20,
    ),
    Book(
      id:"wwwAhLZo9Mnv4nCCtHwt",
      image: 'assets/images/book5.png',
      name: 'The Psychology Book',
      price: 14,
    ),
    Book(
      id:"0RCWNAziKrFrJSPioiGX",
      image: 'assets/images/book6.png',
      name: 'Wings of Fire The graphic novel',
      price: 23,
    ),
  ];

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: 0.0);
    scrollController.addListener(() {
      setState(() {
        currentIndex = (scrollController.offset / 100).round();
      });
    });
    startAutoScroll();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void startAutoScroll() {
    Future.delayed(const Duration(seconds: 5), () {
      if (currentIndex < books.length - 1) {
        scrollController.animateTo(
          (currentIndex + 1) * 100.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      startAutoScroll();
    });
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
                height: 210,
                child: ListView.builder(         
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: books.length*2,
                  itemBuilder: (BuildContext context, int index){
                    int bookIndex = index % books.length;
                    Book book = books[bookIndex];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
                      child: Container(
                        width: 100, 
                        padding: const EdgeInsets.only(right:5),
                        child: Column(
                          children: [
                            Image.asset(
                              book.image,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              book.name,
                              style:  const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${book.price}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        )
                      ),
                    );
                  },
                ),
              ),
              // SizedBox(height: 10,),

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