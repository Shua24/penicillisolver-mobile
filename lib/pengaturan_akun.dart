import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:penicillisolver/camera_page.dart';
import 'package:penicillisolver/setting.dart';
import 'package:penicillisolver/theme.dart';
import 'database_helper.dart';

File? selectedImage;

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
            _buildDetailTile(title: "Username", detail: "joshua", onTap: () {}),
            const Divider(),
            _buildDetailTile(
                title: "No. Handphone", detail: "+62 1234567890", onTap: () {}),
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
  final _bioController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    _loadProfilePicture();
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
            TextFormField(
              controller: _bioController,
              decoration: const InputDecoration(labelText: "Bio"),
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
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: "Nomor Handphone"),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
            onPressed: () {
                final navigator = Navigator.of(context); // Simpan BuildContext
                Future.delayed(const Duration(milliseconds: 500), () {
                  if (!mounted) return; // Validasi widget masih aktif
                  navigator.pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const EditProfilPage(),
                    ),
                  );
                });
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