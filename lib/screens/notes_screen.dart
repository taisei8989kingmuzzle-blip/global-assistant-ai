import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen ({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final StorageService _storageService = StorageService();

  List<Map<String, dynamic>> _notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await _storageService.getNotes();

    debugPrint('Notes Loaded ${notes.length}');

    setState(() {
      _notes = notes;
    });
  }

  Future<void> _clearNotes() async {
    await _storageService.clearNotes();

    setState(() {
      _notes = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translation Notes'),
        actions: [
          if (_notes.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _clearNotes,
          ),
        ],
      ),
      body: _notes.isEmpty
    ? const Center(
        child: Text(
          'No translations saved yet.',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      )
    : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${note['sourceLanguage']} → ${note['targetLanguage']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    note['originalText'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const Divider(height: 24),

                  Text(
                    note['translatedText'] ?? '',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}