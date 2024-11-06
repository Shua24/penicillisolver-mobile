import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:penicillisolver/setting.dart';
import 'package:penicillisolver/theme.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Akun dan Keamanan",
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Ikon kembali warna putih
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PengaturanPage(),
              ),
            ); // untuk kembali ke halaman sebelumnya
          },
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
              title: "Username",
              detail: "joshua",
              onTap: () {},
            ),
            const Divider(),
            _buildDetailTile(
              title: "No. Handphone",
              detail: "+62 1234567890",
              onTap: () {},
            ),
            const Divider(),
            _buildDetailTile(
              title: "Email",
              detail: "joshua123@gmail.com",
              onTap: () {},
            ),
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

// Halaman Ubah Profil
class EditProfilPage extends StatefulWidget {
  const EditProfilPage({super.key});

  @override
  _EditProfilPageState createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  String _gender = "Pria"; //  jenis kelamin
  DateTime _selectedDate = DateTime.now();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Warna background AppBar biru
        title: const Text(
          "Ubah Profil",
          style: TextStyle(color: Colors.white), // Warna teks putih
        ),
        centerTitle: true, // Menempatkan teks di tengah
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // ikon kembali warna putih
          ),
          onPressed: () {
            Navigator.pop(context); //  untuk kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Container(
                width: 120, // Atur lebar container yang lebih presisi
                height: 120, // Atur tinggi container agar proporsional
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue, // Warna border untuk menonjolkan gambar
                    width: 2.0, // Ketebalan border
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    "assets/profile.png", // Gambar profil
                    fit: BoxFit
                        .cover, // Buat gambar memenuhi container secara proporsional
                    width: 120,
                    height: 120,
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
            ListTile(
              title: Text(
                  "Tanggal Lahir: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}"),
              trailing: const Icon(Icons.calendar_today),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VerifikasiKeamananPage()),
                );
              },
              child: const Text("Lanjut"),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Verifikasi Keamanan
class VerifikasiKeamananPage extends StatelessWidget {
  const VerifikasiKeamananPage({super.key}); // Menambahkan key ke constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pemeriksaan Keamanan"),
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Untuk keamanan akun, mohon verifikasi identitas kamu dengan salah satu cara di bawah ini.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.message, color: Colors.blue),
              title: const Text("Verifikasi dengan OTP SMS"),
              onTap: () {
                // untuk verifikasi dengan OTP
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.blue),
              title: const Text("Verifikasi dengan PIN Aplikasi"),
              onTap: () {
                // untuk verifikasi dengan PIN
              },
            ),
          ],
        ),
      ),
    );
  }
}
