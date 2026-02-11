// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'camera_list_by_category.dart';

// class CategoryUser extends StatefulWidget {
//   const CategoryUser({super.key});

//   @override
//   State<CategoryUser> createState() => _CategoryUserState();
// }

// class _CategoryUserState extends State<CategoryUser> {
//   final supabase = Supabase.instance.client;
//   late Future<List<dynamic>> categories;
//   String keyword = '';

//   @override
//   void initState() {
//     super.initState();
//     categories = _fetchCategories();
//   }

//   Future<List<dynamic>> _fetchCategories() async {
//     return await supabase
//         .from('camera_categories')
//         .select()
//         .order('created_at');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF3A3A3A),
//       appBar: AppBar(backgroundColor: const Color(0xFF3A3A3A), elevation: 0),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // 🔍 SEARCH
//           Padding(
//             padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
//             child: Container(
//               height: 48,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: TextField(
//                 onChanged: (v) => setState(() => keyword = v),
//                 decoration: const InputDecoration(
//                   hintText: 'ค้นหา',
//                   prefixIcon: Icon(Icons.search),
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ),

//           const Padding(
//             padding: EdgeInsets.fromLTRB(16, 16, 0, 8),
//             child: Text(
//               'ประเภทกล้อง',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),

//           Expanded(
//             child: FutureBuilder<List<dynamic>>(
//               future: categories,
//               builder: (_, s) {
//                 if (!s.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 final filtered = s.data!.where((item) {
//                   return item['name_manu'].toString().toLowerCase().contains(
//                     keyword.toLowerCase(),
//                   );
//                 }).toList();

//                 if (filtered.isEmpty) {
//                   return const Center(
//                     child: Text(
//                       'ไม่พบข้อมูล',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   );
//                 }

//                 return GridView.builder(
//                   padding: const EdgeInsets.all(12),
//                   itemCount: filtered.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 12,
//                     crossAxisSpacing: 12,
//                     childAspectRatio: 0.75,
//                   ),
//                   itemBuilder: (_, i) {
//                     final item = filtered[i];

//                     return InkWell(
//                       borderRadius: BorderRadius.circular(12),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => CameraListByCategory(
//                               categoryId: item['id'],
//                               categoryName: item['name_manu'],
//                             ),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.black45,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Column(
//                           children: [
//                             Expanded(
//                               child: ClipRRect(
//                                 borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(12),
//                                   topRight: Radius.circular(12),
//                                 ),
//                                 child: Image.network(
//                                   item['image_camera_manu'],
//                                   width: double.infinity,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8),
//                               child: Text(
//                                 item['name_manu'],
//                                 textAlign: TextAlign.center,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; // <--- เพิ่มตรงนี้

// class CheckoutPage extends StatefulWidget {
//   final List<dynamic> selectedItems;

//   const CheckoutPage({super.key, required this.selectedItems});

//   @override
//   State<CheckoutPage> createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   int _paymentMethod = 1;
//   String? _slipFileName;

//   // ฟังก์ชันคำนวณยอดรวมเบื้องต้น (ราคา x จำนวนวัน)
//   int calculateTotal() {
//     int total = 0;
//     for (var item in widget.selectedItems) {
//       final cam = item['cameras'];
//       final price = int.tryParse(cam['price_per_day'].toString()) ?? 0;
      
//       final startStr = item['start_date'];
//       final endStr = item['end_date'];
//       int daysToRent = 1; // ค่าเริ่มต้นขั้นต่ำ 1 วัน

//       if (startStr != null && endStr != null) {
//         try {
//           final start = DateTime.parse(startStr);
//           final end = DateTime.parse(endStr);
//           daysToRent = end.difference(start).inDays;
//           // ถ้าเช่าเช้า คืนเย็น (วันเดียวกัน) ให้นับเป็น 1 วัน
//           if (daysToRent == 0) daysToRent = 1; 
//         } catch (e) {
//           daysToRent = 1;
//         }
//       }
//       // เอา ราคา * จำนวนวัน
//       total += (price * daysToRent);
//     }
//     return total;
//   }

//   // ฟังก์ชันแปลงวันที่ให้ดูง่าย
//   String _formatDateRange(String? startStr, String? endStr) {
//     if (startStr == null || endStr == null) return 'ไม่ระบุวันที่';
//     try {
//       final start = DateTime.parse(startStr);
//       final end = DateTime.parse(endStr);
//       final format = DateFormat('dd MMM yyyy');
//       return '${format.format(start)} ถึง ${format.format(end)}';
//     } catch (e) {
//       return 'รูปแบบวันผิดพลาด';
//     }
//   }

//   // คำนวณจำนวนวันมาโชว์ใน UI
//   int _calculateDays(String? startStr, String? endStr) {
//     if (startStr == null || endStr == null) return 1;
//     try {
//       final start = DateTime.parse(startStr);
//       final end = DateTime.parse(endStr);
//       int days = end.difference(start).inDays;
//       return days == 0 ? 1 : days;
//     } catch (e) {
//       return 1;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final int totalPrice = calculateTotal();

//     return Scaffold(
//       backgroundColor: const Color(0xFF757575),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF757575),
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: Container(
//           height: 40,
//           decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
//           child: const TextField(decoration: InputDecoration(hintText: 'ค้นหา...', prefixIcon: Icon(Icons.search, color: Colors.grey), border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 10))),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text('สรุปคำสั่งซื้อ', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 16),

//             // --- 1. รายการสินค้าที่เลือก ---
//             ...widget.selectedItems.map((item) {
//               final cam = item['cameras'];
//               final isActive = cam['is_active'] ?? false;
//               final brand = cam['brand'] ?? 'Canon';
//               final pricePerDay = cam['price_per_day'] ?? 0;
              
//               final dateRangeText = _formatDateRange(item['start_date'], item['end_date']);
//               final rentDays = _calculateDays(item['start_date'], item['end_date']);

//               return Container(
//                 margin: const EdgeInsets.only(bottom: 12),
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(cam['name'] ?? 'ไม่ระบุชื่อ', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
//                     const SizedBox(height: 12),
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(cam['image_url'] ?? '', width: 80, height: 80, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: 80, height: 80, color: Colors.grey[800], child: const Icon(Icons.camera_alt, color: Colors.white)))),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   const Text('สถานะ: ', style: TextStyle(color: Colors.grey, fontSize: 12)),
//                                   Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: isActive ? Colors.green : Colors.redAccent, borderRadius: BorderRadius.circular(10)), child: Text(isActive ? 'ว่าง' : 'ไม่ว่าง', style: const TextStyle(color: Colors.white, fontSize: 12))),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                               Row(
//                                 children: [
//                                   Text('$pricePerDay/วัน', style: const TextStyle(color: Colors.white, fontSize: 12)),
//                                   const Spacer(),
//                                   const Text('แบรนด์ ', style: TextStyle(color: Colors.grey, fontSize: 12)),
//                                   Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)), child: Text(brand, style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold))),
//                                 ],
//                               ),
//                               const SizedBox(height: 12),
//                               // โชว์ระยะเวลาเช่า
//                               Container(
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(8)),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text('📅 $dateRangeText', style: const TextStyle(color: Colors.orangeAccent, fontSize: 12)),
//                                     const SizedBox(height: 4),
//                                     Text('รวมระยะเวลา: $rentDays วัน', style: const TextStyle(color: Colors.white70, fontSize: 12)),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),

//             // --- 2. สรุปราคา ---
//             Container(
//               margin: const EdgeInsets.only(bottom: 12),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('สรุปราคา', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 16),
//                   Text('ค่าบริการเช่ารวมทั้งหมด: $totalPrice ฿', style: const TextStyle(color: Colors.white)),
//                   const SizedBox(height: 16),
//                   Align(alignment: Alignment.centerRight, child: Text('ยอดรวมต้องชำระ: $totalPrice ฿', style: const TextStyle(color: Colors.orangeAccent, fontSize: 18, fontWeight: FontWeight.bold)))
//                 ],
//               ),
//             ),

//             // --- 3. วิธีชำระเงิน ---
//             Container(
//               margin: const EdgeInsets.only(bottom: 12),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('วิธีชำระเงิน', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 8),
//                   RadioListTile<int>(value: 1, groupValue: _paymentMethod, onChanged: (val) => setState(() => _paymentMethod = val!), title: const Text('พร้อมเพย์ทางร้าน', style: TextStyle(color: Colors.white, fontSize: 14)), activeColor: Colors.white, contentPadding: EdgeInsets.zero),
//                   if (_paymentMethod == 1) Center(child: Container(margin: const EdgeInsets.symmetric(vertical: 8), width: 120, height: 120, color: Colors.white, child: const Center(child: Text('QR Code', style: TextStyle(color: Colors.black))))),
//                   RadioListTile<int>(value: 2, groupValue: _paymentMethod, onChanged: (val) => setState(() => _paymentMethod = val!), title: const Text('โอนบัญชีธนาคาร', style: TextStyle(color: Colors.white, fontSize: 14)), activeColor: Colors.white, contentPadding: EdgeInsets.zero),
//                 ],
//               ),
//             ),

//             // --- 4. แนบสลิปการโอน ---
//             Container(
//               margin: const EdgeInsets.only(bottom: 24),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text('แนบสลิปการโอน', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       ElevatedButton(onPressed: () { setState(() { _slipFileName = "slip_image_01.jpg"; }); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[600], foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), child: const Text('Choose File')),
//                       const SizedBox(width: 12),
//                       Expanded(child: Text(_slipFileName ?? 'No File chosen', style: const TextStyle(color: Colors.white70, fontSize: 12), overflow: TextOverflow.ellipsis))
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // --- 5. ปุ่มส่งการจอง ---
//             Center(
//               child: ElevatedButton(
//                 onPressed: () { print("ส่งการจอง ยอดรวม $totalPrice บาท สำเร็จ!"); },
//                 style: ElevatedButton.styleFrom(backgroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
//                 child: const Text('ส่งการจองให้ทางร้าน', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
//               ),
//             ),
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'camera_list_by_category.dart';

class CategoryUser extends StatefulWidget {
  const CategoryUser({super.key});

  @override
  State<CategoryUser> createState() => _CategoryUserState();
}

class _CategoryUserState extends State<CategoryUser> {
  final supabase = Supabase.instance.client;
  late Future<List<dynamic>> categories;
  String keyword = '';

  @override
  void initState() {
    super.initState();
    categories = _fetchCategories();
  }

  Future<List<dynamic>> _fetchCategories() async {
    return await supabase
        .from('camera_categories')
        .select()
        .order('created_at');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3A3A3A),
      appBar: AppBar(backgroundColor: const Color(0xFF3A3A3A), elevation: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔍 SEARCH
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                onChanged: (v) => setState(() => keyword = v),
                decoration: const InputDecoration(
                  hintText: 'ค้นหา',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 0, 8),
            child: Text(
              'ประเภทกล้อง',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: categories,
              builder: (_, s) {
                if (!s.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final filtered = s.data!.where((item) {
                  return item['name_manu'].toString().toLowerCase().contains(
                    keyword.toLowerCase(),
                  );
                }).toList();

                if (filtered.isEmpty) {
                  return const Center(
                    child: Text(
                      'ไม่พบข้อมูล',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: filtered.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (_, i) {
                    final item = filtered[i];

                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CameraListByCategory(
                              categoryId: item['id'],
                              categoryName: item['name_manu'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Image.network(
                                  item['image_camera_manu'],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                item['name_manu'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}