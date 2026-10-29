import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../widgets/destination_image.dart';

class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({
    super.key,
    required this.plannedDestinations,
    required this.savedIds,
    required this.onOpenDestination,
    required this.onToggleSaved,
    required this.onRemoveFromPlan,
    required this.onExplore,
  });

  final List<Destination> plannedDestinations;
  final Set<String> savedIds;
  final ValueChanged<Destination> onOpenDestination;
  final ValueChanged<String> onToggleSaved;
  final ValueChanged<String> onRemoveFromPlan;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) {
    final plannedDuration = plannedDestinations.length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Gezi planım', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 6),
          const Text('Bir sonraki maceranı adım adım hazırla.', style: TextStyle(color: Color(0xFF7D8984), fontSize: 13)),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(colors: [Color(0xFF176B5B), Color(0xFF2D8B73)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Row(
              children: [
                Container(width: 48, height: 48, decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.luggage_rounded, color: Colors.white, size: 26)),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Rotan şekilleniyor', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text('$plannedDuration destinasyon planında', style: const TextStyle(color: Color(0xFFD8EEE5), fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.route_rounded, color: Color(0xFFB8DED0), size: 29),
              ],
            ),
          ),
          const SizedBox(height: 19),
          Row(
            children: [
              const Text('Planladığım yerler', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF182D2A))),
              const Spacer(),
              Text('$plannedDuration yer', style: const TextStyle(color: Color(0xFF7D8984), fontSize: 12, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 12),
          if (plannedDestinations.isEmpty)
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 86, height: 86, decoration: const BoxDecoration(color: Color(0xFFE6F1EB), shape: BoxShape.circle), child: const Icon(Icons.map_outlined, color: Color(0xFF176B5B), size: 38)),
                      const SizedBox(height: 20),
                      const Text('Henüz bir gezi planın yok', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF182D2A))),
                      const SizedBox(height: 9),
                      const Text('Bir destinasyonun detay sayfasını açıp “Gezi planıma ekle” düğmesine dokun.', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, height: 1.55, color: Color(0xFF7D8984))),
                      const SizedBox(height: 20),
                      FilledButton(onPressed: onExplore, style: FilledButton.styleFrom(backgroundColor: const Color(0xFF176B5B), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14)), child: const Text('Rotaları keşfet')),
                    ],
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                itemCount: plannedDestinations.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final destination = plannedDestinations[index];
                  return Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => onOpenDestination(destination),
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
                                  Text('${destination.city} · ${destination.duration}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: Color(0xFF7D8984))),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.check_circle_rounded, color: Color(0xFF176B5B), size: 15),
                                      const SizedBox(width: 4),
                                      const Text('Planlandı', style: TextStyle(color: Color(0xFF176B5B), fontSize: 11, fontWeight: FontWeight.w800)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuButton<String>(
                              tooltip: 'Diğer işlemler',
                              onSelected: (value) {
                                if (value == 'remove') onRemoveFromPlan(destination.id);
                                if (value == 'save') onToggleSaved(destination.id);
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem(value: 'save', child: Text(savedIds.contains(destination.id) ? 'Favorilerden çıkar' : 'Favorilere ekle')),
                                const PopupMenuItem(value: 'remove', child: Text('Plandan çıkar')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
