import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/register_account.dart';
import 'package:flutter_application_final/UI/ProfileScreen/ChangeName.dart';
import 'package:flutter_application_final/UI/ProfileScreen/widget/myprofile_widget.dart';
import 'package:flutter_application_final/UI/ProfileScreen/widget/profile_widget.dart';
import 'package:flutter_application_final/UI/ProfileScreen/widget/textfield_widget.dart';
import 'package:flutter_application_final/model/user.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

void navigateToChangePass(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const MyProfilePage()),
  );
}

void navigateToChangeName(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ChangeNamePage()),
  );
}

class _MyProfilePageState extends State<MyProfilePage> {
  String? _imagePath;
  Users? users;
  var cl1 = TextEditingController();
  var cl2 = TextEditingController();

  @override
  void initState() {
    fillData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 163, 45, 206),
          title: const Text(
            "Thông tin cá nhân",
            style: TextStyle(color: Colors.white),
          ),
          leading: const BackButton(color: Colors.white),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          physics: const BouncingScrollPhysics(),
          children: [
            MyProfileWidget(
              imagePath: '$_imagePath',
              isEdit: true,
              onClicked: () async {},
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileWidget(
                  icon: Icons.person,
                  title: 'Tên người dùng',
                  onTap: () => navigateToChangeName(context),
                ),
                TextFieldWidget(
                  control: cl1,
                  text: 'hêlllo',
                  onChanged: (email) {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileWidget(
                  icon: Icons.mail,
                  title: 'Email',
                  onTap: () {},
                ),
                TextFieldWidget(
                  control: cl2,
                  text: '',
                  onChanged: (email) {},
                ),
              ],
            ),
            ProfileWidget(
              icon: Icons.lock,
              title: 'Đổi mật khẩu',
              onTap: () => navigateToChangePass(context),
            ),
          ],
        ),
      );

  Future<void> getUser() async {
    users = await Register.getUserById(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> fillData() async {
    await getUser();
    cl1.text = users!.name;
    cl2.text = users!.email;
  }
}
