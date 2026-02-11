// // import 'package:flutter/material.dart';

// // class HomeAdmin extends StatefulWidget {
// //   const HomeAdmin({super.key});

// //   @override
// //   State<HomeAdmin> createState() => _HomeAdminState();
// // }

// // class _HomeAdminState extends State<HomeAdmin> {
// //   int _currentIndex = 0;

// //   @override
// //   Widget build(BuildContext context) {
// //     const bg = Color(0xFF5B5B5B); // เทาเข้มคล้ายรูป
// //     return Scaffold(
// //       backgroundColor: bg,
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const Text(
// //                 "Dashboard",
// //                 style: TextStyle(
// //                   color: Colors.white,
// //                   fontSize: 28,
// //                   fontWeight: FontWeight.w500,
// //                 ),
// //               ),
// //               const SizedBox(height: 12),

// //               // ====== 2x2 STAT CARDS ======
// //               Row(
// //                 children: const [
// //                   Expanded(child: _StatCard(title: "จำนวนกล้อง", value: "323")),
// //                   SizedBox(width: 12),
// //                   Expanded(child: _StatCard(title: "คำสั่งซื้อรอดำเนินการ", value: "15")),
// //                 ],
// //               ),
// //               const SizedBox(height: 12),
// //               Row(
// //                 children: const [
// //                   Expanded(child: _StatCard(title: "รายได้รวม", value: "1234")),
// //                   SizedBox(width: 12),
// //                   Expanded(child: _StatCard(title: "จำนวนผู้ใช้ทั้งหมด", value: "101")),
// //                 ],
// //               ),
// //               const SizedBox(height: 12),

// //               // ====== CHART CARD ======
// //               Container(
// //                 width: double.infinity,
// //                 padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
// //                 decoration: BoxDecoration(
// //                   color: const Color(0xFFE9E9E9),
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: const [
// //                     Text(
// //                       "สถิติรายได้",
// //                       style: TextStyle(
// //                         fontSize: 14,
// //                         fontWeight: FontWeight.w600,
// //                         color: Colors.black87,
// //                       ),
// //                     ),
// //                     SizedBox(height: 8),
// //                     SizedBox(
// //                       height: 120,
// //                       child: _MiniLineChart(),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 12),

// //               // ====== RECENT ACTIVITY ======
// //               Expanded(
// //                 child: Container(
// //                   width: double.infinity,
// //                   padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
// //                   decoration: BoxDecoration(
// //                     color: const Color(0xFFE9E9E9),
// //                     borderRadius: BorderRadius.circular(12),
// //                   ),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       const Text(
// //                         "กิจกรรมล่าสุด",
// //                         style: TextStyle(
// //                           fontSize: 14,
// //                           fontWeight: FontWeight.w600,
// //                           color: Colors.black87,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 10),

// //                       Expanded(
// //                         child: ListView(
// //                           physics: const BouncingScrollPhysics(),
// //                           children: const [
// //                             _ActivityTile(
// //                               iconBg: Color(0xFF1E88E5),
// //                               icon: Icons.shopping_bag_rounded,
// //                               title: "มีออเดอร์ใหม่จากลูกค้า",
// //                               subtitle: "348 วินาทีที่แล้ว",
// //                             ),
// //                             SizedBox(height: 8),
// //                             _ActivityTile(
// //                               iconBg: Color(0xFF8D8D8D),
// //                               icon: Icons.camera_alt_rounded,
// //                               title: "Sony A7IV ถูกเพิ่มไปในตะกร้า",
// //                               subtitle: "348 วินาทีที่แล้ว",
// //                             ),
// //                             SizedBox(height: 8),
// //                             _ActivityTile(
// //                               iconBg: Color(0xFF2E7D32),
// //                               icon: Icons.check_circle_rounded,
// //                               title: "คำสั่งซื้อ OR-102 ได้รับการอนุมัติ",
// //                               subtitle: "348 วินาทีที่แล้ว",
// //                             ),
// //                             SizedBox(height: 8),
// //                             _ActivityTile(
// //                               iconBg: Color(0xFFB26A00),
// //                               icon: Icons.settings_rounded,
// //                               title: "Canon RF 24-70mm ถูกอัปเดต",
// //                               subtitle: "348 วินาทีที่แล้ว",
// //                             ),
// //                           ],
// //                         ),
// //                       ),

// //                       const SizedBox(height: 6),
// //                       Align(
// //                         alignment: Alignment.centerRight,
// //                         child: Text(
// //                           "ดูทั้งหมด",
// //                           style: TextStyle(
// //                             color: Colors.black.withOpacity(0.55),
// //                             fontSize: 12,
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                       )
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),

// //       // ====== BOTTOM NAV ======
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _currentIndex,
// //         onTap: (i) => setState(() => _currentIndex = i),
// //         type: BottomNavigationBarType.fixed,
// //         selectedItemColor: const Color(0xFF1E88E5),
// //         unselectedItemColor: Colors.black54,
// //         showSelectedLabels: false,
// //         showUnselectedLabels: false,
// //         items: const [
// //           BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
// //           BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: "Menu"),
// //           BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "Orders"),
// //           BottomNavigationBarItem(icon: Icon(Icons.favorite_border_rounded), label: "Fav"),
// //           BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: "Profile"),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // ---------- STAT CARD ----------
// // class _StatCard extends StatelessWidget {
// //   final String title;
// //   final String value;
// //   const _StatCard({required this.title, required this.value});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: 92,
// //       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFFE9E9E9),
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Text(
// //             title,
// //             maxLines: 1,
// //             overflow: TextOverflow.ellipsis,
// //             style: const TextStyle(
// //               fontSize: 12,
// //               color: Colors.black87,
// //               fontWeight: FontWeight.w600,
// //             ),
// //           ),
// //           const Spacer(),
// //           Text(
// //             value,
// //             style: const TextStyle(
// //               fontSize: 34,
// //               fontWeight: FontWeight.w500,
// //               color: Colors.black,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // ---------- ACTIVITY TILE ----------
// // class _ActivityTile extends StatelessWidget {
// //   final Color iconBg;
// //   final IconData icon;
// //   final String title;
// //   final String subtitle;

// //   const _ActivityTile({
// //     required this.iconBg,
// //     required this.icon,
// //     required this.title,
// //     required this.subtitle,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
// //       decoration: BoxDecoration(
// //         color: Colors.white.withOpacity(0.7),
// //         borderRadius: BorderRadius.circular(12),
// //       ),
// //       child: Row(
// //         children: [
// //           Container(
// //             width: 38,
// //             height: 38,
// //             decoration: BoxDecoration(
// //               color: iconBg,
// //               borderRadius: BorderRadius.circular(10),
// //             ),
// //             child: Icon(icon, color: Colors.white, size: 20),
// //           ),
// //           const SizedBox(width: 10),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   title,
// //                   maxLines: 1,
// //                   overflow: TextOverflow.ellipsis,
// //                   style: const TextStyle(
// //                     fontSize: 13,
// //                     fontWeight: FontWeight.w600,
// //                     color: Colors.black87,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 2),
// //                 Text(
// //                   subtitle,
// //                   style: TextStyle(
// //                     fontSize: 11,
// //                     color: Colors.black.withOpacity(0.55),
// //                     fontWeight: FontWeight.w500,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // // ---------- MINI LINE CHART (CustomPainter) ----------
// // class _MiniLineChart extends StatelessWidget {
// //   const _MiniLineChart();

// //   @override
// //   Widget build(BuildContext context) {
// //     return CustomPaint(
// //       painter: _MiniLineChartPainter(),
// //       child: const SizedBox.expand(),
// //     );
// //   }
// // }

// // class _MiniLineChartPainter extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     // แกนล่าง (ขีด ๆ ฟ้า)
// //     final axisPaint = Paint()
// //       ..color = const Color(0xFF2BB5FF)
// //       ..strokeWidth = 2
// //       ..style = PaintingStyle.stroke;

// //     final baseY = size.height - 12;
// //     for (int i = 0; i < 14; i++) {
// //       final x = (size.width / 14) * i;
// //       canvas.drawLine(
// //         Offset(x, baseY),
// //         Offset(x, baseY + (i % 2 == 0 ? 8 : 5)),
// //         axisPaint,
// //       );
// //     }

// //     // เส้นกราฟ (แดง/ส้ม) + จุด
// //     final points = <Offset>[
// //       Offset(size.width * 0.10, size.height * 0.72),
// //       Offset(size.width * 0.30, size.height * 0.52),
// //       Offset(size.width * 0.50, size.height * 0.66),
// //       Offset(size.width * 0.70, size.height * 0.40),
// //       Offset(size.width * 0.85, size.height * 0.48),
// //     ];

// //     final linePaint = Paint()
// //       ..color = const Color(0xFFFF6B5A)
// //       ..strokeWidth = 3
// //       ..style = PaintingStyle.stroke
// //       ..strokeCap = StrokeCap.round;

// //     final path = Path()..moveTo(points.first.dx, points.first.dy);
// //     for (int i = 1; i < points.length; i++) {
// //       path.lineTo(points[i].dx, points[i].dy);
// //     }
// //     canvas.drawPath(path, linePaint);

// //     final dotPaint = Paint()..color = const Color(0xFFFFC107);
// //     for (final p in points) {
// //       canvas.drawCircle(p, 5, dotPaint);
// //     }
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// // }



// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart'; // <--- เพิ่ม Import Supabase

// class HomeAdmin extends StatefulWidget {
//   const HomeAdmin({super.key});

//   @override
//   State<HomeAdmin> createState() => _HomeAdminState();
// }

// class _HomeAdminState extends State<HomeAdmin> {
//   int _currentIndex = 0;
  
//   // ⭐ เพิ่มตัวแปรสำหรับเก็บข้อมูลจากฐานข้อมูล
//   bool _isLoading = true;
//   int totalCameras = 0;
//   int pendingOrders = 0;
//   int totalRevenue = 0;
//   int totalUsers = 0;

//   @override
//   void initState() {
//     super.initState();
//     _fetchDashboardData(); // เรียกใช้ฟังก์ชันดึงข้อมูลตอนเปิดหน้า
//   }

//   // ⭐ ฟังก์ชันดึงข้อมูลสถิติจาก Supabase
//   Future<void> _fetchDashboardData() async {
//     try {
//       final supabase = Supabase.instance.client;
      
//       // 1. นับจำนวนกล้องทั้งหมดในคลัง
//       final cameraRes = await supabase.from('cameras').select('id');
      
//       // 2. ดึงข้อมูลออเดอร์ (อันนี้จำลองไว้ก่อน รอคุณสร้างตาราง orders)
//       /*
//       final orderRes = await supabase.from('orders').select('status, total_price');
//       int pending = 0;
//       int revenue = 0;
//       for (var order in orderRes) {
//         if (order['status'] == 'pending') pending++; 
//         revenue += (order['total_price'] as num).toInt(); 
//       }
//       */

//       // 3. นับจำนวนผู้ใช้งานระบบ (รอสร้างตารางผู้ใช้)
//       /*
//       final userRes = await supabase.from('profiles').select('id');
//       */

//       // อัปเดตหน้าจอ
//       setState(() {
//         totalCameras = cameraRes.length; // ดึงของจริงมาโชว์
//         pendingOrders = 15; // ข้อมูลจำลอง
//         totalRevenue = 1234; // ข้อมูลจำลอง
//         totalUsers = 101; // ข้อมูลจำลอง
//         _isLoading = false; // ปิดสถานะโหลด
//       });
//     } catch (e) {
//       print('Error: $e');
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     const bg = Color(0xFF5B5B5B); 
    
//     return Scaffold(
//       backgroundColor: bg,
//       body: SafeArea(
//         // ⭐ เพิ่มตัวเช็คสถานะการโหลด
//         child: _isLoading 
//         ? const Center(child: CircularProgressIndicator(color: Colors.white))
//         : Padding(
//           padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "Dashboard",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 28,
//                   fontFamily: 'Serif', // เปลี่ยนฟอนต์ให้มีหัวตามรูป
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // ====== 2x2 STAT CARDS (ดึงตัวแปรมาใช้) ======
//               Row(
//                 children: [
//                   Expanded(child: _StatCard(title: "จำนวนกล้อง", value: totalCameras.toString())),
//                   const SizedBox(width: 12),
//                   Expanded(child: _StatCard(title: "คำสั่งซื้อรอดำเนินการ", value: pendingOrders.toString())),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 children: [
//                   Expanded(child: _StatCard(title: "รายได้รวม", value: totalRevenue.toString())),
//                   const SizedBox(width: 12),
//                   Expanded(child: _StatCard(title: "จำนวนผู้ใช้ทั้งหมด", value: totalUsers.toString())),
//                 ],
//               ),
//               const SizedBox(height: 12),

//               // ====== CHART CARD ======
//               Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFE9E9E9),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       "สถิติรายได้",
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     SizedBox(
//                       height: 120,
//                       child: _MiniLineChart(),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // ====== RECENT ACTIVITY ======
//               Expanded(
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFE9E9E9),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "กิจกรรมล่าสุด",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 10),

//                       Expanded(
//                         child: ListView(
//                           physics: const BouncingScrollPhysics(),
//                           children: const [
//                             _ActivityTile(
//                               iconBg: Color(0xFF1E88E5),
//                               icon: Icons.receipt_long, // เปลี่ยนไอคอนให้ตรงรูป
//                               title: "มีสลิปใหม่ถูกอัปโหลดจาก สมชาย ใจดี",
//                               subtitle: "348 วันที่แล้ว",
//                             ),
//                             SizedBox(height: 8),
//                             _ActivityTile(
//                               iconBg: Color(0xFF8D8D8D),
//                               icon: Icons.settings_backup_restore,
//                               title: "Sony A7IV ถูกคืนแล้วโดย สมหญิง รักสวย",
//                               subtitle: "348 วันที่แล้ว",
//                             ),
//                             SizedBox(height: 8),
//                             _ActivityTile(
//                               iconBg: Color(0xFF2E7D32),
//                               icon: Icons.check_circle_outline,
//                               title: "คำสั่งเช่า ORD-002 ได้รับการอนุมัติ",
//                               subtitle: "348 วันที่แล้ว",
//                             ),
//                             SizedBox(height: 8),
//                             _ActivityTile(
//                               iconBg: Color(0xFFB26A00),
//                               icon: Icons.build,
//                               title: "Canon RF 24-70mm ส่งเข้าซ่อม",
//                               subtitle: "348 วันที่แล้ว",
//                             ),
//                           ],
//                         ),
//                       ),

//                       const SizedBox(height: 6),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           "ดูทั้งหมด",
//                           style: TextStyle(
//                             color: Colors.black.withOpacity(0.55),
//                             fontSize: 12,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),

//       // ====== BOTTOM NAV ======
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (i) => setState(() => _currentIndex = i),
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: const Color(0xFF1E88E5),
//         unselectedItemColor: Colors.black54,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: "Menu"),
//           BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "Orders"),
//           BottomNavigationBarItem(icon: Icon(Icons.favorite_border_rounded), label: "Fav"),
//           BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }

// // ---------- STAT CARD ----------
// class _StatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   const _StatCard({required this.title, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 92,
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE9E9E9),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center, // จัดให้อยู่ตรงกลางตามรูป
//         children: [
//           Text(
//             title,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(
//               fontSize: 12,
//               color: Colors.black87,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const Spacer(),
//           Text(
//             value,
//             style: const TextStyle(
//               fontSize: 34,
//               fontFamily: 'Serif', // ฟอนต์มีหัว
//               fontWeight: FontWeight.w400,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ---------- ACTIVITY TILE ----------
// class _ActivityTile extends StatelessWidget {
//   final Color iconBg;
//   final IconData icon;
//   final String title;
//   final String subtitle;

//   const _ActivityTile({
//     required this.iconBg,
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.7),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 38,
//             height: 38,
//             decoration: BoxDecoration(
//               color: iconBg,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Icon(icon, color: Colors.white, size: 20),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   subtitle,
//                   style: TextStyle(
//                     fontSize: 11,
//                     color: Colors.black.withOpacity(0.55),
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ---------- MINI LINE CHART (CustomPainter) ----------
// class _MiniLineChart extends StatelessWidget {
//   const _MiniLineChart();

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: _MiniLineChartPainter(),
//       child: const SizedBox.expand(),
//     );
//   }
// }

// class _MiniLineChartPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     // แกนล่าง (สีฟ้าแบบในรูป)
//     final axisPaint = Paint()
//       ..color = const Color(0xFF00E5FF)
//       ..strokeWidth = 3
//       ..style = PaintingStyle.stroke;

//     // วาดเส้นแกน X และ Y (ตัว L)
//     final pathAxis = Path()
//       ..moveTo(0, 0)
//       ..lineTo(0, size.height)
//       ..lineTo(size.width, size.height);
//     canvas.drawPath(pathAxis, axisPaint);

//     // ขีดเล็กๆ บนแกน X
//     for (int i = 1; i <= 10; i++) {
//       final x = (size.width / 11) * i;
//       canvas.drawLine(
//         Offset(x, size.height),
//         Offset(x, size.height - 5),
//         axisPaint,
//       );
//     }

//     // เส้นกราฟ (สีแดง) + จุด (สีเหลือง)
//     final points = <Offset>[
//       Offset(size.width * 0.1, size.height * 0.8),
//       Offset(size.width * 0.3, size.height * 0.5),
//       Offset(size.width * 0.5, size.height * 0.7),
//       Offset(size.width * 0.7, size.height * 0.3),
//     ];

//     final linePaint = Paint()
//       ..color = const Color(0xFFFF5C5C) // สีเส้นกราฟแดงอมชมพู
//       ..strokeWidth = 4
//       ..style = PaintingStyle.stroke
//       ..strokeJoin = StrokeJoin.round;

//     final path = Path()..moveTo(points.first.dx, points.first.dy);
//     for (int i = 1; i < points.length; i++) {
//       path.lineTo(points[i].dx, points[i].dy);
//     }
//     canvas.drawPath(path, linePaint);

//     // วาดจุดวงกลมสีเหลืองทับ
//     final dotPaint = Paint()..color = const Color(0xFFFFC107);
//     for (final p in points) {
//       canvas.drawCircle(p, 6, dotPaint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }




// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class HomeAdmin extends StatefulWidget {
//   const HomeAdmin({super.key});

//   @override
//   State<HomeAdmin> createState() => _HomeAdminState();
// }

// class _HomeAdminState extends State<HomeAdmin> {
//   bool _isLoading = true;
//   int totalCameras = 0;
//   int pendingOrders = 15;
//   int totalRevenue = 1234;
//   int totalUsers = 101;

//   @override
//   void initState() {
//     super.initState();
//     _fetchDashboardData();
//   }

//   Future<void> _fetchDashboardData() async {
//     try {
//       final supabase = Supabase.instance.client;
//       final cameraRes = await supabase.from('cameras').select('id');
//       setState(() {
//         totalCameras = cameraRes.length;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF5B5B5B),
//       body: SafeArea(
//         child: _isLoading
//             ? const Center(child: CircularProgressIndicator(color: Colors.white))
//             : Center(
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 800),
//                   child: SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Dashboard",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 32,
//                             fontFamily: 'Serif',
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           children: [
//                             Expanded(child: _StatCard(title: "จำนวนกล้อง", value: totalCameras.toString())),
//                             const SizedBox(width: 12),
//                             Expanded(child: _StatCard(title: "คำสั่งซื้อรอดำเนินการ", value: pendingOrders.toString())),
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//                         Row(
//                           children: [
//                             Expanded(child: _StatCard(title: "รายได้รวม", value: totalRevenue.toString())),
//                             const SizedBox(width: 12),
//                             Expanded(child: _StatCard(title: "จำนวนผู้ใช้ทั้งหมด", value: totalUsers.toString())),
//                           ],
//                         ),
//                         const SizedBox(height: 16),

//                         // ====== กราฟรูปแบบใหม่ (DIRECT MARKETING VIEWS) ======
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFE9E9E9),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 "DIRECT MARKETING VIEWS, BY DATE",
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black54,
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               SizedBox(
//                                 height: 180, 
//                                 child: _NewStyleChart(),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 16),

//                         // ====== กิจกรรมล่าสุด ======
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(14),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFE9E9E9),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text("กิจกรรมล่าสุด", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                                   Text("ดูทั้งหมด", style: TextStyle(color: Colors.black.withOpacity(0.55), fontSize: 12)),
//                                 ],
//                               ),
//                               const SizedBox(height: 14),
//                               const _ActivityTile(iconBg: Color(0xFF1E88E5), icon: Icons.receipt_long, title: "มีสลิปใหม่จาก สมชาย", subtitle: "348 วันที่แล้ว"),
//                               const SizedBox(height: 8),
//                               const _ActivityTile(iconBg: Color(0xFF8D8D8D), icon: Icons.settings_backup_restore, title: "Sony A7IV ถูกคืนแล้ว", subtitle: "348 วันที่แล้ว"),
//                               const SizedBox(height: 8),
//                               const _ActivityTile(iconBg: Color(0xFF2E7D32), icon: Icons.check_circle_outline, title: "อนุมัติออเดอร์ ORD-002", subtitle: "348 วันที่แล้ว"),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 120), 
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }

// class _StatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   const _StatCard({required this.title, required this.value});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 96,
//       decoration: BoxDecoration(color: const Color(0xFFE9E9E9), borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
//           Text(value, style: const TextStyle(fontSize: 32, fontFamily: 'Serif')),
//         ],
//       ),
//     );
//   }
// }

// class _ActivityTile extends StatelessWidget {
//   final Color iconBg;
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   const _ActivityTile({required this.iconBg, required this.icon, required this.title, required this.subtitle});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
//       child: Row(
//         children: [
//           Container(width: 40, height: 40, decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: Colors.white, size: 20)),
//           const SizedBox(width: 12),
//           Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
//             Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
//           ])),
//         ],
//       ),
//     );
//   }
// }

// class _NewStyleChart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: _NewStyleChartPainter(),
//       child: const SizedBox.expand(),
//     );
//   }
// }

// class _NewStyleChartPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final linePaint = Paint()
//       ..color = const Color(0xFFE67E22) 
//       ..strokeWidth = 2.5
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     final axisPaint = Paint()
//       ..color = Colors.black87
//       ..strokeWidth = 1.5;

//     final textStyle = const TextStyle(color: Colors.black54, fontSize: 10);

//     double paddingLeft = 30.0;
//     double paddingBottom = 25.0;
//     double drawWidth = size.width - paddingLeft;
//     double drawHeight = size.height - paddingBottom;

//     canvas.drawLine(Offset(paddingLeft, 0), Offset(paddingLeft, drawHeight), axisPaint); 
//     canvas.drawLine(Offset(paddingLeft, drawHeight), Offset(size.width, drawHeight), axisPaint); 

//     for (int i = 0; i <= 3; i++) {
//       double yVal = 5.0 * (i + 1);
//       double yPos = drawHeight - (yVal / 25 * drawHeight);
      
//       canvas.drawLine(Offset(paddingLeft, yPos), Offset(paddingLeft - 5, yPos), axisPaint);
      
//       final tp = TextPainter(
//         text: TextSpan(text: yVal.toInt().toString(), style: textStyle),
//         textDirection: TextDirection.ltr,
//       );
//       tp.layout(); // แยกบรรทัดเพื่อให้ได้ค่า void
//       tp.paint(canvas, Offset(paddingLeft - 22, yPos - 6));
//     }

//     List<double> dataPoints = [7, 10, 9, 19, 15, 10, 11, 6];
//     List<String> labels = ["5-1", "5-2", "5-3", "5-4", "5-5", "5-6", "5-7", "5-8"];
//     double xStep = drawWidth / (dataPoints.length);

//     Path path = Path();
//     for (int i = 0; i < dataPoints.length; i++) {
//       double x = paddingLeft + (xStep * i) + (xStep / 2);
//       double y = drawHeight - (dataPoints[i] / 25 * drawHeight);

//       if (i == 0) {
//         path.moveTo(x, y);
//       } else {
//         path.lineTo(x, y);
//       }

//       final tpLabel = TextPainter(
//         text: TextSpan(text: labels[i], style: textStyle),
//         textDirection: TextDirection.ltr,
//       );
//       tpLabel.layout(); // แยกบรรทัดแก้ไข Error
//       tpLabel.paint(canvas, Offset(x - 10, drawHeight + 8));
//     }
//     canvas.drawPath(path, linePaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }



// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class HomeAdmin extends StatefulWidget {
//   const HomeAdmin({super.key});

//   @override
//   State<HomeAdmin> createState() => _HomeAdminState();
// }

// class _HomeAdminState extends State<HomeAdmin> {
//   bool _isLoading = true;
//   int totalCameras = 0;
//   int pendingOrders = 0;
//   int totalRevenue = 0;
//   int totalUsers = 0;

//   // ⭐ ข้อมูลสำหรับกราฟ
//   List<double> incomeData = [0, 0, 0, 0, 0, 0, 0, 0];
//   List<String> incomeLabels = ["", "", "", "", "", "", "", ""];

//   @override
//   void initState() {
//     super.initState();
//     _fetchDashboardData();
//   }

//   Future<void> _fetchDashboardData() async {
//     try {
//       final supabase = Supabase.instance.client;

//       // 1. ดึงจำนวนกล้องทั้งหมด
//       final cameraRes = await supabase.from('cameras').select('id');

//       // 2. ดึงจำนวนผู้ใช้ทั้งหมด (สมมติว่ามีตารางชื่อ profiles หรือ users)
//       final userRes = await supabase.from('profiles').select('id');

//       // 3. ดึงออเดอร์ที่รอดำเนินการ (status = 'pending')
//       final pendingRes = await supabase
//           .from('orders')
//           .select('id')
//           .eq('status', 'pending');

//       // 4. ดึงรายได้รวมทั้งหมด
//       final revenueRes = await supabase.from('orders').select('total_price');
//       int revenueSum = 0;
//       for (var row in revenueRes) {
//         revenueSum += (row['total_price'] as num).toInt();
//       }

//       // 5. ⭐ ดึงข้อมูลรายได้ย้อนหลัง 8 วันสำหรับกราฟ
//       final eightDaysAgo = DateTime.now().subtract(const Duration(days: 7));
//       final chartDataRes = await supabase
//           .from('orders')
//           .select('total_price, created_at')
//           .gte('created_at', eightDaysAgo.toIso8601String());

//       List<double> values = List.filled(8, 0.0);
//       List<String> labels = [];
//       DateTime now = DateTime.now();

//       for (int i = 7; i >= 0; i--) {
//         DateTime date = now.subtract(Duration(days: i));
//         labels.add("${date.day}/${date.month}");

//         double daySum = 0;
//         for (var row in chartDataRes) {
//           DateTime rowDate = DateTime.parse(row['created_at']);
//           if (rowDate.day == date.day && rowDate.month == date.month) {
//             daySum += (row['total_price'] as num).toDouble();
//           }
//         }
//         values[7 - i] = daySum;
//       }

//       setState(() {
//         totalCameras = cameraRes.length;
//         totalUsers = userRes.length;
//         pendingOrders = pendingRes.length;
//         totalRevenue = revenueSum;
//         incomeData = values;
//         incomeLabels = labels;
//         _isLoading = false;
//       });
//     } catch (e) {
//       debugPrint("Error fetching dashboard: $e");
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF5B5B5B),
//       body: SafeArea(
//         child: _isLoading
//             ? const Center(child: CircularProgressIndicator(color: Colors.white))
//             : Center(
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 800),
//                   child: SingleChildScrollView(
//                     physics: const BouncingScrollPhysics(),
//                     padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Dashboard",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 32,
//                             fontFamily: 'Serif',
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Row(
//                           children: [
//                             Expanded(child: _StatCard(title: "จำนวนกล้อง", value: totalCameras.toString())),
//                             const SizedBox(width: 12),
//                             Expanded(child: _StatCard(title: "ออเดอร์รออนุมัติ", value: pendingOrders.toString())),
//                           ],
//                         ),
//                         const SizedBox(height: 12),
//                         Row(
//                           children: [
//                             Expanded(child: _StatCard(title: "รายได้รวม", value: "฿$totalRevenue")),
//                             const SizedBox(width: 12),
//                             Expanded(child: _StatCard(title: "ผู้ใช้ทั้งหมด", value: totalUsers.toString())),
//                           ],
//                         ),
//                         const SizedBox(height: 16),

//                         // ====== กราฟข้อมูลจริงจาก Supabase ======
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFE9E9E9),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 "DAILY INCOME STATS (LAST 8 DAYS)",
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black54,
//                                   letterSpacing: 0.5,
//                                 ),
//                               ),
//                               const SizedBox(height: 20),
//                               SizedBox(
//                                 height: 180,
//                                 child: _NewStyleChart(data: incomeData, labels: incomeLabels),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 16),

//                         // ====== กิจกรรมล่าสุด ======
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(14),
//                           decoration: BoxDecoration(
//                             color: const Color(0xFFE9E9E9),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text("กิจกรรมล่าสุด", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                                   Text("ดูทั้งหมด", style: TextStyle(color: Colors.black.withOpacity(0.55), fontSize: 12)),
//                                 ],
//                               ),
//                               const SizedBox(height: 14),
//                               const _ActivityTile(iconBg: Color(0xFF1E88E5), icon: Icons.receipt_long, title: "ตรวจสอบสลิปใหม่", subtitle: "รอดำเนินการ"),
//                               const SizedBox(height: 8),
//                               const _ActivityTile(iconBg: Color(0xFF8D8D8D), icon: Icons.settings_backup_restore, title: "กล้องถูกคืนเข้าระบบ", subtitle: " Sony A7IV"),
//                               const SizedBox(height: 8),
//                               const _ActivityTile(iconBg: Color(0xFF2E7D32), icon: Icons.check_circle_outline, title: "ชำระเงินสำเร็จ", subtitle: "ออเดอร์ ORD-551"),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 120),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }

// class _StatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   const _StatCard({required this.title, required this.value});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 96,
//       decoration: BoxDecoration(color: const Color(0xFFE9E9E9), borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
//           Text(value, style: const TextStyle(fontSize: 24, fontFamily: 'Serif', fontWeight: FontWeight.bold), textAlign: TextAlign.center),
//         ],
//       ),
//     );
//   }
// }

// class _ActivityTile extends StatelessWidget {
//   final Color iconBg;
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   const _ActivityTile({required this.iconBg, required this.icon, required this.title, required this.subtitle});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
//       child: Row(
//         children: [
//           Container(width: 40, height: 40, decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: Colors.white, size: 20)),
//           const SizedBox(width: 12),
//           Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
//             Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
//           ])),
//         ],
//       ),
//     );
//   }
// }

// class _NewStyleChart extends StatelessWidget {
//   final List<double> data;
//   final List<String> labels;
//   const _NewStyleChart({required this.data, required this.labels});

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: _NewStyleChartPainter(data: data, labels: labels),
//       child: const SizedBox.expand(),
//     );
//   }
// }

// class _NewStyleChartPainter extends CustomPainter {
//   final List<double> data;
//   final List<String> labels;
//   _NewStyleChartPainter({required this.data, required this.labels});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final linePaint = Paint()
//       ..color = const Color(0xFFE67E22)
//       ..strokeWidth = 2.5
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     final axisPaint = Paint()..color = Colors.black87..strokeWidth = 1.5;
//     final textStyle = const TextStyle(color: Colors.black54, fontSize: 10);

//     double paddingLeft = 45.0; // เพิ่มพื้นที่ให้ตัวเลขราคาที่แกน Y
//     double paddingBottom = 25.0;
//     double drawWidth = size.width - paddingLeft;
//     double drawHeight = size.height - paddingBottom;

//     // หาค่าสูงสุดของรายได้เพื่อคำนวณสเกล
//     double maxVal = data.isEmpty ? 100 : data.reduce((a, b) => a > b ? a : b);
//     if (maxVal < 100) maxVal = 100;

//     canvas.drawLine(Offset(paddingLeft, 0), Offset(paddingLeft, drawHeight), axisPaint);
//     canvas.drawLine(Offset(paddingLeft, drawHeight), Offset(size.width, drawHeight), axisPaint);

//     // 1. วาดสเกลแกน Y
//     for (int i = 0; i <= 3; i++) {
//       double yVal = (maxVal / 4) * (i + 1);
//       double yPos = drawHeight - (yVal / maxVal * drawHeight);
//       canvas.drawLine(Offset(paddingLeft, yPos), Offset(paddingLeft - 5, yPos), axisPaint);
      
//       final tp = TextPainter(
//         text: TextSpan(text: yVal >= 1000 ? "${(yVal/1000).toStringAsFixed(1)}k" : yVal.toInt().toString(), style: textStyle),
//         textDirection: TextDirection.ltr,
//       );
//       tp.layout();
//       tp.paint(canvas, Offset(paddingLeft - tp.width - 8, yPos - 6));
//     }

//     // 2. วาดเส้นกราฟจากข้อมูลจริง
//     if (data.isNotEmpty) {
//       double xStep = drawWidth / data.length;
//       Path path = Path();
//       for (int i = 0; i < data.length; i++) {
//         double x = paddingLeft + (xStep * i) + (xStep / 2);
//         double y = drawHeight - (data[i] / maxVal * drawHeight);

//         if (i == 0) path.moveTo(x, y); else path.lineTo(x, y);

//         final tpLabel = TextPainter(
//           text: TextSpan(text: labels[i], style: textStyle),
//           textDirection: TextDirection.ltr,
//         );
//         tpLabel.layout();
//         tpLabel.paint(canvas, Offset(x - (tpLabel.width / 2), drawHeight + 8));
//       }
//       canvas.drawPath(path, linePaint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }


// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:intl/intl.dart';

// class HomeAdmin extends StatefulWidget {
//   const HomeAdmin({super.key});

//   @override
//   State<HomeAdmin> createState() => _HomeAdminState();
// }

// class _HomeAdminState extends State<HomeAdmin> {
//   bool _isLoading = true;
//   int totalCameras = 0;
//   int pendingOrders = 0;
//   int totalRevenue = 0;
//   int totalUsers = 0;

//   // ข้อมูลสำหรับกราฟ
//   List<double> incomeData = [0, 0, 0, 0, 0, 0, 0, 0];
//   List<String> incomeLabels = ["", "", "", "", "", "", "", ""];
  
//   // ⭐ ข้อมูลสำหรับกิจกรรมล่าสุด
//   List<Map<String, dynamic>> recentActivities = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchDashboardData();
//   }

//   Future<void> _fetchDashboardData() async {
//     try {
//       final supabase = Supabase.instance.client;

//       // 1. ดึงจำนวนกล้องทั้งหมด
//       final cameraRes = await supabase.from('cameras').select('id');

//       // 2. ดึงจำนวนผู้ใช้ทั้งหมด
//       final userRes = await supabase.from('profiles').select('id');

//       // 3. ดึงออเดอร์ที่รอดำเนินการ
//       final pendingRes = await supabase
//           .from('orders')
//           .select('id')
//           .eq('status', 'pending');

//       // 4. ดึงรายได้รวมทั้งหมด (จากออเดอร์ที่ชำระเงินแล้วเท่านั้น หรือทั้งหมดก็ได้)
//       final revenueRes = await supabase.from('orders').select('total_price');
//       int revenueSum = 0;
//       for (var row in revenueRes) {
//         revenueSum += (row['total_price'] as num).toInt();
//       }

//       // 5. ดึงข้อมูลรายได้ย้อนหลัง 8 วันสำหรับกราฟ
//       final eightDaysAgo = DateTime.now().subtract(const Duration(days: 7));
//       final chartDataRes = await supabase
//           .from('orders')
//           .select('total_price, created_at')
//           .gte('created_at', eightDaysAgo.toIso8601String());

//       List<double> values = List.filled(8, 0.0);
//       List<String> labels = [];
//       DateTime now = DateTime.now();

//       for (int i = 7; i >= 0; i--) {
//         DateTime date = now.subtract(Duration(days: i));
//         labels.add("${date.day}/${date.month}");

//         double daySum = 0;
//         for (var row in chartDataRes) {
//           DateTime rowDate = DateTime.parse(row['created_at']);
//           if (rowDate.day == date.day && rowDate.month == date.month) {
//             daySum += (row['total_price'] as num).toDouble();
//           }
//         }
//         values[7 - i] = daySum;
//       }

//       // 6. ⭐ ดึงกิจกรรมล่าสุด (5 รายการล่าสุด)
//       final recentRes = await supabase
//           .from('orders')
//           .select('id, status, created_at, profiles(full_name), cameras(name)')
//           .order('created_at', ascending: false)
//           .limit(5);

//       List<Map<String, dynamic>> activities = [];
//       for (var row in recentRes) {
//         String status = row['status'] ?? 'pending';
//         String cameraName = row['cameras']?['name'] ?? 'อุปกรณ์';
//         String orderId = 'ORD-${row['id'].toString().padLeft(3, '0')}';
        
//         String title = '';
//         String subtitle = '';
//         Color iconBg = Colors.grey;
//         IconData icon = Icons.info;

//         // แปลงสถานะเป็นรูปแบบการแสดงผล
//         if (status == 'pending') {
//           title = 'ตรวจสอบสลิปใหม่';
//           subtitle = 'รอดำเนินการ';
//           iconBg = const Color(0xFF1E88E5); // สีฟ้า
//           icon = Icons.receipt_long;
//         } else if (status == 'completed') {
//           title = 'ชำระเงินสำเร็จ';
//           subtitle = 'ออเดอร์ $orderId';
//           iconBg = const Color(0xFF2E7D32); // สีเขียว
//           icon = Icons.check_circle_outline;
//         } else if (status == 'returned') {
//           title = 'กล้องถูกคืนเข้าระบบ';
//           subtitle = cameraName;
//           iconBg = const Color(0xFF8D8D8D); // สีเทา
//           icon = Icons.settings_backup_restore;
//         } else if (status == 'repair_requested') {
//           title = '$cameraName ส่งเข้าซ่อม';
//           subtitle = 'รอดำเนินการ';
//           iconBg = const Color(0xFFE67E22); // สีส้ม
//           icon = Icons.build_circle_rounded;
//         } else if (status == 'rejected') {
//           title = 'ปฏิเสธสลิป';
//           subtitle = 'ออเดอร์ $orderId';
//           iconBg = Colors.redAccent; // สีแดง
//           icon = Icons.cancel_outlined;
//         } else {
//           continue; // ข้ามสถานะที่ไม่รู้จัก
//         }

//         activities.add({
//           'title': title,
//           'subtitle': subtitle,
//           'iconBg': iconBg,
//           'icon': icon,
//         });
//       }

//       setState(() {
//         totalCameras = cameraRes.length;
//         totalUsers = userRes.length;
//         pendingOrders = pendingRes.length;
//         totalRevenue = revenueSum;
//         incomeData = values;
//         incomeLabels = labels;
//         recentActivities = activities; // ⭐ อัปเดตข้อมูลเข้าตัวแปร
//         _isLoading = false;
//       });
//     } catch (e) {
//       debugPrint("Error fetching dashboard: $e");
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF5B5B5B),
//       body: SafeArea(
//         child: _isLoading
//             ? const Center(child: CircularProgressIndicator(color: Colors.white))
//             : Center(
//                 child: ConstrainedBox(
//                   constraints: const BoxConstraints(maxWidth: 800),
//                   child: RefreshIndicator(
//                     onRefresh: _fetchDashboardData, // ลากลงเพื่อรีเฟรชได้
//                     child: SingleChildScrollView(
//                       physics: const AlwaysScrollableScrollPhysics(), // ให้ลากลงเพื่อรีเฟรชได้เสมอ
//                       padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             "Dashboard",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 32,
//                               fontFamily: 'Serif',
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           Row(
//                             children: [
//                               Expanded(child: _StatCard(title: "จำนวนกล้อง", value: totalCameras.toString())),
//                               const SizedBox(width: 12),
//                               Expanded(child: _StatCard(title: "ออเดอร์รออนุมัติ", value: pendingOrders.toString())),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
//                           Row(
//                             children: [
//                               Expanded(child: _StatCard(title: "รายได้รวม", value: "฿${NumberFormat('#,###').format(totalRevenue)}")),
//                               const SizedBox(width: 12),
//                               Expanded(child: _StatCard(title: "ผู้ใช้ทั้งหมด", value: totalUsers.toString())),
//                             ],
//                           ),
//                           const SizedBox(height: 16),

//                           // ====== กราฟข้อมูลจริงจาก Supabase ======
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFE9E9E9),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   "DAILY INCOME STATS (LAST 8 DAYS)",
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.black54,
//                                     letterSpacing: 0.5,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 SizedBox(
//                                   height: 180,
//                                   child: _NewStyleChart(data: incomeData, labels: incomeLabels),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 16),

//                           // ====== ⭐ กิจกรรมล่าสุด (ดึงจากฐานข้อมูลจริง) ======
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(14),
//                             decoration: BoxDecoration(
//                               color: const Color(0xFFE9E9E9),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const Text("กิจกรรมล่าสุด", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//                                     Text("ดูทั้งหมด", style: TextStyle(color: Colors.black.withOpacity(0.55), fontSize: 12)),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 14),
                                
//                                 // วนลูปสร้างการ์ดกิจกรรม
//                                 if (recentActivities.isEmpty)
//                                   const Padding(
//                                     padding: EdgeInsets.symmetric(vertical: 20),
//                                     child: Center(child: Text("ยังไม่มีกิจกรรม", style: TextStyle(color: Colors.grey))),
//                                   )
//                                 else
//                                   ...recentActivities.map((act) => _ActivityTile(
//                                         iconBg: act['iconBg'],
//                                         icon: act['icon'],
//                                         title: act['title'],
//                                         subtitle: act['subtitle'],
//                                       )),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 120), // เผื่อที่ว่างเมนูด้านล่าง
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }

// class _StatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   const _StatCard({required this.title, required this.value});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 96,
//       decoration: BoxDecoration(color: const Color(0xFFE9E9E9), borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
//           Text(value, style: const TextStyle(fontSize: 24, fontFamily: 'Serif', fontWeight: FontWeight.bold), textAlign: TextAlign.center),
//         ],
//       ),
//     );
//   }
// }

// class _ActivityTile extends StatelessWidget {
//   final Color iconBg;
//   final IconData icon;
//   final String title;
//   final String subtitle;
  
//   const _ActivityTile({required this.iconBg, required this.icon, required this.title, required this.subtitle});
  
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
//       child: Row(
//         children: [
//           Container(
//             width: 40, height: 40, 
//             decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)), 
//             child: Icon(icon, color: Colors.white, size: 20)
//           ),
//           const SizedBox(width: 12),
//           Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
//             Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
//           ])),
//         ],
//       ),
//     );
//   }
// }

// class _NewStyleChart extends StatelessWidget {
//   final List<double> data;
//   final List<String> labels;
//   const _NewStyleChart({required this.data, required this.labels});

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: _NewStyleChartPainter(data: data, labels: labels),
//       child: const SizedBox.expand(),
//     );
//   }
// }

// class _NewStyleChartPainter extends CustomPainter {
//   final List<double> data;
//   final List<String> labels;
//   _NewStyleChartPainter({required this.data, required this.labels});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final linePaint = Paint()
//       ..color = const Color(0xFFE67E22)
//       ..strokeWidth = 2.5
//       ..style = PaintingStyle.stroke
//       ..strokeCap = StrokeCap.round;

//     final axisPaint = Paint()..color = Colors.black87..strokeWidth = 1.5;
//     final textStyle = const TextStyle(color: Colors.black54, fontSize: 10);

//     double paddingLeft = 45.0; 
//     double paddingBottom = 25.0;
//     double drawWidth = size.width - paddingLeft;
//     double drawHeight = size.height - paddingBottom;

//     double maxVal = data.isEmpty ? 100 : data.reduce((a, b) => a > b ? a : b);
//     if (maxVal < 100) maxVal = 100;

//     canvas.drawLine(Offset(paddingLeft, 0), Offset(paddingLeft, drawHeight), axisPaint);
//     canvas.drawLine(Offset(paddingLeft, drawHeight), Offset(size.width, drawHeight), axisPaint);

//     for (int i = 0; i <= 3; i++) {
//       double yVal = (maxVal / 4) * (i + 1);
//       double yPos = drawHeight - (yVal / maxVal * drawHeight);
//       canvas.drawLine(Offset(paddingLeft, yPos), Offset(paddingLeft - 5, yPos), axisPaint);
      
//       final tp = TextPainter(
//         text: TextSpan(text: yVal >= 1000 ? "${(yVal/1000).toStringAsFixed(1)}k" : yVal.toInt().toString(), style: textStyle),
//         textDirection: TextDirection.ltr,
//       );
//       tp.layout();
//       tp.paint(canvas, Offset(paddingLeft - tp.width - 8, yPos - 6));
//     }

//     if (data.isNotEmpty) {
//       double xStep = drawWidth / data.length;
//       Path path = Path();
//       for (int i = 0; i < data.length; i++) {
//         double x = paddingLeft + (xStep * i) + (xStep / 2);
//         double y = drawHeight - (data[i] / maxVal * drawHeight);

//         if (i == 0) path.moveTo(x, y); else path.lineTo(x, y);

//         final tpLabel = TextPainter(
//           text: TextSpan(text: labels[i], style: textStyle),
//           textDirection: TextDirection.ltr,
//         );
//         tpLabel.layout();
//         tpLabel.paint(canvas, Offset(x - (tpLabel.width / 2), drawHeight + 8));
//       }
//       canvas.drawPath(path, linePaint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }



import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  bool _isLoading = true;
  int totalCameras = 0;
  int pendingOrders = 0;
  int totalRevenue = 0;
  int totalUsers = 0;

  // ข้อมูลสำหรับกราฟ
  List<double> incomeData = [0, 0, 0, 0, 0, 0, 0, 0];
  List<String> incomeLabels = ["", "", "", "", "", "", "", ""];

  // ⭐ ข้อมูลสำหรับกิจกรรมล่าสุด
  List<Map<String, dynamic>> recentActivities = [];

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  Future<void> _fetchDashboardData() async {
    try {
      final supabase = Supabase.instance.client;

      // 1. ดึงจำนวนกล้องทั้งหมด
      final cameraRes = await supabase.from('cameras').select('id');

      // 2. ดึงจำนวนผู้ใช้ทั้งหมด
      final userRes = await supabase.from('profiles').select('id');

      // 3. ดึงออเดอร์ที่รอดำเนินการ
      final pendingRes =
          await supabase.from('orders').select('id').eq('status', 'pending');

      // 4. ดึงรายได้รวมทั้งหมด
      final revenueRes = await supabase.from('orders').select('total_price');
      int revenueSum = 0;
      for (var row in revenueRes) {
        revenueSum += (row['total_price'] as num).toInt();
      }

      // 5. ดึงข้อมูลรายได้ย้อนหลัง 8 วันสำหรับกราฟ
      final eightDaysAgo = DateTime.now().subtract(const Duration(days: 7));
      final chartDataRes = await supabase
          .from('orders')
          .select('total_price, created_at')
          .gte('created_at', eightDaysAgo.toIso8601String());

      List<double> values = List.filled(8, 0.0);
      List<String> labels = [];
      DateTime now = DateTime.now();

      for (int i = 7; i >= 0; i--) {
        DateTime date = now.subtract(Duration(days: i));
        labels.add("${date.day}/${date.month}");

        double daySum = 0;
        for (var row in chartDataRes) {
          DateTime rowDate = DateTime.parse(row['created_at']);
          if (rowDate.day == date.day && rowDate.month == date.month) {
            daySum += (row['total_price'] as num).toDouble();
          }
        }
        values[7 - i] = daySum;
      }

      // 6. ⭐ ดึงกิจกรรมล่าสุด (5 รายการล่าสุด)
      final recentRes = await supabase
          .from('orders')
          .select('id, status, created_at, profiles(full_name), cameras(name)')
          .order('created_at', ascending: false)
          .limit(5);

      List<Map<String, dynamic>> activities = [];
      for (var row in recentRes) {
        String status = row['status'] ?? 'pending';
        String cameraName = row['cameras']?['name'] ?? 'อุปกรณ์';
        String orderId = 'ORD-${row['id'].toString().padLeft(3, '0')}';

        String title = '';
        String subtitle = '';
        Color iconBg = Colors.grey;
        IconData icon = Icons.info;

        if (status == 'pending') {
          title = 'ตรวจสอบสลิปใหม่';
          subtitle = 'รอดำเนินการ';
          iconBg = const Color(0xFF1E88E5);
          icon = Icons.receipt_long;
        } else if (status == 'completed') {
          title = 'ชำระเงินสำเร็จ';
          subtitle = 'ออเดอร์ $orderId';
          iconBg = const Color(0xFF2E7D32);
          icon = Icons.check_circle_outline;
        } else if (status == 'returned') {
          title = 'กล้องถูกคืนเข้าระบบ';
          subtitle = cameraName;
          iconBg = const Color(0xFF8D8D8D);
          icon = Icons.settings_backup_restore;
        } else if (status == 'repair_requested') {
          title = '$cameraName ส่งเข้าซ่อม';
          subtitle = 'รอดำเนินการ';
          iconBg = const Color(0xFFE67E22);
          icon = Icons.build_circle_rounded;
        } else if (status == 'rejected') {
          title = 'ปฏิเสธสลิป';
          subtitle = 'ออเดอร์ $orderId';
          iconBg = Colors.redAccent;
          icon = Icons.cancel_outlined;
        } else {
          continue;
        }

        activities.add({
          'title': title,
          'subtitle': subtitle,
          'iconBg': iconBg,
          'icon': icon,
        });
      }

      setState(() {
        totalCameras = cameraRes.length;
        totalUsers = userRes.length;
        pendingOrders = pendingRes.length;
        totalRevenue = revenueSum;
        incomeData = values;
        incomeLabels = labels;
        recentActivities = activities;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching dashboard: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5B5B5B),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: RefreshIndicator(
                    onRefresh: _fetchDashboardData,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Dashboard",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontFamily: 'Serif',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _StatCard(
                                  title: "จำนวนกล้อง",
                                  value: totalCameras.toString(),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _StatCard(
                                  title: "ออเดอร์รออนุมัติ",
                                  value: pendingOrders.toString(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _StatCard(
                                  title: "รายได้รวม",
                                  value:
                                      "฿${NumberFormat('#,###').format(totalRevenue)}",
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _StatCard(
                                  title: "ผู้ใช้ทั้งหมด",
                                  value: totalUsers.toString(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // ====== กราฟ ======
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE9E9E9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "DAILY INCOME STATS (LAST 8 DAYS)",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 180,
                                  child: _NewStyleChart(
                                    data: incomeData,
                                    labels: incomeLabels,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),

                          // ====== กิจกรรมล่าสุด ======
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE9E9E9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "กิจกรรมล่าสุด",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "ดูทั้งหมด",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.55),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                if (recentActivities.isEmpty)
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20),
                                    child: Center(
                                      child: Text(
                                        "ยังไม่มีกิจกรรม",
                                        style:
                                            TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  )
                                else
                                  ...recentActivities.map(
                                    (act) => _ActivityTile(
                                      iconBg: act['iconBg'],
                                      icon: act['icon'],
                                      title: act['title'],
                                      subtitle: act['subtitle'],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 120),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  const _StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      decoration: BoxDecoration(
        color: const Color(0xFFE9E9E9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'Serif',
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final Color iconBg;
  final IconData icon;
  final String title;
  final String subtitle;

  const _ActivityTile({
    required this.iconBg,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NewStyleChart extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  const _NewStyleChart({required this.data, required this.labels});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _NewStyleChartPainter(data: data, labels: labels),
      child: const SizedBox.expand(),
    );
  }
}

class _NewStyleChartPainter extends CustomPainter {
  final List<double> data;
  final List<String> labels;
  _NewStyleChartPainter({required this.data, required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFFE67E22)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final axisPaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 1.5;

    final textStyle = const TextStyle(color: Colors.black54, fontSize: 10);

    double paddingLeft = 45.0;
    double paddingBottom = 25.0;
    double drawWidth = size.width - paddingLeft;
    double drawHeight = size.height - paddingBottom;

    double maxVal = data.isEmpty ? 100 : data.reduce((a, b) => a > b ? a : b);
    if (maxVal < 100) maxVal = 100;

    canvas.drawLine(Offset(paddingLeft, 0), Offset(paddingLeft, drawHeight), axisPaint);
    canvas.drawLine(Offset(paddingLeft, drawHeight), Offset(size.width, drawHeight), axisPaint);

    for (int i = 0; i <= 3; i++) {
      double yVal = (maxVal / 4) * (i + 1);
      double yPos = drawHeight - (yVal / maxVal * drawHeight);

      canvas.drawLine(Offset(paddingLeft, yPos), Offset(paddingLeft - 5, yPos), axisPaint);

      final tp = TextPainter(
        text: TextSpan(
          text: yVal >= 1000
              ? "${(yVal / 1000).toStringAsFixed(1)}k"
              : yVal.toInt().toString(),
          style: textStyle,
        ),
        textDirection: ui.TextDirection.ltr, // ✅ FIX
      );
      tp.layout();
      tp.paint(canvas, Offset(paddingLeft - tp.width - 8, yPos - 6));
    }

    if (data.isNotEmpty) {
      double xStep = drawWidth / data.length;
      Path path = Path();

      for (int i = 0; i < data.length; i++) {
        double x = paddingLeft + (xStep * i) + (xStep / 2);
        double y = drawHeight - (data[i] / maxVal * drawHeight);

        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }

        final tpLabel = TextPainter(
          text: TextSpan(text: labels[i], style: textStyle),
          textDirection: ui.TextDirection.ltr, // ✅ FIX
        );
        tpLabel.layout();
        tpLabel.paint(canvas, Offset(x - (tpLabel.width / 2), drawHeight + 8));
      }

      canvas.drawPath(path, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
