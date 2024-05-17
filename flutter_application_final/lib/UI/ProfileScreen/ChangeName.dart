import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangeNamePage extends StatefulWidget {
  @override
  _ChangeNamePageState createState() => _ChangeNamePageState();
}

class _ChangeNamePageState extends State<ChangeNamePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: _auth.currentUser?.displayName ?? ''); // Lấy tên hiện tại của người dùng
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _saveName() async {
    String newName = _nameController.text.trim();
    if (newName.isNotEmpty) {
      try {
        // Cập nhật tên người dùng trên Firebase Authentication
        await _auth.currentUser?.updateDisplayName(newName);

        // Cập nhật tên người dùng trên Firebase Firestore
        await _firestore
            .collection('users')
            .doc(_auth.currentUser?.uid)
            .update({'name': newName});

        // Thông báo thành công và quay về trang trước
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Câp nhật tên thành công!'),
          ),
        );
        Navigator.of(context).pop();
      } catch (e) {
        // Xử lý lỗi nếu có
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Câp nhật tên thất bại!: $e'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 163, 45, 206),
        title: const Text(
          "Tên người dùng",
          style: TextStyle(color: Colors.white),
        ),
        leading: const BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Tên mới',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Center(
              child: ElevatedButton(
                onPressed: _saveName,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 163, 45, 206),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 4.0,
                  animationDuration: const Duration(milliseconds: 300),
                ),
                child: const Text('Lưu'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}