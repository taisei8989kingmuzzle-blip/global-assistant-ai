import 'package:flutter/material.dart';

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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                _LanguageCard(),

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
                    //Translation Screen added later
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
                    //Notes screen will appear
                  },
                ),

                const SizedBox(height: 16),

                //------------------------------------------------------------
                //Export
                //-------------------------------------------------------------
                _FeatureCard(
                  icon: Icons.cloud_upload_rounded,
                  iconColor: const Color(0xFF28D7D0),
                  title: 'Export & Share',
                  subtitle: 'Export your notes or share them anywhere',
                  onTap: () {
                    //Export feature will appear
                  },
                ),

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
              flag: 'us',
              language: 'English',
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
              flag: 'JP',
              language: "Japanese",
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
  final String flag;
  final String language;

  const _LanguageSelector({
    required this.flag,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xFF182D52),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            ),
        ),
        child: Row(
          children: [
            Text(
              flag,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                language,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ),

              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white70,
              ),
          ],
          ),
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