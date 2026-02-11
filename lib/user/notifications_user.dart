// import 'package:flutter/material.dart';

// class NotificationsUserPage extends StatelessWidget {
//   const NotificationsUserPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const bg = Color(0xFF3A3A3A);

//     return Scaffold(
//       backgroundColor: bg,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Search bar เหมือนในรูป
//               Container(
//                 height: 44,
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 child: Row(
//                   children: const [
//                     Icon(Icons.search, color: Colors.black54),
//                     SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         "ค้นหาการแจ้งเตือน...",
//                         style: TextStyle(color: Colors.black45, fontSize: 13),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 14),

//               // ✅ หัวข้อ + ปุ่มกลับ
//               Row(
//                 children: [
//                   Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(999),
//                       onTap: () => Navigator.pop(context),
//                       child: Container(
//                         width: 40,
//                         height: 40,
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.12),
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.white24),
//                         ),
//                         child: const Icon(
//                           Icons.arrow_back_ios_new_rounded,
//                           size: 18,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   const Text(
//                     "การแจ้งเตือน",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),

//               Expanded(
//                 child: ListView(
//                   physics: const BouncingScrollPhysics(),
//                   children: const [
//                     _NotifyItem(
//                       color: Color(0xFF19C37D),
//                       icon: Icons.check_circle_rounded,
//                       title: "อนุมัติรายการเช่าเรียบร้อยแล้ว",
//                       subtitle: "เลขที่ OR-005 ร้านค้ารับรองแล้ว • กรุณารับอุปกรณ์...",
//                       time: "2 นาทีที่แล้ว",
//                     ),
//                     SizedBox(height: 10),
//                     _NotifyItem(
//                       color: Color(0xFFFFB020),
//                       icon: Icons.notifications_active_rounded,
//                       title: "เตือนวันคืนอุปกรณ์",
//                       subtitle: "อีก 1 วันจะถึงกำหนดคืน (18 ส.ค. 2025)...",
//                       time: "3 ชั่วโมงที่แล้ว",
//                     ),
//                     SizedBox(height: 10),
//                     _NotifyItem(
//                       color: Color(0xFF19C37D),
//                       icon: Icons.verified_rounded,
//                       title: "รายการเช่าของคุณได้รับอนุมัติ ✨",
//                       subtitle: "เลขที่ OR-002 สถานะ: อนุมัติแล้ว สามารถรับอุปกรณ์...",
//                       time: "6 ชั่วโมงที่แล้ว",
//                     ),
//                     SizedBox(height: 10),
//                     _NotifyItem(
//                       color: Color(0xFFFF5E5E),
//                       icon: Icons.error_rounded,
//                       title: "สลิปไม่ถูกต้อง",
//                       subtitle: "กรุณาอัปโหลดสลิปใหม่ ยอดเงินไม่ตรงหรือรูปไม่ชัด...",
//                       time: "เมื่อวาน",
//                       leftAccent: true,
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 120), // เผื่อ bottom nav ลอยของคุณ
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _NotifyItem extends StatelessWidget {
//   final Color color;
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final String time;
//   final bool leftAccent;

//   const _NotifyItem({
//     required this.color,
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.time,
//     this.leftAccent = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(14),
//       onTap: () {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("เปิดรายละเอียด: $title")),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.25),
//           borderRadius: BorderRadius.circular(14),
//           border: leftAccent ? Border(left: BorderSide(color: color, width: 4)) : null,
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: 38,
//               height: 38,
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.15),
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(icon, color: color),
//             ),
//             const SizedBox(width: 10),

//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 13,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     subtitle,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       color: Colors.white70,
//                       fontSize: 11,
//                       height: 1.25,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(width: 8),
//             Text(
//               time,
//               style: const TextStyle(
//                 color: Colors.white60,
//                 fontSize: 10,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:intl/intl.dart';
// import 'noti_detail_sheet.dart'; // ⭐ อย่าลืม Import ไฟล์ใหม่ที่เพิ่งสร้าง

// class NotificationsUserPage extends StatefulWidget {
//   const NotificationsUserPage({super.key});

//   @override
//   State<NotificationsUserPage> createState() => _NotificationsUserPageState();
// }

// class _NotificationsUserPageState extends State<NotificationsUserPage> {
//   final supabase = Supabase.instance.client;
//   late Future<List<dynamic>> _notiFuture;

//   @override
//   void initState() {
//     super.initState();
//     _notiFuture = _fetchNotifications();
//   }

//   Future<List<dynamic>> _fetchNotifications() async {
//     final user = supabase.auth.currentUser;
//     if (user == null) return [];

//     // ดึงข้อมูลออเดอร์มาเป็นรายการแจ้งเตือน
//     return await supabase
//         .from('orders')
//         .select('*, cameras(*)')
//         .eq('user_id', user.id)
//         .order('created_at', ascending: false);
//   }

//   void _showDetail(dynamic notiData) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       builder: (context) => NotiDetailSheet(data: notiData),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     const bg = Color(0xFF3A3A3A);

//     return Scaffold(
//       backgroundColor: bg,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Search Bar
//               _buildSearchBar(),
//               const SizedBox(height: 14),

//               // Header
//               _buildHeader(context),
//               const SizedBox(height: 10),

//               Expanded(
//                 child: FutureBuilder<List<dynamic>>(
//                   future: _notiFuture,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(child: CircularProgressIndicator(color: Colors.white));
//                     }
//                     if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return const Center(child: Text("ไม่มีการแจ้งเตือน", style: TextStyle(color: Colors.white70)));
//                     }

//                     final notifications = snapshot.data!;
//                     return ListView.builder(
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: notifications.length,
//                       itemBuilder: (context, index) {
//                         final noti = notifications[index];
//                         final status = noti['status'] ?? 'pending';
                        
//                         // ตั้งค่าสไตล์ตามสถานะ
//                         Color color = const Color(0xFF19C37D);
//                         IconData icon = Icons.check_circle_rounded;
//                         String title = "รายการเช่าของคุณได้รับการอนุมัติ";

//                         if (status == 'pending') {
//                           color = const Color(0xFFFFB020);
//                           icon = Icons.timer_rounded;
//                           title = "เพิ่มรายการกล้องเรียบร้อย";
//                         } else if (status == 'rejected') {
//                           color = const Color(0xFFFF5E5E);
//                           icon = Icons.error_rounded;
//                           title = "สลิปไม่ถูกต้อง";
//                         }

//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 10),
//                           child: _NotifyItem(
//                             color: color,
//                             icon: icon,
//                             title: title,
//                             subtitle: "เลขที่ ${noti['id'].toString().substring(0, 6).toUpperCase()} • แตะเพื่อดูรายละเอียด",
//                             time: _formatTime(noti['created_at']),
//                             onTap: () => _showDetail(noti), // ⭐ เรียกฟังก์ชันโชว์แผ่นสรุป
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 120),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // --- Helper Widgets ---
//   Widget _buildSearchBar() {
//     return Container(
//       height: 44,
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
//       child: Row(
//         children: const [
//           Icon(Icons.search, color: Colors.black54),
//           SizedBox(width: 8),
//           Expanded(child: Text("ค้นหาการแจ้งเตือน...", style: TextStyle(color: Colors.black45, fontSize: 13))),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Row(
//       children: [
//         IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
//           style: IconButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.12)),
//         ),
//         const SizedBox(width: 10),
//         const Text("การแจ้งเตือน", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
//       ],
//     );
//   }

//   String _formatTime(String? dateStr) {
//     if (dateStr == null) return "-";
//     final date = DateTime.parse(dateStr);
//     final diff = DateTime.now().difference(date);
//     if (diff.inMinutes < 60) return "${diff.inMinutes} นาทีที่แล้ว";
//     if (diff.inHours < 24) return "${diff.inHours} ชม.ที่แล้ว";
//     return DateFormat('dd MMM').format(date);
//   }
// }

// // คลาสลูกสำหรับแสดงรายการ (ไม่ต้องใส่ const หน้า constructor)
// class _NotifyItem extends StatelessWidget {
//   final Color color;
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final String time;
//   final VoidCallback onTap;

//   const _NotifyItem({
//     required this.color,
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.time,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(14),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.25),
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: 38, height: 38,
//               decoration: BoxDecoration(color: color.withOpacity(0.15), shape: BoxShape.circle),
//               child: Icon(icon, color: color, size: 20),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
//                   const SizedBox(height: 4),
//                   Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 11, height: 1.25)),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 8),
//             Text(time, style: const TextStyle(color: Colors.white60, fontSize: 10)),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:intl/intl.dart';
// import 'noti_detail_sheet.dart'; // ✅ นำเข้าไฟล์ที่แยกออกมา
// import 'noti_approved_page.dart';
// import 'noti_return_page.dart';

// class NotificationsUserPage extends StatefulWidget {
//   const NotificationsUserPage({super.key});

//   @override
//   State<NotificationsUserPage> createState() => _NotificationsUserPageState();
// }

// class _NotificationsUserPageState extends State<NotificationsUserPage> {
//   final supabase = Supabase.instance.client;
//   late Future<List<dynamic>> _notiFuture;

//   @override
//   void initState() {
//     super.initState();
//     _notiFuture = _fetchNotifications();
//   }

//   Future<List<dynamic>> _fetchNotifications() async {
//     final user = supabase.auth.currentUser;
//     if (user == null) return [];

//     // ดึงข้อมูลออเดอร์รวมถึงข้อมูลกล้องที่สัมพันธ์กัน
//     return await supabase
//         .from('orders')
//         .select('*, cameras(*)')
//         .eq('user_id', user.id)
//         .order('created_at', ascending: false);
//   }

//  // ✅ แก้ไขฟังก์ชันให้ตรวจสอบสถานะออเดอร์ก่อนแสดงผล
// void _showDetail(dynamic notiData) {
//   final status = notiData['status'] ?? 'pending';

//   if (status == 'completed') {
//     // ถ้าอนุมัติแล้ว ให้ไปหน้า NotiApprovedPage (กรอบดำ มีแถบสีเขียว)
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => NotiApprovedPage(data: notiData),
//       ),
//     );
//   } else {
//     // ถ้ากำลังรอตรวจ (pending) ให้ไปหน้า NotiDetailSheet (ตะกร้าเบื้องต้น)
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => NotiDetailSheet(data: notiData),
//       ),
//     );
//   }
// }
// void _showDetail(dynamic notiData) {
//   final status = notiData['status'] ?? 'pending';

//   if (status == 'completed') {
//     // อนุมัติแล้ว (กล่องดำ แถบเขียว)
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => NotiApprovedPage(data: notiData)),
//     );
//   } else if (status == 'returning') {
//     // ⭐ ถึงวันคืนอุปกรณ์ (กล่องดำ แถบเตือนสีเหลือง)
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => NotiReturnPage(data: notiData)),
//     );
//   } else {
//     // รอตรวจ/ตะกร้า (หน้าสรุป Bottom Sheet)
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => NotiDetailSheet(data: notiData)),
//     );
//   }
// }
//   @override
//   Widget build(BuildContext context) {
//     const bg = Color(0xFF3A3A3A);

//     return Scaffold(
//       backgroundColor: bg,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildSearchBar(),
//               const SizedBox(height: 14),
//               _buildHeader(context),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: FutureBuilder<List<dynamic>>(
//                   future: _notiFuture,
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(
//                         child: CircularProgressIndicator(color: Colors.white),
//                       );
//                     }
//                     if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                       return const Center(
//                         child: Text("ไม่มีการแจ้งเตือน",
//                             style: TextStyle(color: Colors.white70)),
//                       );
//                     }

//                     final notifications = snapshot.data!;
//                     return ListView.builder(
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: notifications.length,
//                       itemBuilder: (context, index) {
//                         final noti = notifications[index];
//                         final status = noti['status'] ?? 'pending';

//                         Color color = const Color(0xFF19C37D);
//                         IconData icon = Icons.check_circle_rounded;
//                         String title = "รายการเช่าของคุณได้รับการอนุมัติ";

//                         if (status == 'pending') {
//                           color = const Color(0xFFFFB020);
//                           icon = Icons.timer_rounded;
//                           title = "เพิ่มรายการกล้องเรียบร้อย";
//                         } else if (status == 'rejected') {
//                           color = const Color(0xFFFF5E5E);
//                           icon = Icons.error_rounded;
//                           title = "สลิปไม่ถูกต้อง";
//                         }

//                         // ✅ ลบ const ออกจากหน้า _NotifyItem
//                         return Padding(
//                           padding: const EdgeInsets.only(bottom: 10),
//                           child: _NotifyItem(
//                             color: color,
//                             icon: icon,
//                             title: title,
//                             subtitle:
//                                 "เลขที่ ${noti['id'].toString().substring(0, 6).toUpperCase()} • แตะเพื่อดูรายละเอียด",
//                             time: _formatTime(noti['created_at']),
//                             onTap: () => _showDetail(noti),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 120),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return Container(
//       height: 44,
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(14)),
//       child: Row(
//         children: const [
//           Icon(Icons.search, color: Colors.black54),
//           SizedBox(width: 8),
//           Expanded(
//               child: Text("ค้นหาการแจ้งเตือน...",
//                   style: TextStyle(color: Colors.black45, fontSize: 13))),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     return Row(
//       children: [
//         IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back_ios_new_rounded,
//               color: Colors.white, size: 18),
//           style: IconButton.styleFrom(
//               backgroundColor: Colors.white.withOpacity(0.12)),
//         ),
//         const SizedBox(width: 10),
//         const Text("การแจ้งเตือน",
//             style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w700)),
//       ],
//     );
//   }

//   String _formatTime(String? dateStr) {
//     if (dateStr == null) return "-";
//     final date = DateTime.parse(dateStr);
//     final diff = DateTime.now().difference(date);
//     if (diff.inMinutes < 60) return "${diff.inMinutes} นาทีที่แล้ว";
//     if (diff.inHours < 24) return "${diff.inHours} ชม.ที่แล้ว";
//     return DateFormat('dd MMM').format(date);
//   }
// }

// class _NotifyItem extends StatelessWidget {
//   final Color color;
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final String time;
//   final VoidCallback onTap;

//   // ✅ ลบ const ออกจาก Constructor นี้
//   _NotifyItem({
//     required this.color,
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.time,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(14),
//       child: Container(
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.25),
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: 38,
//               height: 38,
//               decoration: BoxDecoration(
//                   color: color.withOpacity(0.15), shape: BoxShape.circle),
//               child: Icon(icon, color: color, size: 20),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title,
//                       style: const TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                           fontSize: 13),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis),
//                   const SizedBox(height: 4),
//                   Text(subtitle,
//                       style: const TextStyle(
//                           color: Colors.white70, fontSize: 11, height: 1.25)),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 8),
//             Text(time,
//                 style: const TextStyle(color: Colors.white60, fontSize: 10)),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'noti_detail_sheet.dart'; 
import 'noti_approved_page.dart';
import 'noti_return_page.dart';
import 'noti_rejected_page.dart'; // ✅ เพิ่มนำเข้าหน้านี้ด้วย

class NotificationsUserPage extends StatefulWidget {
  const NotificationsUserPage({super.key});

  @override
  State<NotificationsUserPage> createState() => _NotificationsUserPageState();
}

class _NotificationsUserPageState extends State<NotificationsUserPage> {
  final supabase = Supabase.instance.client;
  late Future<List<dynamic>> _notiFuture;

  @override
  void initState() {
    super.initState();
    _notiFuture = _fetchNotifications();
  }

  Future<List<dynamic>> _fetchNotifications() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    // ดึงข้อมูลออเดอร์รวมถึงข้อมูลกล้องที่สัมพันธ์กัน
    return await supabase
        .from('orders')
        .select('*, cameras(*)')
        .eq('user_id', user.id)
        .order('created_at', ascending: false);
  }

  // ✅ รวมฟังก์ชันเดียว เช็คเงื่อนไขครบทุกสถานะ
  void _showDetail(dynamic notiData) {
    final status = notiData['status'] ?? 'pending';

    if (status == 'completed') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => NotiApprovedPage(data: notiData)));
    } else if (status == 'returning') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => NotiReturnPage(data: notiData)));
    } else if (status == 'rejected') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => NotiRejectedPage(data: notiData)));
    } else {
      // หน้า default สำหรับ pending หรือ สถานะอื่นๆ
      Navigator.push(context, MaterialPageRoute(builder: (context) => NotiDetailSheet(data: notiData)));
    }
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF3A3A3A);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 14),
              _buildHeader(context),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder<List<dynamic>>(
                  future: _notiFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("ไม่มีการแจ้งเตือน",
                            style: TextStyle(color: Colors.white70)),
                      );
                    }

                    final notifications = snapshot.data!;
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final noti = notifications[index];
                        final status = noti['status'] ?? 'pending';

                        // ค่า Default ถ้าไม่ตรงกับเงื่อนไขใดๆ
                        Color color = const Color(0xFF19C37D);
                        IconData icon = Icons.check_circle_rounded;
                        String title = "มีการอัปเดตรายการเช่า";

                        // เช็คสไตล์ตามสถานะ
                        if (status == 'completed') {
                          color = const Color(0xFF19C37D);
                          icon = Icons.check_circle_rounded;
                          title = "อนุมัติรายการเช่าเรียบร้อยแล้ว";
                        } else if (status == 'pending') {
                          color = const Color(0xFFFFB020);
                          icon = Icons.timer_rounded;
                          title = "เพิ่มรายการกล้องเรียบร้อย";
                        } else if (status == 'rejected') {
                          color = const Color(0xFFFF5E5E);
                          icon = Icons.error_rounded;
                          title = "สลิปไม่ถูกต้อง";
                        } else if (status == 'returning') {
                          color = Colors.blueAccent;
                          icon = Icons.notifications_active_rounded;
                          title = "เตือนวันคืนอุปกรณ์";
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _NotifyItem(
                            color: color,
                            icon: icon,
                            title: title,
                            subtitle:
                                "เลขที่ ${noti['id'].toString().substring(0, 6).toUpperCase()} • แตะเพื่อดูรายละเอียด",
                            time: _formatTime(noti['created_at']),
                            onTap: () => _showDetail(noti),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: const [
          Icon(Icons.search, color: Colors.black54),
          SizedBox(width: 8),
          Expanded(
              child: Text("ค้นหาการแจ้งเตือน...",
                  style: TextStyle(color: Colors.black45, fontSize: 13))),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 18),
          style: IconButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.12)),
        ),
        const SizedBox(width: 10),
        const Text("การแจ้งเตือน",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700)),
      ],
    );
  }

  String _formatTime(String? dateStr) {
    if (dateStr == null) return "-";
    final date = DateTime.parse(dateStr);
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return "${diff.inMinutes} นาทีที่แล้ว";
    if (diff.inHours < 24) return "${diff.inHours} ชม.ที่แล้ว";
    return DateFormat('dd MMM').format(date);
  }
}

class _NotifyItem extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final VoidCallback onTap;

  _NotifyItem({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.25),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                  color: color.withOpacity(0.15), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 13),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 11, height: 1.25)),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(time,
                style: const TextStyle(color: Colors.white60, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}