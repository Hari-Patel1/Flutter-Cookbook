import 'package:flutter/material.dart';
import 'package:cookbookv2/features/home/greeting.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Greeting(DateTime.now().hour),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              'What are we feeling?',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Find something delicious or add a recipe to your cookbook.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 24),

            // Search
            TextField(
              readOnly: true,

              decoration: const InputDecoration(
                hintText: 'Search your recipes...',
                prefixIcon: Icon(Icons.search),
              ),
            ),

            const SizedBox(height: 28),

            // Quick actions
            Text(
              'Quick actions',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _ActionCard(
                    icon: Icons.camera_alt_rounded,
                    title: 'Scan recipe',
                    onTap: () {},
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _ActionCard(
                    icon: Icons.edit_rounded,
                    title: 'Write recipe',
                    onTap: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _ActionCard(
                    icon: Icons.link_rounded,
                    title: 'Import URL',
                    onTap: () {},
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _ActionCard(
                    icon: Icons.explore_rounded,
                    title: 'Find recipes',
                    onTap: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            Text(
              'Recently added',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            const _EmptySection(
              icon: Icons.menu_book_outlined,
              title: 'Your cookbook is empty',
              message:
              'Add your first recipe and it will appear here.',
            ),

            const SizedBox(height: 32),

            Text(
              'Recommended',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            const _EmptySection(
              icon: Icons.restaurant_outlined,
              title: 'Recipe recommendations',
              message:
              'Recommendations will appear here once the recipe finder is connected.',
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surfaceContainerHighest,

      child: InkWell(
        onTap: onTap,

        borderRadius: BorderRadius.circular(20),

        child: Padding(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Icon(
                icon,
                size: 28,
                color: theme.colorScheme.primary,
              ),

              const SizedBox(height: 18),

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptySection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;

  const _EmptySection({
    required this.icon,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),

        child: Row(
          children: [
            Icon(
              icon,
              size: 40,
              color: theme.colorScheme.primary,
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    message,
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}