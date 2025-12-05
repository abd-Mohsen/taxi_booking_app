import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String name;
  final bool selected;
  final void Function() onCategoryChange;

  const CategoryCard({
    super.key,
    required this.name,
    required this.selected,
    required this.onCategoryChange,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return InkWell(
      onTap: onCategoryChange,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 110,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: selected ? cs.secondary : cs.secondaryContainer, width: 2),
          color: cs.secondaryContainer,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Center(
          child: Text(
            name,
            style: tt.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: cs.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
