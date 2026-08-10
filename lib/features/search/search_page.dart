import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [
          TextField(
            autofocus: false,

            decoration: const InputDecoration(
              hintText: 'Search recipes...',
              prefixIcon: Icon(Icons.search),
            ),
          ),

          const SizedBox(height: 30),

          Text(
            'Find a recipe',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 14),

          _SearchAction(
            icon: Icons.language_rounded,
            title: 'Find recipes online',
            subtitle:
            'Search for recipes and save them to your cookbook.',
          ),

          _SearchAction(
            icon: Icons.link_rounded,
            title: 'Import from URL',
            subtitle:
            'Paste a recipe webpage and extract the recipe.',
          ),

          _SearchAction(
            icon: Icons.camera_alt_rounded,
            title: 'Scan a recipe',
            subtitle:
            'Take a photo and let the on-device AI structure it.',
          ),

          _SearchAction(
            icon: Icons.edit_rounded,
            title: 'Create manually',
            subtitle:
            'Write your own recipe from scratch.',
          ),
        ],
      ),
    );
  }
}

class _SearchAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _SearchAction({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        contentPadding: const EdgeInsets.all(16),

        leading: Icon(
          icon,
          size: 30,
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(subtitle),
        ),

        trailing: const Icon(
          Icons.chevron_right,
        ),

        onTap: () {},
      ),
    );
  }
}