import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/register_account.dart';
import 'package:flutter_application_final/model/user.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FavoriteWord extends StatefulWidget {
  const FavoriteWord({super.key});

  @override
  State<FavoriteWord> createState() => _FavoriteWordState();
}

class _FavoriteWordState extends State<FavoriteWord> {
  Users? users;
  bool isLoading = false;
  FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((querySnapshot) {
          
      getUser(FirebaseAuth.instance.currentUser!.uid);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 221, 239),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        title: const Text(
          "Từ vựng yêu thích",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: users == null ? const Center(
              child: CircularProgressIndicator(),
            ) :  isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : users!.listFavouriteWord.isEmpty
              ? const Center(
                  child: Text("Chưa có từ yêu thích"),
                )
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: users!.listFavouriteWord.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: (){
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)),
                                content: const Text(
                                  "Xác nhận xóa từ vựng?",
                                  style: TextStyle(fontSize: 20),
                                ),
                                contentPadding: const EdgeInsets.all(30),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Hủy")),
                                  TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          users!.listFavouriteWord.remove(
                                              users!.listFavouriteWord[index]);
                                        });
                                        await Register.updateUser(
                                            users!);
                                      },
                                      child: const Text("Đồng ý")),
                                ],
                              ),
                            );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.all(6),
                          height: 95,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(users!.listFavouriteWord[index].term, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                  IconButton(
                                      onPressed: () {
                                        speak(
                                            users!.listFavouriteWord[index].term);
                                      },
                                      icon: const Icon(Icons.volume_down))
                                ],
                              ),
                              Text(users!.listFavouriteWord[index].definition, style: const TextStyle(fontSize: 18)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
    );
  }

  Future<void> getUser(String id) async {
    setState(() {
      isLoading = true;
    });
    users = await Register.getUserById(id);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> updateUser(Users user) async {
    await Register.updateUser(user);
  }

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }
}
