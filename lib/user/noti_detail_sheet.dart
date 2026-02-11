// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class NotiDetailSheet extends StatelessWidget {
//   final dynamic data;

//   const NotiDetailSheet({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     final camera = data['cameras'];
    
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.7,
//       decoration: const BoxDecoration(
//         color: Color(0xFF1E1E1E),
//         borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
//       ),
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Center(
//             child: Container(
//               width: 40,
//               height: 4,
//               decoration: const BoxDecoration(
//                 color: Colors.white24,
//                 borderRadius: BorderRadius.all(Radius.circular(2)),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           const Text("สรุปรายการเช่า", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
//           Text(
//             DateFormat('dd MMM yyyy • HH:mm').format(DateTime.parse(data['created_at'])), 
//             style: const TextStyle(color: Colors.white54, fontSize: 13)
//           ),
//           const SizedBox(height: 20),
          
//           // ส่วนแสดงรูปและชื่อกล้อง
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(18)),
//             child: Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.network(
//                     camera['image_url'] ?? '', 
//                     width: 70, height: 70, fit: BoxFit.cover, 
//                     errorBuilder: (c, e, s) => Container(width: 70, height: 70, color: Colors.grey)
//                   ),
//                 ),
//                 const SizedBox(width: 15),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(camera['name'] ?? '', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                       Text("แบรนด์: ${camera['brand']}", style: const TextStyle(color: Colors.white60, fontSize: 12)),
//                       const Text("จำนวน: 1", style: TextStyle(color: Colors.white60, fontSize: 12)),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(height: 25),
          
//           // รายละเอียดวันที่และราคา
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildDateInfo("วันที่เช่า", data['start_date'] ?? "-"),
//               _buildDateInfo("วันที่คืน", data['end_date'] ?? "-"),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               _buildDateInfo("ยอดรวมชำระ", "฿${data['total_price']}"),
//               _buildDateInfo("สถานะ", (data['status'] as String).toUpperCase()),
//             ],
//           ),
//           const Spacer(),
//           SizedBox(
//             width: double.infinity,
//             height: 50,
//             child: ElevatedButton(
//               onPressed: () => Navigator.pop(context),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFE4AD5E), 
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
//               ),
//               child: const Text("ปิดหน้าต่าง", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//             ),
//           ),
//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }

//   Widget _buildDateInfo(String label, String value) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: const TextStyle(color: Colors.white38, fontSize: 12)),
//         const SizedBox(height: 4),
//         Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotiDetailSheet extends StatelessWidget {
  final dynamic data;

  const NotiDetailSheet({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // ดึงข้อมูลกล้องจาก Map data (เพิ่มการเช็ค null ป้องกัน error)
    final camera = data['cameras'] ?? {};
    const bg = Color(0xFF3A3A3A);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Header (ช่องค้นหา) ---
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.black54),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text("ค้นหาการแจ้งเตือน...", style: TextStyle(color: Colors.black45, fontSize: 13)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // --- หัวข้อ "การแจ้งเตือน" และปุ่มย้อนกลับ ---
              Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(999),
                      onTap: () => Navigator.pop(context), // ⭐ ปุ่มย้อนกลับ
                      child: Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.12),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text("การแจ้งเตือน", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                ],
              ),
              const SizedBox(height: 20),

              // --- กล่องดำ (รายละเอียดการแจ้งเตือน) เหมือนในรูป ---
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black, // สีพื้นหลังกล่องเป็นสีดำ
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("เพิ่มลงตะกร้าเรียบร้อยแล้ว", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('dd MMM yyyy • HH:mm').format(
                            data['created_at'] != null ? DateTime.parse(data['created_at']) : DateTime.now()
                          ), 
                          style: const TextStyle(color: Colors.white70, fontSize: 11)
                        ),
                        const SizedBox(height: 20),
                        
                        // --- การ์ดสินค้า ---
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15), // สีเทาโปร่งใสเหมือนในรูป
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  camera['image_url'] ?? '', 
                                  width: 60, height: 60, fit: BoxFit.cover, 
                                  errorBuilder: (c, e, s) => Container(width: 60, height: 60, color: Colors.grey[800])
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(camera['name'] ?? 'ไม่ระบุชื่อสินค้า', style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 4),
                                    const Text("สี: ดำ", style: TextStyle(color: Colors.white70, fontSize: 11)),
                                    const SizedBox(height: 2),
                                    const Text("จำนวน: 1", style: TextStyle(color: Colors.white70, fontSize: 11)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        
                        // --- ข้อมูลวันที่ ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDateInfo("วันที่เช่า", data['start_date'] ?? "-"),
                            _buildDateInfo("วันที่คืน", data['end_date'] ?? "-"),
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        // --- ข้อมูลราคา ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDateInfo("ราคา / วัน", "${camera['price_per_day'] ?? 0}"),
                            _buildDateInfo("สินค้าในตะกร้า", "1 รายการ"),
                          ],
                        ),
                        const SizedBox(height: 30),
                        
                        // --- ปุ่มแก้ไขรายการ ---
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              // TODO: ใส่คำสั่งให้กลับไปหน้า CartUser
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFE4AD5E), // สีปุ่มส้มทอง
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                            ),
                            child: const Text("แก้ไขรายการ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100), // กันเมนูด้านล่างบัง
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 11)),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }
}