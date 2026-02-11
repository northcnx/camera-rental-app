// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'camera_detail_page.dart';

// class CameraListByCategory extends StatefulWidget {
//   final String categoryId;
//   final String categoryName;

//   const CameraListByCategory({
//     super.key,
//     required this.categoryId,
//     required this.categoryName,
//   });

//   @override
//   State<CameraListByCategory> createState() => _CameraListByCategoryState();
// }

// class _CameraListByCategoryState extends State<CameraListByCategory> {
//   final supabase = Supabase.instance.client;

//   List cameras = [];
//   Set<String> favoriteIds = {};
//   bool loading = true;

//   // 🔍 ตัวแปรสำหรับเก็บคำค้นหา
//   String _searchKeyword = '';

//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }

//   Future<void> loadData() async {
//     if (!mounted) return;

//     setState(() => loading = true);

//     final user = supabase.auth.currentUser;

//     final camData = await supabase
//         .from('cameras')
//         .select()
//         .eq('category_id', widget.categoryId)
//         .eq('is_active', true)
//         .order('created_at');

//     Set<String> favs = {};

//     if (user != null) {
//       final favData = await supabase
//           .from('favorites')
//           .select('camera_id')
//           .eq('user_id', user.id);

//       favs = favData.map<String>((e) => e['camera_id'] as String).toSet();
//     }

//     if (!mounted) return;

//     setState(() {
//       cameras = camData;
//       favoriteIds = favs;
//       loading = false;
//     });
//   }

//   Future<void> toggleFavorite(String cameraId) async {
//     final user = supabase.auth.currentUser;

//     if (user == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('กรุณาเข้าสู่ระบบก่อน')));
//       return;
//     }

//     if (favoriteIds.contains(cameraId)) {
//       await supabase
//           .from('favorites')
//           .delete()
//           .eq('user_id', user.id)
//           .eq('camera_id', cameraId);

//       setState(() => favoriteIds.remove(cameraId));
//     } else {
//       await supabase.from('favorites').insert({
//         'user_id': user.id,
//         'camera_id': cameraId,
//       });

//       setState(() => favoriteIds.add(cameraId));
//     }
//   }

//   Future<void> addToCart(String cameraId) async {
//     final user = supabase.auth.currentUser;

//     if (user == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('กรุณาเข้าสู่ระบบก่อน')));
//       return;
//     }

//     await supabase.from('carts').upsert({
//       'user_id': user.id,
//       'camera_id': cameraId,
//       'qty': 1,
//     });

//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(const SnackBar(content: Text('เพิ่มลงตะกร้าแล้ว')));
//   }

//   @override
//   Widget build(BuildContext context) {
//     // 🔍 กรองรายการสินค้าตามคำค้นหา
//     final filteredCameras = cameras.where((cam) {
//       final name = (cam['name'] ?? '').toString().toLowerCase();
//       final brand = (cam['brand'] ?? '').toString().toLowerCase();
//       final keyword = _searchKeyword.toLowerCase();
//       return name.contains(keyword) || brand.contains(keyword);
//     }).toList();

//     return Scaffold(
//       backgroundColor: const Color(0xFF3A3A3A),
//       // ----------------------------------------------------------
//       // ⭐ ส่วน AppBar ที่แก้ไขให้เหมือนในรูป
//       // ----------------------------------------------------------
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF3A3A3A),
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white), // สีลูกศรย้อนกลับ
//         titleSpacing: 0, // ลดระยะห่างระหว่างลูกศรกับช่องค้นหา
//         title: Container(
//           height: 40, // ความสูงของแทบ
//           margin: const EdgeInsets.only(right: 16), // เว้นขวานิดนึง
//           decoration: BoxDecoration(
//             color: Colors.white, // พื้นหลังสีขาว
//             borderRadius: BorderRadius.circular(30), // ขอบมนทรงแคปซูล
//           ),
//           child: TextField(
//             onChanged: (value) {
//               setState(() {
//                 _searchKeyword = value; // อัปเดตคำค้นหา
//               });
//             },
//             textAlignVertical: TextAlignVertical.center,
//             decoration: const InputDecoration(
//               hintText: 'ค้นหา',
//               hintStyle: TextStyle(color: Colors.grey),
//               prefixIcon: Icon(
//                 Icons.search,
//                 color: Colors.grey,
//               ), // ไอคอนแว่นขยาย
//               border: InputBorder.none, // ลบเส้นขอบเดิมออก
//               contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
//               isDense: true,
//             ),
//           ),
//         ),
//       ),

//       // ----------------------------------------------------------
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : filteredCameras.isEmpty
//           ? Center(
//               child: Text(
//                 _searchKeyword.isEmpty
//                     ? 'ไม่มีสินค้าในหมวดนี้'
//                     : 'ไม่พบสินค้าที่ค้นหา',
//                 style: const TextStyle(color: Colors.white),
//               ),
//             )
//           : GridView.builder(
//               padding: const EdgeInsets.all(12),
//               itemCount: filteredCameras.length, // ใช้รายการที่กรองแล้ว
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 12,
//                 crossAxisSpacing: 12,
//                 childAspectRatio: 0.65,
//               ),
//               itemBuilder: (_, i) {
//                 final cam = filteredCameras[i]; // ดึงจากรายการที่กรอง

//                 final String id = cam['id'];
//                 final String imageUrl = cam['image_url'] ?? '';
//                 final String name = cam['name'] ?? 'ไม่มีชื่อ';
//                 final String brand = cam['brand'] ?? '-';
//                 final price = cam['price_per_day'] ?? 0;

//                 final isFavorite = favoriteIds.contains(id);

//                 return Container(
//                   decoration: BoxDecoration(
//                     color: Colors.black45,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => CameraDetailPage(camera: cam),
//                               ),
//                             ).then((_) => loadData());
//                           },
//                           child: ClipRRect(
//                             borderRadius: const BorderRadius.vertical(
//                               top: Radius.circular(12),
//                             ),
//                             child: Image.network(
//                               imageUrl,
//                               width: double.infinity,
//                               fit: BoxFit.cover,
//                               errorBuilder: (_, __, ___) => const Icon(
//                                 Icons.broken_image,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               name,
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               brand,
//                               style: const TextStyle(color: Colors.white70),
//                             ),
//                             Text(
//                               '฿$price / วัน',
//                               style: const TextStyle(
//                                 color: Colors.orangeAccent,
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 IconButton(
//                                   icon: Icon(
//                                     isFavorite
//                                         ? Icons.favorite
//                                         : Icons.favorite_border,
//                                     color: Colors.red,
//                                   ),
//                                   onPressed: () => toggleFavorite(id),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(
//                                     Icons.shopping_cart,
//                                     color: Colors.green,
//                                   ),
//                                   onPressed: () => addToCart(id),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'camera_detail_page.dart';

class CameraListByCategory extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const CameraListByCategory({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<CameraListByCategory> createState() => _CameraListByCategoryState();
}

class _CameraListByCategoryState extends State<CameraListByCategory> {
  final supabase = Supabase.instance.client;

  List cameras = [];
  Set<String> favoriteIds = {};
  bool loading = true;

  // 🔍 ตัวแปรสำหรับเก็บคำค้นหา
  String _searchKeyword = '';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    if (!mounted) return;

    setState(() => loading = true);

    final user = supabase.auth.currentUser;

    final camData = await supabase
        .from('cameras')
        .select()
        .eq('category_id', widget.categoryId)
        .eq('is_active', true)
        .order('created_at');

    Set<String> favs = {};

    if (user != null) {
      final favData = await supabase
          .from('favorites')
          .select('camera_id')
          .eq('user_id', user.id);

      favs = favData.map<String>((e) => e['camera_id'] as String).toSet();
    }

    if (!mounted) return;

    setState(() {
      cameras = camData;
      favoriteIds = favs;
      loading = false;
    });
  }

  Future<void> toggleFavorite(String cameraId) async {
    final user = supabase.auth.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('กรุณาเข้าสู่ระบบก่อน')));
      return;
    }

    if (favoriteIds.contains(cameraId)) {
      await supabase
          .from('favorites')
          .delete()
          .eq('user_id', user.id)
          .eq('camera_id', cameraId);

      setState(() => favoriteIds.remove(cameraId));
    } else {
      await supabase.from('favorites').insert({
        'user_id': user.id,
        'camera_id': cameraId,
      });

      setState(() => favoriteIds.add(cameraId));
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🔍 กรองรายการสินค้าตามคำค้นหา
    final filteredCameras = cameras.where((cam) {
      final name = (cam['name'] ?? '').toString().toLowerCase();
      final brand = (cam['brand'] ?? '').toString().toLowerCase();
      final keyword = _searchKeyword.toLowerCase();
      return name.contains(keyword) || brand.contains(keyword);
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF3A3A3A),
      // ----------------------------------------------------------
      // ⭐ ส่วน AppBar
      // ----------------------------------------------------------
      appBar: AppBar(
        backgroundColor: const Color(0xFF3A3A3A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white), 
        titleSpacing: 0, 
        title: Container(
          height: 40, 
          margin: const EdgeInsets.only(right: 16), 
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(30), 
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                _searchKeyword = value; 
              });
            },
            textAlignVertical: TextAlignVertical.center,
            decoration: const InputDecoration(
              hintText: 'ค้นหา',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ), 
              border: InputBorder.none, 
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              isDense: true,
            ),
          ),
        ),
      ),

      // ----------------------------------------------------------
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : filteredCameras.isEmpty
          ? Center(
              child: Text(
                _searchKeyword.isEmpty
                    ? 'ไม่มีสินค้าในหมวดนี้'
                    : 'ไม่พบสินค้าที่ค้นหา',
                style: const TextStyle(color: Colors.white),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredCameras.length, 
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (_, i) {
                final cam = filteredCameras[i]; 

                final String id = cam['id'];
                final String imageUrl = cam['image_url'] ?? '';
                final String name = cam['name'] ?? 'ไม่มีชื่อ';
                final String brand = cam['brand'] ?? '-';
                final price = cam['price_per_day'] ?? 0;

                final isFavorite = favoriteIds.contains(id);

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CameraDetailPage(camera: cam),
                              ),
                            ).then((_) => loadData());
                          },
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.network(
                              imageUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.broken_image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              brand,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              '฿$price / วัน',
                              style: const TextStyle(
                                color: Colors.orangeAccent,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => toggleFavorite(id),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.shopping_cart,
                                    color: Colors.green,
                                  ),
                                  onPressed: () {
                                    // เปลี่ยนให้เด้งไปหน้า Detail แทนการเอาลงตะกร้าตรงๆ
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => CameraDetailPage(camera: cam),
                                      ),
                                    ).then((_) => loadData());
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}