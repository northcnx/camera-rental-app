// import 'package:flutter/material.dart';

// class FavoritesAdmin extends StatelessWidget {
//   const FavoritesAdmin({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(child: Text("Favorite User")),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:intl/intl.dart';

// class FavoritesAdmin extends StatefulWidget {
//   const FavoritesAdmin({super.key});

//   @override
//   State<FavoritesAdmin> createState() => _FavoritesAdminState();
// }

// class _FavoritesAdminState extends State<FavoritesAdmin> {
//   final supabase = Supabase.instance.client;
//   bool _isLoading = true;
//   // ป้องกัน Error โดยการกำหนดให้เป็น List ว่างไว้ก่อน
//   List<Map<String, dynamic>> _notifications = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchNotifications();
//   }

//   // ดึงข้อมูลกิจกรรมต่างๆ มาสร้างเป็นรายการแจ้งเตือน
//   Future<void> _fetchNotifications() async {
//     if (!mounted) return;
//     setState(() => _isLoading = true);

//     try {
//       final List<Map<String, dynamic>> allNotis = [];

//       // 1. ดึงออเดอร์ที่รอตรวจสอบสลิป (Status = pending)
//       final pendingOrders = await supabase
//           .from('orders')
//           .select('id, created_at, profiles(full_name)')
//           .eq('status', 'pending');

//       if (pendingOrders != null) {
//         for (var order in pendingOrders) {
//           allNotis.add({
//             'id': order['id'],
//             'type': 'payment',
//             'title': 'ตรวจสอบยอดชำระเงินใหม่',
//             'subtitle': 'ลูกค้า: ${order['profiles']?['full_name'] ?? "ไม่ระบุชื่อ"} ส่งสลิปมา',
//             'time': DateTime.parse(order['created_at']),
//             'icon': Icons.account_balance_wallet,
//             'color': Colors.blue,
//           });
//         }
//       }

//       // 2. ดึงรายการที่ต้องคืนวันนี้ (เช็คจาก end_date ใน carts หรือตารางเช่า)
//       final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
//       final returns = await supabase
//           .from('carts')
//           .select('id, cameras(name), profiles(full_name)')
//           .eq('end_date', today);

//       if (returns != null) {
//         for (var item in returns) {
//           allNotis.add({
//             'id': item['id'],
//             'type': 'return',
//             'title': 'ถึงกำหนดคืนกล้องวันนี้',
//             'subtitle': 'ลูกค้า: ${item['profiles']?['full_name'] ?? "ไม่ระบุชื่อ"} ต้องคืน ${item['cameras']?['name'] ?? "อุปกรณ์"}',
//             'time': DateTime.now(),
//             'icon': Icons.assignment_return,
//             'color': Colors.orange,
//           });
//         }
//       }

//       // เรียงลำดับตามเวลาล่าสุด
//       allNotis.sort((a, b) => b['time'].compareTo(a['time']));

//       if (mounted) {
//         setState(() {
//           _notifications = allNotis;
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       debugPrint('Error: $e');
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF5B5B5B), // พื้นหลังสีเทาตามสไตล์ Admin
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'การแจ้งเตือน',
//                     style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.refresh, color: Colors.white),
//                     onPressed: _fetchNotifications,
//                   )
//                 ],
//               ),
//             ),
//             Expanded(
//               child: _isLoading
//                   ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                   : _notifications.isEmpty // ตรวจสอบว่า List ว่างหรือไม่
//                       ? _buildEmptyState()
//                       : ListView.builder(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           itemCount: _notifications.length,
//                           itemBuilder: (context, index) {
//                             final noti = _notifications[index];
//                             return _buildNotiCard(noti, index);
//                           },
//                         ),
//             ),
//             const SizedBox(height: 100), // พื้นที่ว่างกันแถบเมนูบัง
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNotiCard(Map<String, dynamic> noti, int index) {
//     return Dismissible(
//       key: Key('${noti['id']}_$index'),
//       direction: DismissDirection.endToStart,
//       onDismissed: (direction) {
//         setState(() => _notifications.removeAt(index));
//       },
//       background: Container(
//         alignment: Alignment.centerRight,
//         padding: const EdgeInsets.only(right: 20),
//         decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(15)),
//         child: const Icon(Icons.delete, color: Colors.white),
//       ),
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: noti['color'].withOpacity(0.2),
//               child: Icon(noti['icon'], color: noti['color']),
//             ),
//             const SizedBox(width: 15),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(noti['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
//                   const SizedBox(height: 4),
//                   Text(noti['subtitle'], style: const TextStyle(color: Colors.grey, fontSize: 13)),
//                   const SizedBox(height: 8),
//                   Text(
//                     DateFormat('HH:mm - dd MMM').format(noti['time']),
//                     style: const TextStyle(color: Colors.blueGrey, fontSize: 11),
//                   ),
//                 ],
//               ),
//             ),
//             const Icon(Icons.chevron_right, color: Colors.grey),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.notifications_none, size: 80, color: Colors.white.withOpacity(0.3)),
//           const SizedBox(height: 16),
//           const Text('ไม่มีการแจ้งเตือนในขณะนี้', style: TextStyle(color: Colors.white70)),
//         ],
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:intl/intl.dart';

// class FavoritesAdmin extends StatefulWidget {
//   const FavoritesAdmin({super.key});

//   @override
//   State<FavoritesAdmin> createState() => _FavoritesAdminState();
// }

// class _FavoritesAdminState extends State<FavoritesAdmin> with SingleTickerProviderStateMixin {
//   final supabase = Supabase.instance.client;
//   bool _isLoading = true;
//   List<Map<String, dynamic>> _notifications = [];
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _fetchNotifications();
//   }

//   Future<void> _fetchNotifications() async {
//     if (!mounted) return;
//     setState(() => _isLoading = true);

//     try {
//       final List<Map<String, dynamic>> allNotis = [];

//       // 1. ดึงออเดอร์ที่รอตรวจสอบสลิป
//       final pendingOrders = await supabase
//           .from('orders')
//           .select('id, created_at, total_price, profiles(full_name)')
//           .eq('status', 'pending');

//       if (pendingOrders != null) {
//         for (var order in pendingOrders) {
//           allNotis.add({
//             'id': order['id'],
//             'type': 'payment',
//             'title': 'ตรวจสอบยอดชำระเงิน ฿${order['total_price']}',
//             'subtitle': 'ลูกค้า: ${order['profiles']?['full_name'] ?? "ไม่ระบุชื่อ"}',
//             'time': DateTime.parse(order['created_at']),
//             'icon': Icons.account_balance_wallet_rounded,
//             'color': Colors.blueAccent,
//             'route': 'payment_check', // สำหรับกดแล้วลิงก์ไปหน้าตรวจสอบ
//           });
//         }
//       }

//       // 2. ดึงรายการที่ถึงกำหนดคืนวันนี้
//       final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
//       final returns = await supabase
//           .from('carts')
//           .select('id, cameras(name), profiles(full_name)')
//           .eq('end_date', today);

//       if (returns != null) {
//         for (var item in returns) {
//           allNotis.add({
//             'id': item['id'],
//             'type': 'return',
//             'title': 'ถึงกำหนดคืน: ${item['cameras']?['name'] ?? "อุปกรณ์"}',
//             'subtitle': 'ลูกค้า: ${item['profiles']?['full_name'] ?? "ไม่ระบุชื่อ"}',
//             'time': DateTime.now(),
//             'icon': Icons.assignment_return_rounded,
//             'color': Colors.orangeAccent,
//             'route': 'inventory',
//           });
//         }
//       }

//       allNotis.sort((a, b) => b['time'].compareTo(a['time']));

//       if (mounted) {
//         setState(() {
//           _notifications = allNotis;
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       debugPrint('Error: $e');
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF5B5B5B),
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Text('การแจ้งเตือน', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh_rounded, color: Colors.white),
//             onPressed: _fetchNotifications,
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.blueAccent,
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.white60,
//           tabs: [
//             Tab(text: 'ใหม่ (${_notifications.length})'),
//             const Tab(text: 'ประวัติ'),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: TabBarView(
//           controller: _tabController,
//           children: [
//             // Tab 1: รายการใหม่
//             _isLoading
//                 ? const Center(child: CircularProgressIndicator(color: Colors.white))
//                 : _notifications.isEmpty
//                     ? _buildEmptyState()
//                     : ListView.builder(
//                         padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
//                         itemCount: _notifications.length,
//                         itemBuilder: (context, index) {
//                           return _buildNotiCard(_notifications[index], index);
//                         },
//                       ),
//             // Tab 2: ประวัติ (จำลองไว้ก่อน)
//             _buildEmptyState(message: 'ยังไม่มีประวัติการแจ้งเตือน'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNotiCard(Map<String, dynamic> noti, int index) {
//     return Dismissible(
//       key: Key('${noti['id']}_$index'),
//       direction: DismissDirection.endToStart,
//       onDismissed: (direction) {
//         setState(() => _notifications.removeAt(index));
//       },
//       background: Container(
//         alignment: Alignment.centerRight,
//         padding: const EdgeInsets.only(right: 20),
//         margin: const EdgeInsets.only(bottom: 12),
//         decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(15)),
//         child: const Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 30),
//       ),
//       child: GestureDetector(
//         onTap: () {
//           // TODO: เพิ่ม logic Navigator.push ไปหน้าตรวจสอบของแต่ละประเภท
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('เปิดหน้าสำหรับ ${noti['title']}')),
//           );
//         },
//         child: Container(
//           margin: const EdgeInsets.only(bottom: 12),
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.95),
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: [
//               BoxShadow(color: Colors.black26, blurRadius: 5, offset: const Offset(0, 2)),
//             ],
//           ),
//           child: Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: noti['color'].withOpacity(0.15),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(noti['icon'], color: noti['color'], size: 28),
//               ),
//               const SizedBox(width: 15),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(noti['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
//                     const SizedBox(height: 4),
//                     Text(noti['subtitle'], style: const TextStyle(color: Colors.black54, fontSize: 13)),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         const Icon(Icons.access_time, size: 12, color: Colors.grey),
//                         const SizedBox(width: 4),
//                         Text(
//                           DateFormat('HH:mm - dd MMM').format(noti['time']),
//                           style: const TextStyle(color: Colors.grey, fontSize: 11),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState({String message = 'ไม่มีการแจ้งเตือนในขณะนี้'}) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.notifications_off_outlined, size: 100, color: Colors.white.withOpacity(0.2)),
//           const SizedBox(height: 16),
//           Text(message, style: const TextStyle(color: Colors.white70, fontSize: 16)),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

// ✅ นำเข้าไฟล์หน้าตรวจสอบของ Admin ที่เราสร้างไว้
import 'check_slip_admin.dart'; 
import 'check_repair_admin.dart';

class FavoritesAdmin extends StatefulWidget {
  const FavoritesAdmin({super.key});

  @override
  State<FavoritesAdmin> createState() => _FavoritesAdminState();
}

class _FavoritesAdminState extends State<FavoritesAdmin> with SingleTickerProviderStateMixin {
  final supabase = Supabase.instance.client;
  bool _isLoading = true;
  List<Map<String, dynamic>> _notifications = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchNotifications();
  }

  // ฟังก์ชันดึงข้อมูลการแจ้งเตือนทั้งหมดจาก Supabase
  Future<void> _fetchNotifications() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      final List<Map<String, dynamic>> allNotis = [];

      // 1. ดึงออเดอร์ที่รอตรวจสอบสลิป (pending)
      final pendingOrders = await supabase
          .from('orders')
          .select('id, created_at, total_price, profiles(full_name)')
          .eq('status', 'pending');

      if (pendingOrders != null) {
        for (var order in pendingOrders) {
          allNotis.add({
            'id': order['id'],
            'type': 'payment', // ประเภท: สลิปใหม่
            'title': 'มีสลิปใหม่ถูกอัปโหลด',
            'subtitle': 'จากลูกค้า: ${order['profiles']?['full_name'] ?? "ไม่ระบุชื่อ"}',
            'time': DateTime.parse(order['created_at']),
            'icon': Icons.receipt_long_rounded,
            'color': Colors.blueAccent,
          });
        }
      }

      // 2. ดึงรายการแจ้งซ่อม (repair_requested)
      final repairOrders = await supabase
          .from('orders')
          .select('id, created_at, profiles(full_name), cameras(name)')
          .eq('status', 'repair_requested');

      if (repairOrders != null) {
        for (var order in repairOrders) {
          allNotis.add({
            'id': order['id'],
            'type': 'repair', // ประเภท: แจ้งซ่อม
            'title': '${order['cameras']?['name'] ?? "อุปกรณ์"} ส่งเข้าซ่อม',
            'subtitle': 'จากลูกค้า: ${order['profiles']?['full_name'] ?? "ไม่ระบุชื่อ"}',
            'time': DateTime.parse(order['created_at']),
            'icon': Icons.build_circle_rounded,
            'color': Colors.orange,
          });
        }
      }

      // 3. ดึงรายการที่นำของมาคืนแล้ว (returned)
      final returnedOrders = await supabase
          .from('orders')
          .select('id, created_at, profiles(full_name), cameras(name)')
          .eq('status', 'returned');

      if (returnedOrders != null) {
        for (var order in returnedOrders) {
          allNotis.add({
            'id': order['id'],
            'type': 'returned', // ประเภท: คืนอุปกรณ์แล้ว
            'title': '${order['cameras']?['name'] ?? "อุปกรณ์"} ถูกคืนแล้ว',
            'subtitle': 'รับคืนจาก: ${order['profiles']?['full_name'] ?? "ไม่ระบุชื่อ"}',
            'time': DateTime.parse(order['created_at']),
            'icon': Icons.replay_circle_filled_rounded,
            'color': Colors.grey,
          });
        }
      }

      // เรียงลำดับจากเวลาใหม่สุดไปเก่าสุด
      allNotis.sort((a, b) => b['time'].compareTo(a['time']));

      if (mounted) {
        setState(() {
          _notifications = allNotis;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error fetching notis: $e');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5B5B5B), // สีพื้นหลังเทาเข้มของ Admin
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('การแจ้งเตือน', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            onPressed: _fetchNotifications, // ปุ่มรีเฟรชข้อมูล
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blueAccent,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: [
            Tab(text: 'ใหม่ (${_notifications.length})'),
            const Tab(text: 'ประวัติ'),
          ],
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            // Tab 1: รายการแจ้งเตือนใหม่
            _isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                : _notifications.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                        physics: const BouncingScrollPhysics(),
                        itemCount: _notifications.length,
                        itemBuilder: (context, index) {
                          return _buildNotiCard(_notifications[index], index);
                        },
                      ),
            
            // Tab 2: ประวัติการแจ้งเตือน (จำลองไว้ก่อน)
            _buildEmptyState(message: 'ยังไม่มีประวัติการแจ้งเตือน'),
          ],
        ),
      ),
    );
  }

  // Widget สร้างการ์ดแจ้งเตือนแต่ละอัน
  Widget _buildNotiCard(Map<String, dynamic> noti, int index) {
    return Dismissible(
      key: Key('${noti['id']}_$index'),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // เมื่อปัดซ้ายให้ลบออกจากการแสดงผลหน้าจอ
        setState(() => _notifications.removeAt(index));
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(15)),
        child: const Icon(Icons.delete_sweep_rounded, color: Colors.white, size: 30),
      ),
      child: GestureDetector(
        onTap: () {
          // ⭐ Logic การลิงก์ไปหน้าต่างๆ ตามประเภทการแจ้งเตือน
          if (noti['type'] == 'payment') {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => CheckSlipAdminPage(orderId: noti['id']))
            ).then((_) => _fetchNotifications()); // กลับมาให้รีเฟรช 1 รอบ
          } 
          else if (noti['type'] == 'repair') {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => CheckRepairAdminPage(orderId: noti['id']))
            ).then((_) => _fetchNotifications());
          } 
          else if (noti['type'] == 'returned') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('อุปกรณ์ถูกรับคืนเข้าคลังเรียบร้อยแล้ว')),
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 2)),
            ],
          ),
          child: Row(
            children: [
              // ไอคอนวงกลมด้านซ้าย
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: noti['color'].withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(noti['icon'], color: noti['color'], size: 28),
              ),
              const SizedBox(width: 15),
              
              // รายละเอียดตรงกลาง
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(noti['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Text(noti['subtitle'], style: const TextStyle(color: Colors.black54, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          _formatTimeAgo(noti['time']),
                          style: const TextStyle(color: Colors.grey, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // ลูกศรขวาสุด
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Widget หน้าจอว่างเปล่า (เมื่อไม่มีการแจ้งเตือน)
  Widget _buildEmptyState({String message = 'ไม่มีการแจ้งเตือนในขณะนี้'}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 100, color: Colors.white.withOpacity(0.2)),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }

  // ฟังก์ชันจัดฟอร์แมตเวลา (เช่น 5 นาทีที่แล้ว, 2 ชั่วโมงที่แล้ว)
  String _formatTimeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 60) return '${diff.inMinutes} นาทีที่แล้ว';
    if (diff.inHours < 24) return '${diff.inHours} ชั่วโมงที่แล้ว';
    if (diff.inDays < 30) return '${diff.inDays} วันที่แล้ว';
    return DateFormat('dd MMM yyyy').format(date);
  }
}