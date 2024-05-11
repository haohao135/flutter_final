import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/model/folder.dart';

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
    'bla bla bla',
    'Read English books or articles to expand your vocabulary',
    'Test 3',
    'Test 4',
    'Test 5',
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
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),       
        title: const Text(
          "App Name",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),
        ), 
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 30.0 ), // Set the preferred height of the widget
          child: Padding(
            padding:  EdgeInsets.only(bottom: 25,left: 8,right: 8),
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
                      padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
                      child: Container(
                        width: 270, 
                        padding: const EdgeInsets.only(right: 8,top: 10,bottom: 8),
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

                        child: const Column(                                                   
                          children: [     
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 16, left: 8), // Adjust the left and right padding as needed
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // topic's name
                                    Text(
                                      "Tsdasdasdasdasdasddddasdasd",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                    // number of words
                                    Text(
                                      "33 terms",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 112, 112, 112),
                                        fontSize: 18,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // owner's name, avatar
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.all(5)),
                                CircleAvatar(
                                  radius: 15, // Adjust the size of the avatar as needed
                                  backgroundImage: AssetImage('assets/images/user1.png'),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  "Henry Quill",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20,),
              
              // Folders
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

                        child: const Column(                                                   
                          children: [     
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 16, left: 8), // Adjust the left and right padding as needed
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.folder_outlined),
                                    // topic's name
                                    Text(
                                      "Tsdasdasddasdasdasdasdasddasddddasdasd",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),

                                  ],
                                ),
                              ),
                            ),

                            // owner's name, avatar
                            Row(
                              children: [
                                Padding(padding: EdgeInsets.all(5)),
                                CircleAvatar(
                                  radius: 15, // Adjust the size of the avatar as needed
                                  backgroundImage: AssetImage('assets/images/user1.png'),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  "Henry Quill",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            )
                          ],
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