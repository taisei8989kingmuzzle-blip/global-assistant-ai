import 'package:flutter/material.dart';
import 'package:global_assistant_ai/services/translation_service.dart';
import 'screens/translate_screen.dart';
import 'screens/notes_screen.dart';
void main() {
  runApp(const GlobalAssistantApp());
}

class GlobalAssistantApp extends StatelessWidget {
  const GlobalAssistantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      debugShowCheckedModeBanner: false,
      title: 'Global Assistant',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFF030817),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
 
 String _sourceLanguage = 'en';
 String _targetLanguage = 'ja';

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
            child: Column(
              children: [
                // -----------------------------------
                //HEADER
                //-------------------------------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF20C9FF),
                            Color(0xFF8B5CF6),
                          ],
                          ),
                      ),
                      child: const Icon(
                        Icons.language_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),

                    const SizedBox(width: 12),

                    const Text(
                      'Global Assistant',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                //------------------------------------
                //Language Card
                //-------------------------------------
                _LanguageCard(
                  sourceLanguage: _sourceLanguage,
                  targetLanguage: _targetLanguage,
                  onSourceChanged: (value) {
                    setState(() {
                      _sourceLanguage = value;
                    });
                  },
                  onTargetChanged: (value) {
                    setState(() {
                      _targetLanguage = value;
                    });
                  },
                ),

                const SizedBox(height: 20),
                //-------------------------------------------------
                //Real-Time Translation
                //------------------------------------------------
                _FeatureCard(
                  icon: Icons.graphic_eq_rounded,
                  iconColor:const Color(0xFF36B9FF),
                  title:'Real-Time Audio Translate',
                  subtitle: 
                    'Speak and translate instantly in real time.',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TranslateScreen(
                          sourceLanguage: _sourceLanguage,
                          targetLanguage: _targetLanguage,
                        )
                      )
                    );
                  },  
                ),

                const SizedBox(height: 16),

                //-----------------------------------------------
                //Notes
                //----------------------------------------------------
                _FeatureCard(
                  icon: Icons.menu_book_rounded,
                  iconColor: const Color(0xFFA875FF),
                  title: 'Check the Notes Taken',
                  subtitle: 
                    'View and manage your translated notes.',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotesScreen(),
                      )
                    );
                  },
                ),

                const SizedBox(height: 16),

               
               

                const SizedBox(height: 30),

                //--------------------------------------------------------
                //Footer
                //---------------------------------------------------
                const Text(
                  'Powered by AI, Built for global communication',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white38,
                    fontSize: 12,
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

//==================================================
//Language Card
//========================================================

class _LanguageCard extends StatelessWidget {
  final String sourceLanguage;
  final String targetLanguage;

  final ValueChanged<String> onSourceChanged;
  final ValueChanged<String> onTargetChanged;

  const _LanguageCard({
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.onSourceChanged,
    required this.onTargetChanged,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFF3977FF),
          width: 1.3
          ),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF122B55),
              Color(0xFF121735),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2168FF).withOpacity(0.12),
              blurRadius: 25,
              spreadRadius: 2,
            ),
          ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Translate',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
            ),

            const SizedBox(height: 10),

            _LanguageSelector(
              languageCode: sourceLanguage,
              language: TranslationService.languages[sourceLanguage] ?? 'Unknown',
              onChanged: onSourceChanged,
            ),

            const SizedBox(height: 16),

            const Text(
              'Into',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            _LanguageSelector(
              languageCode: targetLanguage,
              language: TranslationService.languages[targetLanguage] ?? 'Unknown',
              onChanged: onTargetChanged,
      
            ),
        ],
        ),
    );
  }
}

//=============================================================
//Language Selector
//=========================================================
class _LanguageSelector extends StatelessWidget {
  final String languageCode;
  final String language;

  final ValueChanged<String> onChanged;

  const _LanguageSelector({
    required this.languageCode,
    required this.language,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xFF182D52),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: languageCode,
            isExpanded: true,

            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white70,
            ),

            dropdownColor: const Color(0xFF182D52),

            items: TranslationService.languages.entries
            .map(
              (entry) => DropdownMenuItem<String>(
                value: entry.key,
                child: Text(
                  entry.value, 
                  style: const TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ).toList(),

            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            }
          )
        )
    );
  }
}

//==========================================================
//Feature Card
//========================================================

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, 
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          border: Border.all(
            color: iconColor.withOpacity(0.35),
            width: 1.2,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF102653),
              const Color(0xFF101638),
            ],
          ),
        ),
        child: Row(
          children: [
            //Icon
            Container(
              width: 70, 
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor.withOpacity(0.08),
                border: Border.all(
                  color: iconColor.withOpacity(0.3),
                ),
              ),
              child: Icon(
                icon, 
                size: 34,
                color: iconColor,
              ),
            ),

            const SizedBox(width: 18),

            //Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Colors.white60,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            //Arrow
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconColor.withOpacity(0.12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}