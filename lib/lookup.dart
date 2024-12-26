// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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

class AntibioticQuery extends StatefulWidget {
  const AntibioticQuery({super.key});

  @override
  _AntibioticQueryState createState() => _AntibioticQueryState();
}

class _AntibioticQueryState extends State<AntibioticQuery> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEnv();
  }

  Future<void> _loadEnv() async {
    try {
      await dotenv.load();
      print("Environment variables loaded");
    } catch (e) {
      print("Error loading .env file: $e");
    }
  }

  List<String> _results = [];

  Future<void> _fetchData() async {
    final query = _textController.text.trim();
    final apiUrl = '${dotenv.env['FLUTTER_API_URL']}/top-values?column=$query';
    if (query.isEmpty) {
      _showDialog('Error', 'Please enter a valid input.');
      return;
    }

    final url = Uri.parse(apiUrl);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<dynamic> antibiotics = data['tiga_antibiotik'];

        setState(() {
          _results = antibiotics.map((antibiotic) {
            final organism = antibiotic['Organism'];
            final percentage = antibiotic[query] ?? 'Unknown';
            return '$organism: $percentage%';
          }).toList();
        });

        _showResultsDialog();
      } else if (response.statusCode == 400) {
        _showDialog(
          'Tidak ditemukan',
          'Bakteri tidak ditemukan. Sesuaikan nama bakteri dengan pola kuman.',
        );
      } else {
        _showDialog(
          'Error',
          'Tidak dapat mengambil data. Rincian: ${response.statusCode}, ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      _showDialog('Error', 'An error occurred: $e');
    }
  }

  void _showDialog(String title, String content) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showResultsDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Antibiotik terbaik'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _results.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(item),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainMenu(),
                        ),
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
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    child:
                        Icon(Icons.person, size: 40, color: Colors.transparent),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
            const Text(
              'Cari antibiotik berdasarkan Penyakit',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 350,
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  labelText: 'Masukkan bakteri',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text(
                'Cari',
                style: TextStyle(fontSize: 17),
              ),
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
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PengaturanPage(),
                    ),
                  );
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
