import 'package:flutter/material.dart';

// Import หน้าอื่นๆ ของคุณ
import 'user/home_user.dart';
import 'user/Category_user.dart';
import 'user/Cart_user.dart';
import 'user/Favorites_user.dart';
import 'user/Profile_user.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int _selectedIndex = 0;

  // รายการหน้าทั้งหมด
  // หมายเหตุ: ไม่ใส่ const เพื่อให้มันสร้าง Instance ใหม่ได้เรื่อยๆ
  final List<Widget> _pages = [
    const HomeUser(),
    const CategoryUser(),
    const CartUser(),
    const FavoritesUser(),
    const ProfileUser(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // ป้องกันการกด Back ออกจากแอป
      child: Scaffold(
        // ใช้ Stack เพื่อซ้อน Navbar ไว้บนสุด
        body: Stack(
          children: [
            // ==========================================
            // 🔥 ส่วนสำคัญ: เรียก Widget โดยตรงตาม Index
            // แทนการใช้ IndexedStack
            // ผลลัพธ์: หน้าเก่าจะถูกทำลาย หน้าใหม่จะถูกสร้าง (initState ทำงานใหม่ = รีเฟรช)
            // ==========================================
            _pages[_selectedIndex],

            // ส่วน Navigation Bar ลอยอยู่ด้านล่าง
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
