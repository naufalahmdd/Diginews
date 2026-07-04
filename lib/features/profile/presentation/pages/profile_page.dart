import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ===========================================================================
  // 1. DEKLARASI METHOD CHANNEL & STATE VARIABLE
  // ===========================================================================
  static const platform = MethodChannel('com.diginews/nim_reverser');
  
  final String _originalNIM = "A11.2022.12345"; // <-- Ganti dengan NIM aslimu, Fal
  String _reversedNIM = "";
  bool _isLoadingNIM = false;
  
  int _tapCount = 0;
  bool _showLottie = false;

  // ===========================================================================
  // 2. FUNGSI UNTUK MENEMBAK KODE NATIVE KOTLIN
  // ===========================================================================
  Future<void> _processReverseNIM() async {
    setState(() {
      _isLoadingNIM = true;
    });

    try {
      // Mengirim NIM asli ke Kotlin dan menerima hasil balikkannya
      final String result = await platform.invokeMethod('reverseNIM', {'nim': _originalNIM});
      setState(() {
        _reversedNIM = result;
      });
    } on PlatformException catch (e) {
      setState(() {
        _reversedNIM = "Error: ${e.message}";
      });
    } finally {
      setState(() {
        _isLoadingNIM = false;
      });
    }
  }

  // ===========================================================================
  // 3. FUNGSI EASTER EGG LOTTIE (KETUK FOTO PROFIL 3 KALI)
  // ===========================================================================
  void _handleProfileTap() {
    setState(() {
      _tapCount++;
    });

    if (_tapCount >= 3) {
      setState(() {
        _showLottie = true;
        _tapCount = 0; // Reset ketukan
      });

      // Sembunyikan animasi Lottie setelah 3 detik
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showLottie = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ---------------------------------------------------------------
              // SECTION: FOTO PROFIL + INTERAKSI LOTTIE
              // ---------------------------------------------------------------
              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: _handleProfileTap,
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blueAccent,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (_showLottie)
                    IgnorePointer(
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Lottie.asset(
                          'assets/secret_animation.json',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Ketuk foto 3x untuk memicu Easter Egg',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // ---------------------------------------------------------------
              // SECTION: DATA MAHASISWA & FITUR KOTLIN METHOD CHANNEL
              // ---------------------------------------------------------------
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(Icons.badge, color: Colors.blue),
                        title: Text('Nama Lengkap'),
                        subtitle: Text('Naufal'),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.pin, color: Colors.blue),
                        title: const Text('NIM Asli'),
                        subtitle: Text(_originalNIM),
                      ),
                      if (_reversedNIM.isNotEmpty) ...[
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.loop, color: Colors.orange),
                          title: const Text('NIM Terbalik (Native Kotlin Result)'),
                          subtitle: Text(
                            _reversedNIM,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ---------------------------------------------------------------
              // SECTION: TOMBOL AKSI UNTUK MENEMBAK METHOD CHANNEL
              // ---------------------------------------------------------------
              ElevatedButton.icon(
                onPressed: _isLoadingNIM ? null : _processReverseNIM,
                icon: _isLoadingNIM 
                    ? const SizedBox(
                        width: 20, 
                        height: 20, 
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
                      )
                    : const Icon(Icons.bolt),
                label: Text(_isLoadingNIM ? 'Memproses di Kotlin...' : 'Balikkan NIM via Native Kotlin'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}