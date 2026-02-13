// import 'package:flutter/material.dart';

// class HomeUser extends StatelessWidget {
//   const HomeUser({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(child: Text("หน้าหลัก User")),
//     );
//   }
// }
//สิ่งที่ต้องใช้ใน SQL (LIKE)
//SELECT * FROM products 
//WHERE name LIKE '%Sony%' 
//OR details LIKE '%Sony%';

import 'package:flutter/material.dart';
import 'notifications_user.dart';
import 'Category_user.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  // เพิ่มส่วนนี้เพื่อรับค่าจากช่องค้นหา
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF3A3A3A);
    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Search Bar (แก้ไขให้พิมพ์ได้จริง) =====
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.black54),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                        decoration: const InputDecoration(
                          hintText: "ค้นหากล้อง / เลนส์ / อุปกรณ์",
                          hintStyle: TextStyle(
                            color: Colors.black45,
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        onSubmitted: (value) {
                          // ส่วนที่เอาไว้ทดสอบกับ SQL LIKE ใน Postman
                          print(
                            "SQL Query: SELECT * FROM products WHERE name LIKE '%$value%'",
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // ===== Banner (รูปแบบเดิม) =====
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  height: 170,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://images.unsplash.com/photo-1519183071298-a2962eade1c3?auto=format&fit=crop&w=1200&q=60",
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.30),
                                Colors.black.withOpacity(0.55),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(999),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const NotificationsUserPage(),
                                ),
                              );
                            },
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white24),
                              ),
                              child: const Icon(
                                Icons.notifications_none,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 12,
                        bottom: 12,
                        child: Text(
                          "CAMERA RENTAL",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // ===== Section: Category (รูปแบบเดิม) =====
              const Center(
                child: Text(
                  "ประเภท",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 110,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    _CategoryCard(
                      title: "Digital Camera",
                      imageUrl:
                          "https://images.unsplash.com/photo-1516724562728-afc824a36e84?w=400",
                    ),
                    _CategoryCard(
                      title: "Mirrorless",
                      imageUrl:
                          "https://images.unsplash.com/photo-1519181245277-cffeb31da2fb?w=400",
                    ),
                    _CategoryCard(
                      title: "Action Cam",
                      imageUrl:
                          "https://images.unsplash.com/photo-1519183071298-a2962eade1c3?w=400",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ===== Section: Recommended (รูปแบบเดิม) =====
              const Center(
                child: Text(
                  "แนะนำ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              const _RecommendedCard(
                name: "Canon PowerShot G7 X Mark III",
                pricePerDay: "1500/วัน",
                details:
                    "คุณสมบัติ:\n- ความละเอียด 1.0 ล้านพิกเซล\n- เหมาะสำหรับถ่ายภาพและวิดีโอ\n- กันสั่นดีเยี่ยม เหมาะกับการถ่ายมือ",
                imageUrl:
                    "https://images.unsplash.com/photo-1519183071298-a2962eade1c3?w=900",
              ),

              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------- _CategoryCard (คงเดิม) ----------
class _CategoryCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const _CategoryCard({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.black12,
                  child: const Icon(Icons.broken_image),
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.70),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              bottom: 8,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- _RecommendedCard ----------
class _RecommendedCard extends StatelessWidget {
  final String name;
  final String details;
  final String pricePerDay;
  final String imageUrl;

  const _RecommendedCard({
    required this.name,
    required this.details,
    required this.pricePerDay,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 120,
                height: 120,
                color: Colors.black12,
                child: const Icon(Icons.broken_image),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  details,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    pricePerDay,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
