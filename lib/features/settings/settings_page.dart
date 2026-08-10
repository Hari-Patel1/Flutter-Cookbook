import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [
          const _SettingsHeader(
            title: 'Appearance',
          ),

          _SettingsTile(
            icon: Icons.palette_outlined,
            title: 'Appearance',
            subtitle: 'Theme, colours and display',
            onTap: () {},
          ),

          const SizedBox(height: 24),

          const _SettingsHeader(
            title: 'Cooking',
          ),

          _SettingsTile(
            icon: Icons.restaurant_outlined,
            title: 'Cooking preferences',
            subtitle: 'Units, servings and timers',
            onTap: () {},
          ),

          const SizedBox(height: 24),

          const _SettingsHeader(
            title: 'AI',
          ),

          _SettingsTile(
            icon: Icons.smart_toy_outlined,
            title: 'AI settings',
            subtitle: 'Local models and AI behaviour',
            onTap: () {},
          ),

          const SizedBox(height: 24),

          const _SettingsHeader(
            title: 'Your data',
          ),

          _SettingsTile(
            icon: Icons.file_upload_outlined,
            title: 'Export cookbook',
            subtitle: 'Save your recipes to a file',
            onTap: () {},
          ),

          _SettingsTile(
            icon: Icons.file_download_outlined,
            title: 'Import cookbook',
            subtitle: 'Restore recipes from a file',
            onTap: () {},
          ),

          const SizedBox(height: 24),

          const _SettingsHeader(
            title: 'About',
          ),

          _SettingsTile(
            icon: Icons.info_outline,
            title: 'About RecipeFinder',
            subtitle: 'Version and licences',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  final String title;

  const _SettingsHeader({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        bottom: 10,
      ),

      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),

      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 5,
        ),

        leading: Icon(icon),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        subtitle: Text(subtitle),

        trailing: const Icon(
          Icons.chevron_right,
        ),

        onTap: onTap,
      ),
    );
  }
}