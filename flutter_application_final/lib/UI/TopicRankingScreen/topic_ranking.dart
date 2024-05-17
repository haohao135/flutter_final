import 'package:flutter/material.dart';
import 'package:flutter_application_final/model/topic.dart';

class TopicRanking extends StatefulWidget {
  TopicRanking({super.key, required this.topic});
  final Topic topic;

  @override
  State<TopicRanking> createState() => _TopicRankingState();
}

class _TopicRankingState extends State<TopicRanking> {
  // Sample data for the leaderboard
  List<Map<String, dynamic>> leaderboardData = [
    {
      'name': 'John Doe',
      'points': 1000,
      'rank': 1,
      'avatar': 'assets/images/user1.png'
    },
    {
      'name': 'Jane Smith',
      'points': 950,
      'rank': 2,
      'avatar': 'assets/images/user2.png'
    },
    {
      'name': 'Bob Johnson',
      'points': 900,
      'rank': 3,
      'avatar': 'assets/images/user3.png'
    },
    {
      'name': 'Alice Williams',
      'points': 850,
      'rank': 4,
      'avatar': 'assets/images/user4.png'
    },
    {
      'name': 'Tom Davis',
      'points': 800,
      'rank': 5,
      'avatar': 'assets/images/user5.png'
    },
  ];

  Color getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber; // Gold
      case 2:
        return Colors.grey; // Silver
      case 3:
        return Color.fromARGB(255, 169, 114, 36); // Bronze
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Topic Ranking',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Leaderboard',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: leaderboardData.length,
                itemBuilder: (context, index) {
                  final data = leaderboardData[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: getRankColor(data['rank']),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.7,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage(data['avatar']),
                              radius: 30.0,
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${data['rank']}. ${data['name']}',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: data['rank'] <= 3 ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    '${data['points']} points',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: data['rank'] <= 3 ? Colors.white70 : Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (data['rank'] <= 3)
                              Icon(
                                data['rank'] == 1
                                    ? Icons.emoji_events
                                    : data['rank'] == 2
                                        ? Icons.workspace_premium_outlined
                                        : Icons.workspace_premium_outlined,
                                color: Colors.white,
                                size: 30.0,
                              ),
                          ],
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
    );
  }
}