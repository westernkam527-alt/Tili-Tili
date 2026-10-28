
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 55),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tili Tili User',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text('@your_username'),
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('0', style: TextStyle(fontSize: 20)),
                    Text('Posts'),
                  ],
                ),
                Column(
                  children: [
                    Text('0', style: TextStyle(fontSize: 20)),
                    Text('Followers'),
                  ],
                ),
                Column(
                  children: [
                    Text('0', style: TextStyle(fontSize: 20)),
                    Text('Following'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile editing coming soon'),
                  ),
                );
              },
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
