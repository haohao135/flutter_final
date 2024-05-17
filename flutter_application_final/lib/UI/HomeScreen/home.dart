import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_final/FireBase/create_folder_firebase.dart';
import 'package:flutter_application_final/FireBase/create_topic_firebase.dart';
import 'package:flutter_application_final/UI/LibraryScreen/library.dart';
import 'package:flutter_application_final/bloc/TopicManageBloc/topic_manager_bloc.dart';
import 'package:flutter_application_final/model/folder.dart';
import 'package:flutter_application_final/model/topic.dart';

import '../FolderDetail/folder_detail.dart';
import '../TopicDetailScreen/topic_detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scrollController = ScrollController();
  var author = TextEditingValue();
  int currentIndex = 0;
  int num=0;
  bool isHasTopic = false;
  List<Topic>? topicList;
  List<Folder>? folders = [];
  int foldersNum=0;
  // String? _email;
  FirebaseAuth? firebaseAuth =FirebaseAuth.instance;
  
  
  final TopicManagerBloc topicManagerBloc = TopicManagerBloc();
  List<String> imagePaths = [
    'assets/images/slide1.png',
    'assets/images/slide2.png',
    'assets/images/slide3.png',
    'assets/images/slide4.png',
    'assets/images/slide5.png',
  ];

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('topics')
        .snapshots()
        .listen((querySnapshot) {
      initializeData();
    });
    FirebaseFirestore.instance
        .collection('folders')
        .snapshots()
        .listen((querySnapshot) {
      userFolders();
    });
    super.initState();
    startTimer();
  }

  Future<void> getData(TopicManagerBloc bloc) async {
    bloc.add(LoadingTopicManagerEvent());
    List<Topic> li = await CreateTopicFireBase.getTopicDataPublic();
    setState(() {
      topicList = li;
    });
  }
  Future<void> getFolders() async {
    List<Folder> foldersss = await CreateFolderFireBase.getFolderData();
    setState(() {
      folders!.addAll(foldersss);
    });
  }

  void initializeData() async {
    await getData(topicManagerBloc);
    // await Register.getUserById();
    if (topicList != null && topicList!.isNotEmpty) {
      isHasTopic = true;
      topicManagerBloc.add(
          InitialTopicManagerEvent(hasTopic: isHasTopic, topicList: topicList));
    } else {
      topicManagerBloc.add(InitialTopicManagerEvent(hasTopic: isHasTopic));
    }
  }

  void userFolders()async{
    List<Folder> folderData = await CreateFolderFireBase.getFolderData();
    setState(() {
      folders = folderData;
    });
  }

  int startTimer() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % imagePaths.length;
      });
    });
    return currentIndex;
  }

  void navigateToLibary(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LibraryPage()),
  );
}
  @override
  Widget build(BuildContext context) {
    foldersNum= folders!.length;
    if(folders!.length==0 ){
      foldersNum = 1;
      // log("we got "+foldersNum.toString());
    }   
    return Scaffold(
      appBar: AppBar(       
        elevation: 20.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(40),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 163, 45, 206),       
        title: const Text(
          "App Name",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),
        ), 
        // search bar
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
                    onPressed: () {
                      // setState(() {
                      //   currenScreen = LibraryPage(pos: 0,);
                      //   currenTab = 2;
                      // });
                    },
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
                  itemCount: topicList?.length ?? 0,
                  itemBuilder: (BuildContext context, int index){
                    final topic = topicList?[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TopicDetail(
                            topic: topic,
                          ),
                        )
                      ),
                      child: Padding(
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
                          child: Padding(    
                            padding: const EdgeInsets.all(12.0),  
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [     
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0), // Adjust the left and right padding as needed
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                topic!.name,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                      
                                        // number of words
                                        Text(
                                          "${topic.listWords.length} từ vựng",
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
                                    const Padding(padding: EdgeInsets.all(5)),
                                    CircleAvatar(
                                      radius: 15, // Adjust the size of the avatar as needed
                                      backgroundImage: AssetImage('assets/images/user1.png'),
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      topic.author.toString(),
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
                    onPressed: () => navigateToLibary(context),
                    child: const Text('View all'),
                  ),
                ],
              ),
              SizedBox(
                height: 180,
                child: ListView.builder(                         
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,                 
                  itemCount:foldersNum,
                  itemBuilder: (BuildContext context, int index){
                    switch(folders!.length){
                      case 0:
                        return noFolders();
                      default:
                        final folder = folders![index];
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FolderDetail(
                                folder: folder,
                              ),
                            )
                          ),
                          child: Padding(
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
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(    
                              padding: const EdgeInsets.all(12.0),  
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [     
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0), // Adjust the left and right padding as needed
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.folder_outlined),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,                                     
                                            children: [
                                              Expanded(
                                                child: 
                                                  Text(
                                                    folders![index].name,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          
                                  // owner's name, avatar
                                  Row(
                                    children: [   
                                      const Padding(padding: EdgeInsets.all(5)),
                                      CircleAvatar(
                                        radius: 15, // Adjust the size of the avatar as needed
                                        backgroundImage: AssetImage('assets/images/user1.png'),
                                      ),
                                      SizedBox(width: 10,),
                                      buildEmail(User),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                                                ),
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget noFolders(){
    return Padding(
      padding: const EdgeInsets.only(right: 8,top: 8,bottom: 8),
      child: Container(
        height: 180,
        width: 365,
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
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(    
          padding: const EdgeInsets.all(12.0),  
          child: Center(
            child: Text(
              "You haven't got any folders yet",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
  Widget buildEmail(Type user) {
    return Column(
      children: [
        Text(
          firebaseAuth!.currentUser!.email.toString(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        )
      ],
    );
  }
}