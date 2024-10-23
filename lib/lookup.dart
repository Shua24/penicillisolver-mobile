import 'package:flutter/material.dart';
import 'package:penicillisolver/MainMenu.dart';
import 'package:penicillisolver/setting.dart';
import 'theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: const MainMenu(),
    );
  }
}

class AntibioticQuery extends StatelessWidget {
  const AntibioticQuery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 155, 226),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 35,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainMenu()),
                      );
                    },
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: const Text(
                        'Cari Antibiotik',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color.fromARGB(0, 255, 255, 255),
                    child: Icon(Icons.person,
                        size: 40, color: Color.fromARGB(0, 255, 255, 255)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            const Text('Cari antibiotik berdasarkan Penyakit'),
            const SizedBox(height: 20),
            const SizedBox(
              width: 400,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Pastikan penyakit ada pada tabel bakteri',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => const AlertDialog(
                    title: Text('Antibiotik terbaik'),
                    content: Column(
                      mainAxisSize: MainAxisSize
                          .min, // To make the column wrap its content
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align items to the left
                      children: [
                        Text('Item 1'),
                        SizedBox(height: 8), // Add space between items
                        Text('Item 2'),
                        SizedBox(height: 8),
                        Text('Item 3'),
                        SizedBox(height: 8),
                        Text('Item 4'),
                        // Add more plain text items as needed
                      ],
                    ),
                  ),
                );
              },
              child: const Text('Cari'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 155, 226),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(1, 1),
            ),
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Tombol Home dengan efek ripple
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainMenu(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
            // Tombol Assignment dengan efek ripple
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AntibioticQuery(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.assignment_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Tombol Settings dengan efek ripple
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 0), () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PengaturanPage(),
                      ),
                    );
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.settings_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
