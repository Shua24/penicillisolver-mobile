// ignore_for_file: file_names, use_build_context_synchronously, avoid_unnecessary_containers, unnecessary_const

import 'package:flutter/material.dart';
import 'package:penicillisolver/MainMenu.dart';
import 'package:penicillisolver/setting.dart';

class Polakuman extends StatelessWidget {
  const Polakuman({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Tombol kembali
          Container(
            margin: const EdgeInsets.fromLTRB(0, 45, 0, 0),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
            decoration: const BoxDecoration(
              color: const Color.fromARGB(255, 207, 117, 0),
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
                    // tombol kmebali ke arah Mainmenu
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MainMenu()),
                    );
                  },
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: const Text(
                      'Tentang Pola Kuman',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  // PP
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

          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 207, 117, 0),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Image.asset(
                          'assets/polakuman.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // biar bisa discroll
                      const Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, ore et dolore magna aliqua. Ut enim ad minim  veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea  co`mmodo consequat. Duis aute irure dolor in reprehenderit in voluptate  velit esse cillum dolore eu fugiat nulla pariatur. ore et dolore magna aliqua. Ut enim ad minim  veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea  co`mmodo consequat. Duis aute irure dolor in reprehenderit in voluptate  velit esse cillum dolore eu fugiat nulla pariatur.ore et dolore magna aliqua. Ut enim ad minim  veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea  co`mmodo consequat. Duis aute irure dolor in reprehenderit in voluptate  velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint  occaecat cup Excepteur sint  occaecat cupExcepteur sint  occaecat cup sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // navbar
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 207, 117, 0),
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
                // biar ada efek diteken
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const MainMenu(),
                          ),
                        );
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),

                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {},
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
                            builder: (context) =>
                                const PengaturanPage(), // Navigasi ke LoginScreen
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
          )
        ],
      ),
    );
  }
}
