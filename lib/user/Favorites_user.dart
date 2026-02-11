import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesUser extends StatefulWidget {
  const FavoritesUser({super.key});

  @override
  State<FavoritesUser> createState() => _FavoritesUserState();
}

class _FavoritesUserState extends State<FavoritesUser> {
  final supabase = Supabase.instance.client;
  late Future<List<dynamic>> favorites;

  @override
  void initState() {
    super.initState();
    favorites = _fetchFavorites();
  }

  // ================= FETCH =================
  Future<List<dynamic>> _fetchFavorites() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    // ดึงข้อมูลโดยเรียงลำดับใหม่สุดก่อน (ถ้าต้องการ)
    return await supabase
        .from('favorites')
        .select('id, cameras(*)')
        .eq('user_id', user.id)
        .order('id', ascending: false);
  }

  // ================= REFRESH =================
  Future<void> _refresh() async {
    setState(() {
      favorites = _fetchFavorites();
    });
    // รอจนกว่าจะโหลดเสร็จเพื่อให้ icon หมุนหยุด
    try {
      await favorites;
    } catch (_) {}
  }

  // ================= DELETE =================
  Future<void> removeFavorite(String favId) async {
    await supabase.from('favorites').delete().eq('id', favId);
    _refresh(); // โหลดใหม่ทันทีหลังลบ
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3A3A3A),
      appBar: AppBar(
        title: const Text('รายการโปรด'),
        backgroundColor: const Color(0xFF3A3A3A),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      // 🔥 ใช้ RefreshIndicator ครอบเพื่อให้ดึงลงเพื่อรีเฟรชได้
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: Colors.white,
        backgroundColor: Colors.black54,
        child: FutureBuilder<List<dynamic>>(
          future: favorites,
          builder: (_, s) {
            if (s.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            // กรณีไม่มีข้อมูล (ต้องทำให้ Scroll ได้ เพื่อให้ดึง Refresh ได้)
            if (!s.hasData || s.data!.isEmpty) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 60,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'ไม่มีรายการโปรด',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }

            final data = s.data!;

            // กรณีมีข้อมูล
            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(
                12,
                12,
                12,
                100,
              ), // เผื่อพื้นที่ด้านล่างให้ Navbar
              physics:
                  const AlwaysScrollableScrollPhysics(), // สำคัญ! ต้องมีเพื่อให้ดึงลงได้
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (_, i) {
                final fav = data[i];
                final cam = fav['cameras'];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            cam['image_url'] ?? '',
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              cam['name'] ?? 'Unknown',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () => removeFavorite(fav['id']),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.redAccent,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
