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
  // Dummy list of tips, replace it with your actual list of tips
  List<String> tips = [
    'Practice speaking every day to improve your fluency',
    'Read English books or articles to expand your vocabulary',
    'Tip 3',
    'Tip 4',
    'Tip 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 221, 239),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        title: const Text(
          "App Name",
          style: TextStyle(color: Colors.white),
        ), 
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 2.0 ), // Set the preferred height of the widget
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
              const Text(
                "Topics",
                style: TextStyle(             
                  color: Colors.black,
                  fontSize: 25,
                ),
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
                        width: 370, 
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                          color: Colors.white
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