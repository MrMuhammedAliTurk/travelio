import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../widgets/destination_image.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({
    super.key,
    required this.savedDestinations,
    required this.onOpenDestination,
    required this.onToggleSaved,
    required this.onExplore,
  });

  final List<Destination> savedDestinations;
  final ValueChanged<Destination> onOpenDestination;
  final ValueChanged<String> onToggleSaved;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Favorilerin', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 6),
          const Text('Daha sonra ziyaret etmek istediklerin burada.', style: TextStyle(color: Color(0xFF7D8984), fontSize: 13)),
          const SizedBox(height: 20),
          if (savedDestinations.isEmpty)
            Expanded(child: _EmptyState(
              icon: Icons.favorite_border_rounded,
              title: 'Henüz favorin yok',
              message: 'Beğendiğin rotalardaki kalp simgesine dokunarak onları burada saklayabilirsin.',
              buttonLabel: 'Rotaları keşfet',
              onPressed: onExplore,
            ))
          else
            Expanded(
              child: ListView.separated(
                itemCount: savedDestinations.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final destination = savedDestinations[index];
                  return _DestinationRow(
                    destination: destination,
                    trailing: IconButton(
                      onPressed: () => onToggleSaved(destination.id),
                      icon: const Icon(Icons.favorite_rounded, color: Color(0xFFE56D69)),
                      tooltip: 'Favorilerden çıkar',
                    ),
                    onTap: () => onOpenDestination(destination),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class _DestinationRow extends StatelessWidget {
  const _DestinationRow({required this.destination, required this.trailing, required this.onTap});

  final Destination destination;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE8EDE9))),
          child: Row(
            children: [
              DestinationImage(imageUrl: destination.imageUrl, height: 94, width: 96, borderRadius: 14, iconSize: 28),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(destination.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF182D2A))),
                    const SizedBox(height: 5),
                    Text('${destination.city} · ${destination.category}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Color(0xFF7D8984))),
                    const SizedBox(height: 8),
                    Row(children: [const Icon(Icons.star_rounded, color: Color(0xFFE9A85D), size: 16), const SizedBox(width: 3), Text(destination.rating.toStringAsFixed(1), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800))]),
                  ],
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.icon, required this.title, required this.message, required this.buttonLabel, required this.onPressed});

  final IconData icon;
  final String title;
  final String message;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 86,
              height: 86,
              decoration: const BoxDecoration(color: Color(0xFFE6F1EB), shape: BoxShape.circle),
              child: Icon(icon, color: const Color(0xFF176B5B), size: 38),
            ),
            const SizedBox(height: 20),
            Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF182D2A))),
            const SizedBox(height: 9),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, height: 1.55, color: Color(0xFF7D8984))),
            const SizedBox(height: 20),
            FilledButton(onPressed: onPressed, style: FilledButton.styleFrom(backgroundColor: const Color(0xFF176B5B), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)), child: Text(buttonLabel)),
          ],
        ),
      ),
    );
  }
}
