import 'package:flutter/material.dart';

void main() {
  runApp(const Selamat());
}

class Selamat extends StatelessWidget {
  const Selamat({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan, // Warna biru muda di appbar
        elevation: 0, // Hilangkan bayangan
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Aksi kembali
          },
        ),
        title: const Text("Menu"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              // Ganti dengan gambar profile dari assets atau URL
              backgroundImage: AssetImage('assets/profile.png'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // Menempatkan menu di tengah secara vertikal
          children: [
            const Center(  // Pastikan Text ada di dalam Center widget
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Berikut Menu Mencari Antibiotik",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,  // Tambahkan textAlign
                ),
              ),
            ),
            const SizedBox(height: 20), // Jarak antara judul dan menu
            Row(
              mainAxisAlignment: MainAxisAlignment.center,  // Menempatkan item di tengah secara horizontal
              children: [
                _buildMenuButton(Icons.search, "Cari berdasarkan penyakit"),
                const SizedBox(width: 20), // Menambah jarak antara dua tombol
                _buildMenuButton(Icons.bug_report, "Cari berdasarkan bakteri"),
              ],
            ),
            const SizedBox(height: 20),
            _buildMenuButton(Icons.refresh, "Tentang Pola Kuman", isWide: true),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "",
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(IconData icon, String label, {bool isWide = false}) {
    return Container(
      width: isWide ? 200 : 120, // Lebih lebar jika diperlukan
      height: 120,
      decoration: BoxDecoration(
        color: Colors.cyan[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: Colors.cyan),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
