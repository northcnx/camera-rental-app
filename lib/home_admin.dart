import 'package:flutter/material.dart';

import 'admin/home_admin.dart';
import 'admin/Category_admin.dart';
import 'admin/Cart_admin.dart';
import 'admin/Favorites_admin.dart';
import 'admin/Profile_admin.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<AdminHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeAdmin(),
    CategoryAdmin(),
    CartAdmin(),
    FavoritesAdmin(),
    ProfileAdmin(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [
            IndexedStack(index: _selectedIndex, children: _pages),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70,
                margin: const EdgeInsets.only(bottom: 30, left: 24, right: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _navItem(Icons.home, 0),
                    _navItem(Icons.grid_view, 1),
                    _navItem(Icons.shopping_bag, 2),
                    _navItem(Icons.favorite_border, 3),
                    _navItem(Icons.person_outline, 4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    final bool active = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: active ? const Color(0xFF0088FF) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: active ? Colors.white : Colors.grey, size: 28),
      ),
    );
  }
}
