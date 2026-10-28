
import 'package:flutter/material.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() =>
      _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController postController =
      TextEditingController();

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  void publishPost() {
    if (postController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please write something first!'),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Demo post submitted!'),
      ),
    );

    postController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Share your thoughts',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: postController,
              maxLines: 5,
              maxLength: 1000,
              decoration: const InputDecoration(
                hintText: 'What is on your mind?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Gallery feature will be added next.',
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.photo_library),
              label: const Text('Add Photo'),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: publishPost,
              icon: const Icon(Icons.send),
              label: const Text('Publish Post'),
            ),
          ],
        ),
      ),
    );
  }
}
