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
    Archievement('1', 'Finishing a Book', 1, 'user1'),
    Archievement('2', 'Adding a Book', 2, 'user2'),
    Archievement('3', 'Giving a Review', 3, 'user3'),
    Archievement('4', 'First Reader', 4, 'user4'),
    Archievement('5', 'Pages Read', 5, 'user5'),
    Archievement('6', 'Star Rating', 6, 'user6'),
    Archievement('7', 'Finishing influence list', 7, 'user7'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        title: const Text(
          "Achievements",
          style: TextStyle(color: Colors.white),
        ),
        leading: const BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                ),
                itemCount: _achievements.length,
                itemBuilder: (context, index) {
                  final achievement = _achievements[index];
                  return AchievementItem(achievement: achievement);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AchievementItem extends StatelessWidget {
  final Archievement achievement;

  const AchievementItem({Key? key, required this.achievement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              achievement.nameTopic,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            Icon(
              Icons.check_circle,
              color: const Color.fromARGB(255, 163, 45, 206),
              size: 48.0,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Rank: ${achievement.rank}',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}