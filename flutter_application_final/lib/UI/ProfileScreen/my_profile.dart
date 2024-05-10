
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/FireBase/register_account.dart';
import 'package:flutter_application_final/UI/ProfileScreen/appbar_widget.dart';
import 'package:flutter_application_final/UI/ProfileScreen/button_widget.dart';
import 'package:flutter_application_final/UI/ProfileScreen/myprofile_widget.dart';
import 'package:flutter_application_final/UI/ProfileScreen/textfield_widget.dart';
import 'package:flutter_application_final/model/user.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyProfilePageState createState() => _MyProfilePageState();
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
        appBar: buildAppBar(context),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          physics: const BouncingScrollPhysics(),
          children: [
            MyProfileWidget(
              imagePath: '$_imagePath',
              isEdit: true,
              onClicked: () async {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              control: cl1,
              label: 'Name',
              text: '',
              onChanged: (name) {},
            ),
            const SizedBox(height: 24),
            TextFieldWidget(
              control: cl2,
              label: 'Email',
              text: '',
              onChanged: (email) {},
            ),
            const SizedBox(height: 24),
            ButtonWidget(
              text: 'Save',
              onClicked: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
  Future<void> getUser() async{
    users = await Register.getUserById(FirebaseAuth.instance.currentUser!.uid);
  }
  Future<void> fillData()async{
    await getUser();
    cl1.text = users!.name;
    cl2.text = users!.email;
  }
}
