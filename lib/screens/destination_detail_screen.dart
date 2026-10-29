import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../widgets/destination_image.dart';

class DestinationDetailScreen extends StatefulWidget {
  const DestinationDetailScreen({
    super.key,
    required this.destination,
    required this.initiallySaved,
    required this.initiallyPlanned,
    required this.onToggleSaved,
    required this.onTogglePlanned,
  });

  final Destination destination;
  final bool initiallySaved;
  final bool initiallyPlanned;
  final VoidCallback onToggleSaved;
  final VoidCallback onTogglePlanned;

  @override
  State<DestinationDetailScreen> createState() => _DestinationDetailScreenState();
}

class _DestinationDetailScreenState extends State<DestinationDetailScreen> {
  bool? _saved;
  bool? _planned;

  bool get _isSaved => _saved ?? widget.initiallySaved;
  bool get _isPlanned => _planned ?? widget.initiallyPlanned;

  void _toggleSaved() {
    setState(() => _saved = !_isSaved);
    widget.onToggleSaved();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isSaved ? 'Favorilerine eklendi.' : 'Favorilerinden kaldırıldı.'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _togglePlanned() {
    setState(() => _planned = !_isPlanned);
    widget.onTogglePlanned();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isPlanned ? 'Gezi planına eklendi.' : 'Gezi planından çıkarıldı.'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 310,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    DestinationImage(imageUrl: destination.imageUrl, borderRadius: 0, iconSize: 72),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black.withOpacity(0.25), Colors.transparent, Colors.black.withOpacity(0.45)],
                          stops: const [0, 0.45, 1],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 14,
                      left: 16,
                      child: _CircleActionButton(
                        icon: Icons.arrow_back_rounded,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Positioned(
                      top: 14,
                      right: 16,
                      child: _CircleActionButton(
                        icon: _isSaved ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        iconColor: _isSaved ? const Color(0xFFE56D69) : const Color(0xFF243A34),
                        onTap: _toggleSaved,
                      ),
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 22,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                            decoration: BoxDecoration(color: const Color(0xFFE9A85D), borderRadius: BorderRadius.circular(30)),
                            child: Text(destination.category.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF3C2C18), letterSpacing: 0.8)),
                          ),
                          const SizedBox(height: 9),
                          Text(destination.name, style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900, letterSpacing: -0.6)),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.location_on_rounded, color: Colors.white, size: 16),
                              const SizedBox(width: 3),
                              Text('${destination.city}, ${destination.country}', style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 22, 20, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _InfoChip(icon: Icons.schedule_rounded, label: destination.duration),
                        const SizedBox(width: 8),
                        _InfoChip(icon: Icons.star_rounded, label: destination.rating.toStringAsFixed(1), accent: const Color(0xFFE9A85D)),
                        const SizedBox(width: 8),
                        _InfoChip(icon: Icons.account_balance_wallet_outlined, label: destination.budget),
                      ],
                    ),
                    const SizedBox(height: 23),
                    Text('Bu rotayı keşfet', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 10),
                    Text(destination.description, style: const TextStyle(color: Color(0xFF65736D), fontSize: 14, height: 1.7)),
                    const SizedBox(height: 24),
                    Text('Öne çıkanlar', style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: destination.tags.map((tag) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                        decoration: BoxDecoration(color: const Color(0xFFEAF3EE), borderRadius: BorderRadius.circular(30)),
                        child: Text(tag, style: const TextStyle(color: Color(0xFF286B5A), fontSize: 12, fontWeight: FontWeight.w700)),
                      )).toList(),
                    ),
                    const SizedBox(height: 23),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(color: const Color(0xFFFFF5E9), borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFF7E6D1))),
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.lightbulb_outline_rounded, color: Color(0xFFAA6C20), size: 22),
                          SizedBox(width: 10),
                          Expanded(child: Text('Gezi öncesinde ulaşım, hava durumu ve ziyaret saatleri gibi bilgileri güncel kaynaklardan kontrol etmeyi unutma. Bu uygulamadaki bilgiler örnek amaçlıdır.', style: TextStyle(color: Color(0xFF775A38), fontSize: 12, height: 1.55))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
          decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFE9EEEA)))),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _toggleSaved,
                  icon: Icon(_isSaved ? Icons.favorite_rounded : Icons.favorite_border_rounded, size: 18),
                  label: Text(_isSaved ? 'Kaydedildi' : 'Favorile'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF176B5B),
                    side: const BorderSide(color: Color(0xFFD3E4DB)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  onPressed: _togglePlanned,
                  icon: Icon(_isPlanned ? Icons.check_circle_outline_rounded : Icons.add_rounded, size: 20),
                  label: Text(_isPlanned ? 'Planıma eklendi' : 'Gezi planıma ekle'),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF176B5B),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  const _CircleActionButton({required this.icon, required this.onTap, this.iconColor = const Color(0xFF243A34)});

  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.95),
      shape: const CircleBorder(),
      child: IconButton(onPressed: onTap, icon: Icon(icon, color: iconColor), tooltip: 'İşlem'),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label, this.accent = const Color(0xFF176B5B)});

  final IconData icon;
  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFE7ECE8))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 15, color: accent),
            const SizedBox(width: 5),
            Flexible(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF40524B)))),
          ],
        ),
      ),
    );
  }
}
