import 'package:flutter/material.dart';
import 'loginScreen/login_email_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      "title": "Unlock Your Dream\nHome Journey with Us",
      "desc":
      "Discover a property way to find your perfect home.\nOur app provides a personalized experience.",
    },
    {
      "title": "Your Home, Your\nWay, Our App",
      "desc":
      "Begin your adventure in the real estate landscape.\nFind your perfect property easily.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 🔥 STATIC BACKGROUND IMAGE
          Image.asset(
            'assets/images/homeimg.png',
            fit: BoxFit.cover,
          ),

          // Overlay
          Container(color: Colors.black.withOpacity(0.55)),

          // Page content only
          PageView.builder(
            controller: _controller,
            itemCount: pages.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              final item = pages[index];

              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/DT broker.png',
                              width: 350,
                            ),
                            const SizedBox(height: 6),

                          ],
                        ),
                      ),

                      const Spacer(),

                      Text(
                        item['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        item['desc']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        children: List.generate(
                          pages.length,
                              (i) => Container(
                            margin: const EdgeInsets.only(right: 6),
                            height: 3,
                            width: _currentPage == i ? 24 : 12,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(
                          backgroundColor: const Color(0xffE6C56F),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            if (_currentPage < pages.length - 1) {
                              _controller.nextPage(
                                duration:
                                const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const LoginEmailPage(),
                                ),
                                    (route) => false,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
