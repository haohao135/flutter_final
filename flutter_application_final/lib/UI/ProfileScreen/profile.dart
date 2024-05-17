import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/LoginScreen/login.dart';
import 'package:flutter_application_final/UI/ProfileScreen/achive.dart';
import 'package:flutter_application_final/UI/ProfileScreen/widget/constants.dart';
import 'package:flutter_application_final/UI/ProfileScreen/my_profile.dart';
import 'package:flutter_application_final/UI/ProfileScreen/widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

void handleLogout(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );
}

void navigateToMyProfile(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const MyProfilePage()),
  );
}

void navigateToAchievement(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AchievementPage()),
  );
}

class _ProfilePageState extends State<ProfilePage> {
  String? _name;
  String? _email;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        _name = snapshot['name'];
        _email = snapshot['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        title: const Text(
          "Hồ sơ",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Constants.primaryColor.withOpacity(.5),
                    width: 5.0,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: ExactAssetImage('assets/images/typing.png'),
                ),
              ),
              const SizedBox(height: 24),
              buildName(User),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: size.height * .7,
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileWidget(
                      icon: Icons.person,
                      title: 'Thông tin',
                      onTap: () => navigateToMyProfile(context),
                    ),
                    ProfileWidget(
                      icon: Icons.notifications,
                      title: 'Thành tựu',
                      onTap: () => navigateToAchievement(context),
                    ),
                    ProfileWidget(
                      icon: Icons.logout,
                      title: 'Đăng xuất',
                      onTap: () => handleLogout(
                          context), // Gọi hàm handleLogout khi người dùng nhấn vào nút Log Out
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(Type user) => Column(
        children: [
          Text(
            '$_name',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            '$_email',
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );
}
