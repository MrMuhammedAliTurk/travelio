import 'package:flutter/material.dart';
import '../data/destination_data.dart';
import '../models/destination.dart';
import 'destination_detail_screen.dart';
import 'explore_screen.dart';
import 'itinerary_screen.dart';
import 'profile_screen.dart';
import 'saved_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;
  final Set<String> _savedIds = <String>{};
  final Set<String> _plannedIds = <String>{};

  void _toggleSaved(String id) {
    setState(() {
      if (!_savedIds.add(id)) _savedIds.remove(id);
    });
  }

  void _togglePlanned(String id) {
    setState(() {
      if (!_plannedIds.add(id)) _plannedIds.remove(id);
    });
  }

  void _openDestination(Destination destination) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (context) => DestinationDetailScreen(
          destination: destination,
          initiallySaved: _savedIds.contains(destination.id),
          initiallyPlanned: _plannedIds.contains(destination.id),
          onToggleSaved: () => _toggleSaved(destination.id),
          onTogglePlanned: () => _togglePlanned(destination.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      ExploreScreen(
        savedIds: _savedIds,
        onOpenDestination: _openDestination,
        onToggleSaved: _toggleSaved,
      ),
      SavedScreen(
        savedDestinations: destinations.where((item) => _savedIds.contains(item.id)).toList(),
        onOpenDestination: _openDestination,
        onToggleSaved: _toggleSaved,
        onExplore: () => setState(() => _selectedIndex = 0),
      ),
      ItineraryScreen(
        plannedDestinations: destinations.where((item) => _plannedIds.contains(item.id)).toList(),
        savedIds: _savedIds,
        onOpenDestination: _openDestination,
        onToggleSaved: _toggleSaved,
        onRemoveFromPlan: _togglePlanned,
        onExplore: () => setState(() => _selectedIndex = 0),
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_selectedIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFDDEFE7),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Keşfet'),
          NavigationDestination(icon: Icon(Icons.favorite_border_rounded), selectedIcon: Icon(Icons.favorite_rounded), label: 'Favoriler'),
          NavigationDestination(icon: Icon(Icons.luggage_outlined), selectedIcon: Icon(Icons.luggage), label: 'Planım'),
          NavigationDestination(icon: Icon(Icons.person_outline_rounded), selectedIcon: Icon(Icons.person_rounded), label: 'Profil'),
        ],
      ),
    );
  }
}
