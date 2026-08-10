import 'package:flutter/material.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Collections',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
            tooltip: 'New collection',
          ),
        ],
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [
          Text(
            'Your cookbook',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            'Organise your recipes into collections.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 28),

          _CollectionCard(
            icon: Icons.favorite_rounded,
            title: 'Favourites',
            count: 0,
          ),

          const SizedBox(height: 12),

          _CollectionCard(
            icon: Icons.menu_book_rounded,
            title: 'All recipes',
            count: 0,
          ),

          const SizedBox(height: 12),

          Card(
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(20),

              child: const Padding(
                padding: EdgeInsets.all(20),

                child: Row(
                  children: [
                    Icon(Icons.add),

                    SizedBox(width: 16),

                    Text(
                      'Create collection',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;

  const _CollectionCard({
    required this.icon,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),

        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,

          child: Icon(
            icon,
            color: theme.colorScheme.primary,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),

        subtitle: Text(
          '$count recipes',
        ),

        trailing: const Icon(
          Icons.chevron_right,
        ),
      ),
    );
  }
}