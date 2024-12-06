import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Avatar
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/avatar_placeholder.png'),
                // Ganti dengan path gambar default
              ),
              const SizedBox(height: 20),
              
              // User name
              const Text(
                'John Doe',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              
              // Email
              const Text(
                'john.doe@example.com',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              
              // Edit Profile Button
              ElevatedButton.icon(
                onPressed: () {
                  // Tambahkan logika untuk navigasi ke halaman edit profile
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit Profile is not implemented yet!')),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
              ),
              
              const SizedBox(height: 30),
              
              // Section for other user-related options
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  // Tambahkan navigasi ke halaman settings jika diperlukan
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings is not implemented yet!')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_outline),
                title: const Text('Help & Support'),
                onTap: () {
                  // Tambahkan navigasi ke halaman help jika diperlukan
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Help & Support is not implemented yet!')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
