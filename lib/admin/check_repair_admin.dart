// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:intl/intl.dart';

// class CheckRepairAdminPage extends StatefulWidget {
//   final dynamic orderId;

//   const CheckRepairAdminPage({super.key, required this.orderId});

//   @override
//   State<CheckRepairAdminPage> createState() => _CheckRepairAdminPageState();
// }

// class _CheckRepairAdminPageState extends State<CheckRepairAdminPage> {
//   final supabase = Supabase.instance.client;
//   bool _isLoading = true;
//   Map<String, dynamic>? _orderData;
//   final TextEditingController _adminRemarkController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _fetchRepairDetails();
//   }

//   // ดึงข้อมูลออเดอร์ที่มีการแจ้งซ่อม
//   Future<void> _fetchRepairDetails() async {
//     try {
//       final response = await supabase
//           .from('orders')
//           .select('*, profiles(full_name), cameras(*)')
//           .eq('id', widget.orderId)
//           .single();

//       setState(() {
//         _orderData = response;
//         // สมมติว่ามีฟิลด์ admin_repair_remark ใน DB
//         _adminRemarkController.text = response['admin_remark'] ?? '';
//         _isLoading = false;
//       });
//     } catch (e) {
//       debugPrint("Error fetching repair data: $e");
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   // อนุมัติการซ่อม
//   Future<void> _approveRepair() async {
//     setState(() => _isLoading = true);
//     try {
//       await supabase.from('orders').update({
//         'status': 'repairing', // เปลี่ยนสถานะเป็นกำลังซ่อม
//         'admin_remark': _adminRemarkController.text,
//       }).eq('id', widget.orderId);

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('✅ อนุมัติการแจ้งซ่อมเรียบร้อย'), backgroundColor: Colors.green),
//         );
//         Navigator.pop(context);
//       }
//     } catch (e) {
//       debugPrint("Error approving repair: $e");
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   // ปฏิเสธการแจ้งซ่อม
//   Future<void> _rejectRepair() async {
//     if (_adminRemarkController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('กรุณาใส่หมายเหตุด้านล่างก่อนกดปฏิเสธ'), backgroundColor: Colors.orange),
//       );
//       return;
//     }

//     setState(() => _isLoading = true);
//     try {
//       await supabase.from('orders').update({
//         'status': 'repair_rejected',
//         'admin_remark': _adminRemarkController.text,
//       }).eq('id', widget.orderId);

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('❌ ปฏิเสธการแจ้งซ่อมแล้ว'), backgroundColor: Colors.redAccent),
//         );
//         Navigator.pop(context);
//       }
//     } catch (e) {
//       debugPrint("Error rejecting repair: $e");
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     const bg = Color(0xFF5B5B5B);
    
//     String formattedDate = "-";
//     if (_orderData != null && _orderData!['created_at'] != null) {
//       formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.parse(_orderData!['created_at']));
//     }
//     String orderIdText = "ORD-${widget.orderId.toString().padLeft(3, '0')}";

//     // สมมติว่ามีฟิลด์ repair_remark และ repair_image_url ที่ลูกค้าส่งมา
//     String customerRemark = _orderData?['repair_remark'] ?? "ลูกค้าไม่ได้ระบุหมายเหตุ";
//     String? repairImageUrl = _orderData?['repair_image_url'];

//     return Scaffold(
//       backgroundColor: bg,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white), 
//           onPressed: () => Navigator.pop(context)
//         ),
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator(color: Colors.white))
//           : _orderData == null
//               ? const Center(child: Text("ไม่พบข้อมูลการแจ้งซ่อม", style: TextStyle(color: Colors.white)))
//               : SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // --- หัวข้อ ---
//                       const Text("ส่งเข้าซ่อม", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 4),
//                       Text(orderIdText, style: const TextStyle(color: Colors.white70, fontSize: 14)),
//                       const SizedBox(height: 24),

//                       // --- 1. ข้อมูลลูกค้า ---
//                       _buildWhiteCard(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text("ชื่อลูกค้า", style: TextStyle(color: Colors.black54, fontSize: 12)),
//                                 const SizedBox(height: 4),
//                                 Text(_orderData!['profiles']?['full_name'] ?? "ไม่ระบุชื่อ", style: const TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text("วันที่ส่ง", style: TextStyle(color: Colors.black54, fontSize: 12)),
//                                 const SizedBox(height: 4),
//                                 Text(formattedDate, style: const TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
//                               ],
//                             ),
//                             const SizedBox(width: 20),
//                           ],
//                         ),
//                       ),

//                       // --- 2. หมายเหตุที่แจ้งซ่อม (จากลูกค้า) ---
//                       _buildWhiteCard(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text("หมายเหตุที่แจ้งซ่อม", style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold)),
//                             const SizedBox(height: 12),
//                             Container(
//                               width: double.infinity,
//                               minHeight: 100,
//                               padding: const EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFE0E0E0), // สีเทาอ่อนตามรูป
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Text(customerRemark, style: const TextStyle(color: Colors.black87, fontSize: 13)),
//                             ),
//                           ],
//                         ),
//                       ),

//                       // --- 3. รูปภาพความเสียหาย ---
//                       _buildWhiteCard(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text("รูปภาพ", style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold)),
//                             const SizedBox(height: 12),
//                             Container(
//                               width: double.infinity,
//                               height: 200,
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFF5F5F5),
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(color: Colors.black12),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: repairImageUrl != null
//                                     ? InteractiveViewer(
//                                         child: Image.network(repairImageUrl, fit: BoxFit.contain),
//                                       )
//                                     : const Center(child: Text("ไม่มีรูปภาพแนบมา", style: TextStyle(color: Colors.black45))),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       // --- 4. รายการอุปกรณ์ ---
//                       _buildWhiteCard(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text("รายการอุปกรณ์ที่ยืมไป", style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.bold)),
//                             const SizedBox(height: 16),
//                             Row(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(8),
//                                   child: Image.network(
//                                     _orderData!['cameras']?['image_url'] ?? '',
//                                     width: 60, height: 60, fit: BoxFit.cover,
//                                     errorBuilder: (context, error, stackTrace) => Container(width: 60, height: 60, color: Colors.grey[300]),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 16),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(_orderData!['cameras']?['name'] ?? "ไม่ระบุอุปกรณ์", style: const TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w600)),
//                                       const SizedBox(height: 4),
//                                       Text("฿${_orderData!['total_price']}", style: const TextStyle(color: Colors.black54, fontSize: 13)),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),

//                       // --- 5. ปุ่ม Action (ปฏิเสธ / อนุมัติ) ---
//                       Row(
//                         children: [
//                           Expanded(
//                             child: ElevatedButton.icon(
//                               onPressed: _rejectRepair,
//                               icon: const Icon(Icons.cancel_outlined, color: Colors.white, size: 18),
//                               label: const Text("ปฏิเสธ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFFE53935),
//                                 padding: const EdgeInsets.symmetric(vertical: 14),
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 15),
//                           Expanded(
//                             child: ElevatedButton.icon(
//                               onPressed: _approveRepair,
//                               icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
//                               label: const Text("อนุมัติการซ่อม", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF4CAF50),
//                                 padding: const EdgeInsets.symmetric(vertical: 14),
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 15),

//                       // --- 6. กล่องหมายเหตุ (แอดมินพิมพ์) ---
//                       Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.symmetric(vertical: 12),
//                         decoration: BoxDecoration(
//                           color: const Color(0xFFF57C00), // สีส้ม
//                           borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
//                         ),
//                         child: const Center(child: Text("หมายเหตุ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         decoration: const BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
//                         ),
//                         child: TextField(
//                           controller: _adminRemarkController,
//                           maxLines: 3,
//                           style: const TextStyle(color: Colors.black87, fontSize: 13),
//                           decoration: const InputDecoration(
//                             hintText: 'ใส่หมายเหตุ (ถ้าปฏิเสธต้องระบุเหตุผล)',
//                             hintStyle: TextStyle(color: Colors.black38),
//                             contentPadding: EdgeInsets.all(16),
//                             border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 40),
//                     ],
//                   ),
//                 ),
//     );
//   }

//   // Widget ช่วยสร้างการ์ดสีขาวแบบย่อโค้ด
//   Widget _buildWhiteCard({required Widget child}) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: child,
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class CheckRepairAdminPage extends StatefulWidget {
  final dynamic orderId;

  const CheckRepairAdminPage({super.key, required this.orderId});

  @override
  State<CheckRepairAdminPage> createState() => _CheckRepairAdminPageState();
}

class _CheckRepairAdminPageState extends State<CheckRepairAdminPage> {
  final supabase = Supabase.instance.client;
  bool _isLoading = true;
  Map<String, dynamic>? _orderData;
  final TextEditingController _adminRemarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchRepairDetails();
  }

  @override
  void dispose() {
    _adminRemarkController.dispose();
    super.dispose();
  }

  // ดึงข้อมูลออเดอร์ที่มีการแจ้งซ่อม
  Future<void> _fetchRepairDetails() async {
    try {
      final response = await supabase
          .from('orders')
          .select('*, profiles(full_name), cameras(*)')
          .eq('id', widget.orderId)
          .single();

      setState(() {
        _orderData = response;
        _adminRemarkController.text = response['admin_remark'] ?? '';
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching repair data: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // อนุมัติการซ่อม
  Future<void> _approveRepair() async {
    setState(() => _isLoading = true);
    try {
      await supabase.from('orders').update({
        'status': 'repairing',
        'admin_remark': _adminRemarkController.text,
      }).eq('id', widget.orderId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ อนุมัติการแจ้งซ่อมเรียบร้อย'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint("Error approving repair: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ปฏิเสธการแจ้งซ่อม
  Future<void> _rejectRepair() async {
    if (_adminRemarkController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('กรุณาใส่หมายเหตุด้านล่างก่อนกดปฏิเสธ'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await supabase.from('orders').update({
        'status': 'repair_rejected',
        'admin_remark': _adminRemarkController.text,
      }).eq('id', widget.orderId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ ปฏิเสธการแจ้งซ่อมแล้ว'),
            backgroundColor: Colors.redAccent,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint("Error rejecting repair: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF5B5B5B);

    String formattedDate = "-";
    if (_orderData != null && _orderData!['created_at'] != null) {
      formattedDate = DateFormat('dd/MM/yyyy')
          .format(DateTime.parse(_orderData!['created_at']));
    }
    String orderIdText = "ORD-${widget.orderId.toString().padLeft(3, '0')}";

    String customerRemark =
        _orderData?['repair_remark'] ?? "ลูกค้าไม่ได้ระบุหมายเหตุ";
    String? repairImageUrl = _orderData?['repair_image_url'];

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.white),
            )
          : _orderData == null
              ? const Center(
                  child: Text(
                    "ไม่พบข้อมูลการแจ้งซ่อม",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- หัวข้อ ---
                      const Text(
                        "ส่งเข้าซ่อม",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        orderIdText,
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 24),

                      // --- 1. ข้อมูลลูกค้า ---
                      _buildWhiteCard(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "ชื่อลูกค้า",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _orderData!['profiles']?['full_name'] ??
                                      "ไม่ระบุชื่อ",
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "วันที่ส่ง",
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  formattedDate,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ),

                      // --- 2. หมายเหตุที่แจ้งซ่อม (จากลูกค้า) ---
                      _buildWhiteCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "หมายเหตุที่แจ้งซ่อม",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              // ✅ FIX: Container ไม่มี minHeight ให้ใช้ constraints แทน
                              constraints: const BoxConstraints(minHeight: 100),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0E0E0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                customerRemark,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // --- 3. รูปภาพความเสียหาย ---
                      _buildWhiteCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "รูปภาพ",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: repairImageUrl != null
                                    ? InteractiveViewer(
                                        child: Image.network(
                                          repairImageUrl,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                    : const Center(
                                        child: Text(
                                          "ไม่มีรูปภาพแนบมา",
                                          style: TextStyle(color: Colors.black45),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // --- 4. รายการอุปกรณ์ ---
                      _buildWhiteCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "รายการอุปกรณ์ที่ยืมไป",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    _orderData!['cameras']?['image_url'] ?? '',
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      width: 60,
                                      height: 60,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _orderData!['cameras']?['name'] ??
                                            "ไม่ระบุอุปกรณ์",
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "฿${_orderData!['total_price']}",
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // --- 5. ปุ่ม Action (ปฏิเสธ / อนุมัติ) ---
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _rejectRepair,
                              icon: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                              label: const Text(
                                "ปฏิเสธ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE53935),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _approveRepair,
                              icon: const Icon(
                                Icons.check_circle_outline,
                                color: Colors.white,
                                size: 18,
                              ),
                              label: const Text(
                                "อนุมัติการซ่อม",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4CAF50),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // --- 6. กล่องหมายเหตุ (แอดมินพิมพ์) ---
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF57C00),
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(8)),
                        ),
                        child: const Center(
                          child: Text(
                            "หมายเหตุ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(8)),
                        ),
                        child: TextField(
                          controller: _adminRemarkController,
                          maxLines: 3,
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 13),
                          decoration: const InputDecoration(
                            hintText: 'ใส่หมายเหตุ (ถ้าปฏิเสธต้องระบุเหตุผล)',
                            hintStyle: TextStyle(color: Colors.black38),
                            contentPadding: EdgeInsets.all(16),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
    );
  }

  // Widget ช่วยสร้างการ์ดสีขาวแบบย่อโค้ด
  Widget _buildWhiteCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
