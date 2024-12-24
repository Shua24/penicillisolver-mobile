// ignore_for_file: file_names, use_build_context_synchronously, library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:penicillisolver/lookup.dart';
import 'package:penicillisolver/setting.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 155, 226),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 48),
                      const Text(
                        'Menu',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ClipOval(
                        child: Image.asset(
                          'assets/user1.png',
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 300,
                              child: Image.asset(
                                'assets/polakuman.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              'Pola kuman mengacu pada jenis dan distribusi mikroorganisme, terutama bakteri,'
                              'di lingkungan atau tubuh manusia. Analisis ini membantu tenaga medis'
                              'mengidentifikasi penyebab infeksi dan menentukan terapi yang tepat,'
                              'dengan mempertimbangkan lokasi dan penggunaan antibiotik. Penicillisolver'
                              ' memudahkan dokter dalam mencari pola kuman, sehingga dapat mencegah infeksi'
                              ' dan mengurangi risiko bakteri resisten untuk meningkatkan kesehatan masyarakat.'
                              'Pola kuman mengacu pada jenis dan distribusi mikroorganisme, terutama bakteri,'
                              'di lingkungan atau tubuh manusia. Analisis ini membantu tenaga medis'
                              'mengidentifikasi penyebab infeksi dan menentukan terapi yang tepat,'
                              'dengan mempertimbangkan lokasi dan penggunaan antibiotik. Penicillisolver'
                              ' memudahkan dokter dalam mencari pola kuman, sehingga dapat mencegah infeksi'
                              ' dan mengurangi risiko bakteri resisten untuk meningkatkan kesehatan masyarakat.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 70),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  width: 700, // Sesuaikan lebar container
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 20,
                        color: Color.fromARGB(255, 0, 174, 255),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Gunakan Web untuk membuka semua fitur',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
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
