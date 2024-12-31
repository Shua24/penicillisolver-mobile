import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:penicillisolver/camera_page.dart';
import 'package:penicillisolver/setting.dart';
import 'package:penicillisolver/theme.dart';
import 'database_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

File? selectedImage;
String? base64Image;

class PengaturanAkun extends StatelessWidget {
  const PengaturanAkun({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: const AccountSettingsPage(),
    );
  }
}

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: SafeArea(
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 0, 155, 226),
            flexibleSpace: const Padding(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Akun dan Keamanan",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PengaturanPage()),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListTile(
              title: "Profil Saya",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditProfilPage()),
                );
              },
            ),
            const Divider(),
            _buildDetailTile(
                title: "Email", detail: "joshua123@gmail.com", onTap: () {}),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
      {required String title, Widget? trailing, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildDetailTile(
      {required String title,
      required String detail,
      required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      subtitle: Text(detail),
      onTap: onTap,
    );
  }
}

class EditProfilPage extends StatefulWidget {
  const EditProfilPage({super.key});

  @override
  EditProfilPageState createState() => EditProfilPageState();
}

class EditProfilPageState extends State<EditProfilPage> {
  String _gender = "Pria";
  DateTime _selectedDate = DateTime.now();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfileData();
    _loadProfilePicture();
  }

  Future<void> _loadProfilePicture() async {
    final dbHelper = DatabaseHelper();
    final photoPath = await dbHelper.getProfilePicture();
    if (!mounted) return;
    setState(() {
      if (photoPath != null) {
        selectedImage = File(photoPath);
      }
    });
  }

  Future<void> _loadProfileData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("Pengguna tidak login.");
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      if (userDoc.exists) {
        final data = userDoc.data();
        if (data != null) {
          setState(() {
            _nameController.text = data['nama'] ?? '';
            _gender = data['gender'] ?? 'Pria';
            _selectedDate = data['birthdate'] != null
                ? DateTime.parse(data['birthdate'])
                : DateTime.now();
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat data: $e')),
      );
    }
  }

  Future<void> _saveToFirestore() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("Pengguna tidak login.");
      }

      final userId = currentUser.uid;
      final userData = {
        'nama': _nameController.text,
        'gender': _gender,
        'birthdate': _selectedDate.toIso8601String(),
        'profilePicture': selectedImage?.path,
      };

      await FirebaseFirestore.instance.collection('users').doc(userId).set(
            userData,
            SetOptions(merge: true),
          );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil diperbarui.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data: $e')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (!mounted) return; // Tambahkan pengecekan mounted
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _onImageCaptured(File image) {
    setState(() {
      selectedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: SafeArea(
          child: AppBar(
            backgroundColor: const Color.fromARGB(255, 0, 155, 226),
            flexibleSpace: const Padding(
              padding: EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Ubah Profil",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AccountSettingsPage()),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CameraPage(
                        onImageCaptured: _onImageCaptured,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 2.0),
                  ),
                  child: ClipOval(
                    child: selectedImage == null
                        ? Image.asset(
                            "assets/jawinpp.png",
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                          )
                        : Image.file(selectedImage!),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _gender,
              decoration: const InputDecoration(labelText: "Jenis Kelamin"),
              items: ["Pria", "Wanita"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _gender = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              readOnly: true,
              controller: TextEditingController(
                text: DateFormat('dd/MM/yyyy').format(_selectedDate),
              ),
              decoration: const InputDecoration(
                labelText: "Tanggal Lahir",
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () {
                _selectDate(context);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _saveToFirestore();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Simpan Perubahan',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
