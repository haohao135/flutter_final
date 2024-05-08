import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_final/UI/MainScreen/main_screen.dart';
import 'package:flutter_application_final/model/archievement.dart';
import 'package:flutter_application_final/model/user.dart';
import 'package:flutter_application_final/model/word.dart';

class Register {
  static Future<void> createAccount(
      String email, String name, String password, BuildContext context) async {
    try {
      // ignore: unused_local_variable
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String id = credential.user!.uid;
      Users user = Users(id: id, email: email, name: name);
      Map<String, dynamic> userJson = user.toJson();
      FirebaseFirestore.instance.collection("users").doc(id).set(userJson);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The password provided is too weak.")));
      } else if (e.code == 'email-already-in-use') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("The account already exists for that email.")));
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  static Future<void> loginAccount(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong password provided for that user.')));
      }
    }
  }

  static Future<Users> getUserById(String id) async {
    final rs =
        await FirebaseFirestore.instance.collection("users").doc(id).get();
    final data = rs.data();
    Users user = Users(id: id, email: data!["email"], name: data["name"]);
    List<dynamic> list1 = data["archievement"] as List<dynamic>;
    List<dynamic> list2 = data["listFavouriteWord"] as List<dynamic>;
    try {
      if (list1.isNotEmpty) {
        List<Map<String, dynamic>> t1 = list1.map((e) => e as Map<String, dynamic>).toList();
        List<Archievement> achieList = t1.map((e) {
          Archievement archievement =
              Archievement(e["id"], e["nameTopic"], e["rank"], id);
          return archievement;
        }).toList();
        user.listArchievement.addAll(achieList);
      }
      if (list2.isNotEmpty) {
          List<Map<String, dynamic>> t2 = list2.map((e) => e as Map<String, dynamic>).toList();
          List<Word> wordList = t2.map((e) {
            Word word = Word(
                id: e["id"],
                term: e["term"],
                definition: e["definition"],
                statusE: e["statusE"],
                isStar: e["isStar"],
                topicId: e["topicId"]);
            return word;
          }).toList();
          user.listFavouriteWord.addAll(wordList);
        }
      return user;
    } catch (e) {
      // ignore: avoid_print
      print("khong lay du lieu dc");
      // ignore: avoid_print
      print(e);
      return user;
    }
  }

  static Future<void> updateUser(Users user) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .update(user.toJson());
    } catch (e) {
      // ignore: avoid_print
      print("khong update dc");
      // ignore: avoid_print
      print(e);
    }
  }
}
