import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 12),
            child: ListTile(
              leading: const Icon(Icons.newspaper, size: 40),
              title: Text('Judul Berita Dummy ${index + 1}'),
              subtitle: const Text('Ini adalah deskripsi singkat berita utama hari ini...'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Nanti ditambahkan navigasi detail
              },
            ),
          );
        },
      ),
    );
  }
}