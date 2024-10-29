// ignore_for_file: deprecated_member_use, use_build_context_synchronously, unused_element

import 'package:flutter/material.dart';
import 'package:penicillisolver/MainMenu.dart';
import 'package:penicillisolver/lupa.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:math';

class Verifikasi extends StatefulWidget {
  const Verifikasi({super.key});

  @override
  State<Verifikasi> createState() => _VerifikasiState();
}

class _VerifikasiState extends State<Verifikasi> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(
    4,
    (index) => FocusNode(),
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String generatedOTP = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  String _generateOTP() {
    final random = Random();
    String otp = '';
    for (var i = 0; i < 4; i++) {
      otp += random.nextInt(10).toString();
    }
    return otp;
  }

  Future<void> _initializeNotifications() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) {
          // Notification tap handling can be implemented here if needed
        },
      );

      generatedOTP = _generateOTP();
      await _showOtpNotification(generatedOTP);
    } catch (e) {
      _showErrorSnackBar('Gagal menginisialisasi notifikasi');
    }
  }

  Future<void> _showOtpNotification(String otp) async {
    try {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'otp_channel',
        'OTP Notifications',
        channelDescription: 'Channel for OTP notifications',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await flutterLocalNotificationsPlugin.show(
        0,
        'Kode OTP',
        'Kode verifikasi Anda: $otp',
        platformChannelSpecifics,
      );
    } catch (e) {
      _showErrorSnackBar('Gagal mengirim notifikasi OTP');
    }
  }

  bool _validateOTP() {
    String enteredOTP =
        _controllers.map((controller) => controller.text).join();
    return enteredOTP == generatedOTP;
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleVerification() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      if (_validateOTP()) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Verifikasi berhasil!'),
              backgroundColor: Colors.green,
            ),
          );
        }

        await Future.delayed(const Duration(milliseconds: 1500));
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainMenu()),
          );
        }
      } else {
        // Reset semua input field
        for (var controller in _controllers) {
          controller.clear();
        }
        // Set focus ke field pertama
        if (mounted) {
          FocusScope.of(context).requestFocus(_focusNodes[0]);
        }
        _showErrorSnackBar('Kode OTP tidak valid!');
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _resendOTP() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      generatedOTP = _generateOTP();
      await _showOtpNotification(generatedOTP);

      // Reset semua input field
      for (var controller in _controllers) {
        controller.clear();
      }

      if (mounted) {
        // Set focus ke field pertama
        FocusScope.of(context).requestFocus(_focusNodes[0]);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kode OTP baru telah dikirim'),
            backgroundColor: Colors.blue,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Kami akan mengirimkan kode untuk verifikasi ke :',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
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
                    (index) => SizedBox(
                      width: 70,
                      height: 70,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        enabled: !isLoading,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            if (index < _controllers.length - 1) {
                              FocusScope.of(context)
                                  .requestFocus(_focusNodes[index + 1]);
                            }
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context)
                                .requestFocus(_focusNodes[index - 1]);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 350,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _handleVerification,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Verifikasi',
                            style: TextStyle(
                              color: Color.fromRGBO(252, 252, 252, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                  ),
                ),
                TextButton(
                  onPressed: isLoading ? null : _resendOTP,
                  child: const Text(
                    'Kirim Ulang Kode',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
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
