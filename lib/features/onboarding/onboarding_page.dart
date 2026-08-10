import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingPage({
    super.key,
    required this.onComplete,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();

  int currentPage = 0;

  final List<_OnboardingData> pages = const [
    _OnboardingData(
      icon: Icons.menu_book_rounded,
      title: 'Your recipes.\nYour cookbook.',
      description:
      'Keep all your favourite recipes organised in one beautiful cookbook.',
    ),

    _OnboardingData(
      icon: Icons.auto_awesome_rounded,
      title: 'Add recipes\nyour way.',
      description:
      'Write recipes yourself, scan them from an image, or import them from a webpage.',
    ),

    _OnboardingData(
      icon: Icons.smart_toy_rounded,
      title: 'AI that lives\non your device.',
      description:
      'Use on-device AI to turn messy recipe text into clean ingredients and instructions.',
    ),

    _OnboardingData(
      icon: Icons.restaurant_rounded,
      title: 'Cook without\nthe clutter.',
      description:
      'Cook Mode gives you clear instructions, ingredients and optional timers while you cook.',
    ),

    _OnboardingData(
      icon: Icons.lock_rounded,
      title: 'Your recipes\nstay yours.',
      description:
      'No account. No cloud database. Your cookbook stays on your device and can be exported whenever you want.',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void next() {
    if (currentPage == pages.length - 1) {
      widget.onComplete();
      return;
    }

    _controller.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = pages[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            page.icon,
                            size: 72,
                            color: theme.colorScheme.primary,
                          ),
                        ),

                        const SizedBox(height: 50),

                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          page.description,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                    (index) {
                  final selected = index == currentPage;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    width: selected ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: selected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: next,
                  child: Text(
                    currentPage == pages.length - 1
                        ? 'Start Cooking'
                        : 'Continue',
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 40,
              child: currentPage == 0
                  ? const SizedBox()
                  : TextButton(
                onPressed: widget.onComplete,
                child: const Text('Skip'),
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _OnboardingData {
  final IconData icon;
  final String title;
  final String description;

  const _OnboardingData({
    required this.icon,
    required this.title,
    required this.description,
  });
}