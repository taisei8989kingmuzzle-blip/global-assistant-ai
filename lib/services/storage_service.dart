import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String _notesKey = 'translation_notes';

  Future<void> saveNote ({
    required String originalText,
    required String translatedText,
    required String sourceLanguage,
    required String targetLanguage,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    
    final existingNotes = prefs.getStringList(_notesKey) ?? [];

    final note = {
      'originalText': originalText,
      'translatedText': translatedText,
      'sourceLanguage': sourceLanguage,
      'targetLanguage': targetLanguage,
      'timestamp': DateTime.now().toIso8601String(),
    };

    existingNotes.add(jsonEncode(note));

    await prefs.setStringList(_notesKey, existingNotes);
    }

    Future<List<Map<String, dynamic>>>getNotes() async {
      final prefs = await SharedPreferences.getInstance();

      final savedNotes = prefs.getStringList(_notesKey) ?? [];

      debugPrint('Retrieved ${savedNotes.length} notes');
      return savedNotes.map((note) => jsonDecode(note) as Map<String, dynamic>).toList().reversed.toList();
    }

    Future<void> clearNotes() async {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove(_notesKey);
    }
  }
