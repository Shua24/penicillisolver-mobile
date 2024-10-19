import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // untuk tanggal
import 'package:google_fonts/google_fonts.dart'; // untuk font Poppins

class PengaturanAkun extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(), // font Poppins untuk semua teks
      ),
      home: AccountSettingsPage(),
    );
  }
}

class AccountSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Warna background AppBar biru
        title: Text("Akun dan Keamanan", style: TextStyle(color: Colors.white)),
        centerTitle: true, // Memposisikan teks di tengah
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Ikon kembali warna putih
          onPressed: () {
            Navigator.pop(context); // untuk kembali ke halaman sebelumnya
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildListTile(
              title: "Profil Saya",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilPage()),
                );
              },
            ),
            Divider(),
            _buildDetailTile(
              title: "Username",
              detail: "joshua",
              onTap: () {},
            ),
            Divider(),
            _buildDetailTile(
              title: "No. Handphone",
              detail: "+62 1234567890",
              onTap: () {},
            ),
            Divider(),
            _buildDetailTile(
              title: "Email",
              detail: "joshua123@gmail.com",
              onTap: () {},
            ),
            Divider(),
            _buildListTile(
              title: "Akun Media Sosial",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SocialMediaPage()),
                );
              },
            ),
            Divider(),
            _buildListTile(
              title: "Verifikasi Sidik Jari",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VerifikasiSidikJari()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({required String title, Widget? trailing, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      trailing: trailing ?? Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildDetailTile({required String title, required String detail, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      subtitle: Text(detail),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

// Halaman Ubah Profil
class EditProfilPage extends StatefulWidget {
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
                    fit: BoxFit.cover, // Buat gambar memenuhi container secara proporsional
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextFormField(
              controller: _bioController,
              decoration: InputDecoration(labelText: "Bio"),
            ),
            DropdownButtonFormField<String>(
              value: _gender,
              decoration: InputDecoration(labelText: "Jenis Kelamin"),
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
            ListTile(
              title: Text("Tanggal Lahir: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}"),
              trailing: Icon(Icons.calendar_today),
              onTap: () {
                _selectDate(context);
              },
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: "Nomor Handphone"),
              keyboardType: TextInputType.phone,
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VerifikasiKeamananPage()),
                );
              },
              child: Text("Lanjut"),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Verifikasi Keamanan
class VerifikasiKeamananPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pemeriksaan Keamanan"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Untuk keamanan akun, mohon verifikasi identitas kamu dengan salah satu cara di bawah ini.",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.message, color: Colors.blue),
              title: Text("Verifikasi dengan OTP SMS"),
              onTap: () {
                // untuk verifikasi dengan OTP
              },
            ),
            ListTile(
              leading: Icon(Icons.lock, color: Colors.blue),
              title: Text("Verifikasi dengan PIN Aplikasi"),
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

// Halaman Akun Media Sosial
class SocialMediaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hubungkan Akun Media Sosial"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.facebook, color: Colors.blue),
            title: Text("Hubungkan Akun Facebook"),
            trailing: Text("Pisahkan", style: TextStyle(color: Colors.red)),
            onTap: () {
              // untuk menghubungkan atau memisahkan akun Facebook
            },
          ),
          ListTile(
            leading: Icon(Icons.camera_alt, color: Colors.purple),
            title: Text("Hubungkan Akun Instagram"),
            trailing: Text("Pisahkan", style: TextStyle(color: Colors.red)),
            onTap: () {
              // untuk menghubungkan atau memisahkan akun Instagram
            },
          ),
          ListTile(
            leading: Icon(Icons.mail, color: Colors.red),
            title: Text("Hubungkan Akun Google"),
            trailing: Text("Pisahkan", style: TextStyle(color: Colors.red)),
            onTap: () {
              // untuk menghubungkan atau memisahkan akun Google
            },
          ),
        ],
      ),
    );
  }
}

// Halaman Verifikasi Sidik Jari
class VerifikasiSidikJari extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verifikasi Sidik Jari"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Izinkan Biometrik"),
                  content: Text(
                      "Untuk mengubah verifikasi biometrik, kami perlu memerlukan izinmu terlebih dahulu. Pindai sidik jari."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Jika dibatalkan
                      },
                      child: Text("Batal"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // untuk memverifikasi sidik jari
                      },
                      child: Text("Pindai Sidik Jari"),
                    ),
                  ],
                );
              },
            );
          },
          child: Text("Verifikasi Sidik Jari"),
        ),
      ),
    );
  }
}