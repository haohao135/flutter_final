import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_final/model/archievement.dart';

class AchievementPage extends StatefulWidget {
  @override
  _AchievementPageState createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  List<Archievement> _achievements = [
    Archievement('1', 'Flutter Mastery', 1, 'user1'),
    Archievement('2', 'Dart Expert', 2, 'user2'),
    Archievement('3', 'UI/UX Design', 3, 'user3'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 163, 45, 206),
          title: const Text(
            "Thành tựu",
            style: TextStyle(color: Colors.white),
          ),
          leading: const BackButton(color: Colors.white),
        ),
      body: ListView.builder(
        itemCount: _achievements.length,
        itemBuilder: (context, index) {
          final achievement = _achievements[index];
          return ListTile(
            title: Text(achievement.nameTopic),
            subtitle: Text('Rank: ${achievement.rank}'),
          );
        },
      ),
    );
  }
}