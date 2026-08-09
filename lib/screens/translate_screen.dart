import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../services/translation_service.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen ({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final SpeechToText _speech = SpeechToText();
  final TranslationService _translationService = TranslationService();

  //temporal test code
  // Future<void> _testTranslation() async {
  //   final result = await _translationService.translate(
  //     text: 'Hello Everyone!',
  //     sourceLanguage: 'en',
  //     targetLanguage: 'ja',
  //     );

  //     debugPrint(result);
  // }


  bool _isListening = false;
  bool _speechAvailable = false;

  String _recognizedText = '';
  String _translatedText = '';

  String _sourceLanguage = 'en';
  String _targetLanguage = 'ja';

  final Map<String, String> _languages = {
    'en': 'English',
    'ja': 'Japanese',
    'es': 'Spanish',
    'fr': 'French',
    'de': 'German',
    'zh': 'Chinese',
    'ko': 'Korean',
    'it': 'Italian',
    'pt': 'Portuguese',
  };

  String _getSpeechLocale(String language) {
    switch (language) {
      case 'en':
        return 'en-US';
      case 'ja':
        return 'ja-JP';
      case 'es':
        return 'es-ES';
      case 'fr':
        return 'fr-FR';
      case 'de':
        return 'de-DE';
      case 'zh':
        return 'zh-CN';
      case 'ko':
        return 'ko-KR';
      case 'it':
        return 'it-IT';
      case 'pt':
        return 'pt-BR';
      default: 
        return 'en-US';
    }
  }
  Future<void> _translateText(String text) async {
    if (text.trim().isEmpty) {
      return;
    }

    try {
      final translated = await _translationService.translate(
        text: text,
        sourceLanguage: _sourceLanguage,
        targetLanguage: _targetLanguage,
        );

        if (!mounted) return;

        setState(() {
          _translatedText = translated;
        });

    } catch (e) {
      debugPrint('Translation error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
    }

  Future<void> _initializeSpeech() async {
    final available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'notListening') {
          setState(() {
            _isListening = false;
          });
        }
      },
      onError: (error) {
        setState(() {
          _isListening = false;
        });

        debugPrint('Speech error: $error');
      },
    );

    setState(() {
      _speechAvailable = available;
    });
  }

  Future<void> _startListening() async {
    if (!_speechAvailable) {
      return;
    }

    setState(() {
      _isListening = true;
      _recognizedText = '';
    });

    await _speech.listen (
      onResult: (result) {
        setState(() {
          _recognizedText = result.recognizedWords;
        });

        if(result.finalResult) {
          _translateText(result.recognizedWords);
        }
      },
      listenOptions: SpeechListenOptions(
      localeId: _getSpeechLocale(_sourceLanguage),
      partialResults: true,
      )
    );
  }

  Future<void> _stopListening() async {
    await _speech.stop();

    setState(() {
      _isListening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF07152F),
              Color(0xFF070D26),
              Color(0xFF020617),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              //Header
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  20, 
                  15, 
                  20, 
                  10,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);                        
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                      ),
                    ),

                    const Expanded(
                      child: Text(
                        'Real-Time Translation',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 48),
                  ],
                ),
                ),

                const SizedBox(height: 15),

                //Language indicator
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFF15284C),
                    border: Border.all(
                      color: Colors.white12,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        value: _sourceLanguage,
                        items: _languages.entries.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Text(entry.value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value == null) return;

                          setState(() {
                            _sourceLanguage = value;
                          });
                        },
                      ),

                      SizedBox(width: 15),

                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white54,
                      ),

                      SizedBox(width: 15),

                      DropdownButton<String>(
                        value: _targetLanguage,
                        items: _languages.entries.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Text(entry.value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value == null) return;

                          setState(() {
                            _targetLanguage = value;
                          });
                        },
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                //recognized Speech
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        color: const Color(0xFF101C38),
                        border: Border.all(
                          color: const Color(0xFF3478FF),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: 
                        CrossAxisAlignment.start,
                        children: [
                           Text(
                            _languages[_sourceLanguage]?? 'Unknown',
                            style: TextStyle(
                              color: Color(0xFF56B8FF),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 15),

                          Text(
                            _recognizedText.isEmpty
                              ?_isListening 
                                ?'Listening...'
                                :'Press the microphone and start the conversation.'
                              :_recognizedText,
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.5,
                                color: _recognizedText.isEmpty
                                    ? Colors.white38
                                    :Colors.white,
                              ),
                          ),
                          Text(
                            _translatedText.isEmpty
                              ?'Translation will be displayed here...'
                              : _translatedText,
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.5,
                                color: Colors.white,
                              ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //Microphone
                GestureDetector(
                  onTap: _isListening
                      ? _stopListening
                      : _startListening,
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 250,
                      ),
                      width: 85, 
                      height: 85,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: _isListening
                          ? [
                            const Color(0xFFFF4F81),
                            const Color(0xFFA855F7),
                          ]
                        : [
                          const Color(0xFF20C9FF),
                          const Color(0xFF6366F1),
                        ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: (_isListening
                                    ? const Color(0xFFFF4F81)
                                    : const Color(0xFF20C9FF))
                                .withOpacity(0.35),
                            blurRadius: 25,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isListening
                            ? Icons.stop_rounded
                            : Icons.mic_rounded,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                ),
                const SizedBox(height: 12),

                Text(
                  _isListening
                      ? 'Listening... Tap to stop'
                      : 'Tap to start listening',
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}