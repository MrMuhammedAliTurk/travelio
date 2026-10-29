import 'package:flutter/material.dart';
import '../data/destination_data.dart';
import '../models/destination.dart';
import '../widgets/destination_card.dart';
import '../widgets/destination_image.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({
    super.key,
    required this.savedIds,
    required this.onOpenDestination,
    required this.onToggleSaved,
  });

  final Set<String> savedIds;
  final ValueChanged<Destination> onOpenDestination;
  final ValueChanged<String> onToggleSaved;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String _selectedCategory = 'Tümü';
  String _selectedScope = 'Tümü';
  static const List<String> _scopes = ['Tümü', 'Türkiye', 'Yurt dışı'];
  static const List<String> _categories = ['Tümü', 'Kültür', 'Doğa', 'Sahil', 'Tarih', 'Şehir'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Destination> get _filteredDestinations {
    final normalizedQuery = _normalizeSearchText(_query.trim());
    return destinations.where((destination) {
      final matchesCategory = _selectedCategory == 'Tümü' || destination.category == _selectedCategory;
      final matchesScope = _selectedScope == 'Tümü' ||
          (_selectedScope == 'Türkiye' ? destination.country == 'Türkiye' : destination.country != 'Türkiye');
      final searchable = <String>[
        destination.name,
        destination.city,
        destination.region,
        destination.country,
        destination.category,
        ...destination.tags,
      ].join(' ');
      final normalizedSearchable = _normalizeSearchText(searchable);
      final matchesSearch = normalizedQuery.isEmpty || normalizedSearchable.contains(normalizedQuery);
      return matchesCategory && matchesScope && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final featured = _selectedScope == 'Yurt dışı'
        ? destinations.firstWhere((destination) => destination.featured && destination.country != 'Türkiye')
        : destinations.firstWhere((destination) => destination.id == 'kapadokya');
    final shownDestinations = _filteredDestinations;
    final showFeatured = _query.trim().isEmpty && _selectedCategory == 'Tümü';

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF176B5B),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(Icons.explore_rounded, color: Colors.white, size: 25),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Travelio', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900, color: Color(0xFF182D2A), letterSpacing: -0.5)),
                  Text('Yeni yerler, yeni hikâyeler', style: TextStyle(fontSize: 11, color: Color(0xFF85918B))),
                ],
              ),
              const Spacer(),
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFE7ECE8))),
                child: const Icon(Icons.notifications_none_rounded, color: Color(0xFF33443F)),
              ),
            ],
          ),
          const SizedBox(height: 26),
          Text('Nereye gitmek', style: Theme.of(context).textTheme.headlineLarge),
          Text('istersiniz?', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 9),
          const Text('Bir sonraki unutulmaz rotanı keşfet.', style: TextStyle(color: Color(0xFF7A8882), fontSize: 14)),
          const SizedBox(height: 20),
          TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => _query = value),
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              hintText: 'Şehir, ülke, bölge veya ilgi alanı ara',
              prefixIcon: Icon(Icons.search_rounded, color: Color(0xFF648077)),
              suffixIcon: Icon(Icons.tune_rounded, color: Color(0xFF648077)),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Rotanın kapsamı', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF33443F))),
          const SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _scopes.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final scope = _scopes[index];
                final selected = scope == _selectedScope;
                final icon = scope == 'Türkiye' ? Icons.flag_rounded : (scope == 'Yurt dışı' ? Icons.flight_takeoff_rounded : Icons.public_rounded);
                return ChoiceChip(
                  avatar: Icon(icon, size: 16, color: selected ? Colors.white : const Color(0xFF648077)),
                  label: Text(scope),
                  selected: selected,
                  onSelected: (_) => setState(() => _selectedScope = scope),
                  showCheckmark: false,
                  labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: selected ? Colors.white : const Color(0xFF67756F)),
                  backgroundColor: Colors.white,
                  selectedColor: const Color(0xFF176B5B),
                  side: BorderSide(color: selected ? const Color(0xFF176B5B) : const Color(0xFFE6ECE7)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                );
              },
            ),
          ),
          if (showFeatured) ...[
            const SizedBox(height: 24),
            Row(
              children: [
                Text(_selectedScope == 'Yurt dışı' ? 'Yurt dışından öne çıkan' : 'Öne çıkan rota', style: Theme.of(context).textTheme.titleLarge),
                const Spacer(),
                const Icon(Icons.auto_awesome_rounded, color: Color(0xFFE9A85D), size: 18),
              ],
            ),
            const SizedBox(height: 12),
            _FeaturedCard(
              destination: featured,
              onTap: () => widget.onOpenDestination(featured),
            ),
          ],
          const SizedBox(height: 27),
          Row(
            children: [
              Text(_selectedScope == 'Türkiye' ? 'Türkiye rotaları' : (_selectedScope == 'Yurt dışı' ? 'Yurt dışı rotaları' : 'Rotaları keşfet'), style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              Text('${shownDestinations.length} yer', style: const TextStyle(color: Color(0xFF88958F), fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: 13),
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final selected = category == _selectedCategory;
                return ChoiceChip(
                  label: Text(category),
                  selected: selected,
                  onSelected: (_) => setState(() => _selectedCategory = category),
                  showCheckmark: false,
                  labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: selected ? Colors.white : const Color(0xFF67756F)),
                  backgroundColor: Colors.white,
                  selectedColor: const Color(0xFF176B5B),
                  side: BorderSide(color: selected ? const Color(0xFF176B5B) : const Color(0xFFE6ECE7)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          if (shownDestinations.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Center(
                child: Column(
                  children: [
                    const Icon(Icons.travel_explore_rounded, size: 38, color: Color(0xFF8CA79B)),
                    const SizedBox(height: 10),
                    const Text('Bu filtrelerle eşleşen rota bulunamadı.', style: TextStyle(color: Color(0xFF778780))),
                    TextButton.icon(
                      onPressed: () => setState(() {
                        _query = '';
                        _selectedCategory = 'Tümü';
                        _selectedScope = 'Tümü';
                        _searchController.clear();
                      }),
                      icon: const Icon(Icons.restart_alt_rounded),
                      label: const Text('Filtreleri temizle'),
                    ),
                  ],
                ),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: shownDestinations.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 13,
                crossAxisSpacing: 13,
                mainAxisExtent: 230,
              ),
              itemBuilder: (context, index) {
                final destination = shownDestinations[index];
                return DestinationCard(
                  destination: destination,
                  isSaved: widget.savedIds.contains(destination.id),
                  onTap: () => widget.onOpenDestination(destination),
                  onToggleSaved: () => widget.onToggleSaved(destination.id),
                );
              },
            ),
        ],
      ),
    );
  }
}

String _normalizeSearchText(String value) {
  return value
      .toLowerCase()
      .replaceAll('\u0307', '')
      .replaceAll('ı', 'i')
      .replaceAll('ş', 's')
      .replaceAll('ğ', 'g')
      .replaceAll('ü', 'u')
      .replaceAll('ö', 'o')
      .replaceAll('ç', 'c')
      .replaceAll('â', 'a')
      .replaceAll('î', 'i')
      .replaceAll('û', 'u');
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.destination, required this.onTap});

  final Destination destination;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final locationLabel = destination.country == 'Türkiye'
        ? destination.city
        : '${destination.city}, ${destination.country}';

    return Material(
      borderRadius: BorderRadius.circular(26),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 218,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              DestinationImage(imageUrl: destination.imageUrl, borderRadius: 0, iconSize: 60),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.02), Colors.black.withOpacity(0.72)],
                  ),
                ),
              ),
              Positioned(
                left: 18,
                right: 18,
                bottom: 17,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(color: const Color(0xFFE9A85D), borderRadius: BorderRadius.circular(30)),
                      child: const Text('HAFTANIN ROTASI', style: TextStyle(color: Color(0xFF3D2C17), fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.8)),
                    ),
                    const SizedBox(height: 9),
                    Text(destination.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 26, letterSpacing: -0.4)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded, color: Colors.white70, size: 15),
                        const SizedBox(width: 3),
                        Text('$locationLabel · ${destination.duration}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                        const Spacer(),
                        Container(
                          height: 37,
                          width: 37,
                          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: const Icon(Icons.arrow_forward_rounded, color: Color(0xFF176B5B), size: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
