// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:penicillisolver/verifikasiBerhasil.dart';
import 'package:penicillisolver/lupa.dart';

class Verifikasi extends StatelessWidget {
  const Verifikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Mengizinkan navigasi kembali
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Lupa()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 56),
                const Text(
                  'Verifikasi',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset(
                      'assets/notif.gif',
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Kami akan mengirimkan kode untuk verifikasi ke',
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
                  'josh@gmail.com',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) => Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 350,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const Berhasil()),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.blue, // Mengatur warna latar belakang tombol
                      foregroundColor:
                          Colors.white, // Mengatur warna teks tombol
                    ),
                    child: const Text(
                      'Verifikasi',
                      style: TextStyle(
                        color: Color.fromRGBO(252, 252, 252, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
