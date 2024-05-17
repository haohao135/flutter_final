import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/register_account.dart';
import 'package:flutter_application_final/model/topic.dart';
import 'package:flutter_application_final/model/user.dart';

// ignore: must_be_immutable
class TopicRanking extends StatefulWidget {
  TopicRanking({super.key, required this.topic});
  Topic topic;

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

  bool isLoading = false;

  Color getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber; // Gold
      case 2:
        return Colors.grey; // Silver
      case 3:
        return const Color.fromARGB(255, 169, 114, 36); // Bronze
      default:
        return Colors.white;
    }
  }

  List<String> listUserName = [];
  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    setState(() {
      isLoading = true;
    });
    List<String> a = [];
    for (var i in widget.topic.listUserResults) {
      Users user = await Register.getUserById(i.userId);
      a.add(user.name);
    }
    setState(() {
      listUserName = a;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
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
        body: const Center(child: CircularProgressIndicator(),),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  widget.topic.listUserResults.isEmpty ? "" : 'Leaderboard',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (widget.topic.listUserResults.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text(
                      'Không có dữ liệu trong bảng xếp hạng',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.topic.listUserResults.length,
                    itemBuilder: (context, index) {
                      final data = widget.topic.listUserResults[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: getRankColor(index + 1),
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
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      leaderboardData[index]['avatar']),
                                  radius: 30.0,
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${index + 1}. ${listUserName[index]}',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: index + 1 <= 3
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        '${data.correctAnswers} câu trả lời đúng',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: index + 1 <= 3
                                              ? Colors.white70
                                              : Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (index + 1 <= 3)
                                  Icon(
                                    index + 1 == 1
                                        ? Icons.emoji_events
                                        : index + 1 == 2
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
}
