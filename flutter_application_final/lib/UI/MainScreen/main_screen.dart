import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/HomeScreen/home.dart';
import 'package:flutter_application_final/UI/LibraryScreen/library.dart';
import 'package:flutter_application_final/UI/ProfileScreen/profile.dart';
import 'package:flutter_application_final/UI/SolutionScreen/solution.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currenTab = 0;
  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currenScreen = const Home();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: pageStorageBucket,
        child: currenScreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context1) {
                return Wrap(
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 163, 45, 206)
                          .withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(22.0),
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.pop(context1);
                                setState(() {
                                  currenScreen = LibraryPage(pos: 0,);
                                  currenTab = 2;
                                });
                              },
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              tileColor:
                                  const Color.fromARGB(255, 163, 45, 206),
                              leading: const Icon(
                                Icons.folder_outlined,
                                color: Colors.white,
                              ),
                              title: const Text(
                                "Thư mục",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pop(context1);
                                setState(() {
                                  currenScreen = LibraryPage(pos: 1,);
                                  currenTab = 2;
                                });
                              },
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              tileColor:
                                  const Color.fromARGB(255, 163, 45, 206),
                              leading: const Icon(
                                Icons.topic_outlined,
                                color: Colors.white,
                              ),
                              title: const Text(
                                "Chủ đề",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.pop(context1);
                                setState(() {
                                  currenScreen = LibraryPage(pos: 2,);
                                  currenTab = 2;
                                });
                              },
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              tileColor:
                                  const Color.fromARGB(255, 163, 45, 206),
                              leading: const Icon(
                                Icons.people_outline,
                                color: Colors.white,
                              ),
                              title: const Text(
                                "Lớp",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              });
        },
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 163, 45, 206),
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currenScreen = const Home();
                      currenTab = 0;
                    });
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: currenTab == 0 ? Colors.amber : Colors.white,
                          size: 25,
                        ),
                        Text(
                          "Trang chủ",
                          style: TextStyle(
                              color:
                                  currenTab == 0 ? Colors.amber : Colors.white,
                              fontSize: 13),
                        )
                      ]),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currenScreen = const SolutionPage();
                      currenTab = 1;
                    });
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.book,
                          color: currenTab == 1 ? Colors.amber : Colors.white,
                          size: 25,
                        ),
                        Text(
                          "Lời giải",
                          style: TextStyle(
                              color:
                                  currenTab == 1 ? Colors.amber : Colors.white,
                              fontSize: 13),
                        )
                      ]),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currenScreen = LibraryPage();
                      currenTab = 2;
                    });
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.library_books,
                          color: currenTab == 2 ? Colors.amber : Colors.white,
                          size: 25,
                        ),
                        Text(
                          "Thư viện",
                          style: TextStyle(
                              color:
                                  currenTab == 2 ? Colors.amber : Colors.white,
                              fontSize: 13),
                        )
                      ]),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    setState(() {
                      currenScreen = const ProfilePage();
                      currenTab = 3;
                    });
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currenTab == 3 ? Colors.amber : Colors.white,
                          size: 25,
                        ),
                        Text(
                          "Cá nhân",
                          style: TextStyle(
                              color:
                                  currenTab == 3 ? Colors.amber : Colors.white,
                              fontSize: 13),
                        )
                      ]),
                ),
              ],
            ),
          ])),
    );
  }
}
