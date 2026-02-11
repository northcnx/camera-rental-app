import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class CheckSlipAdminPage extends StatefulWidget {
  final dynamic orderId;

  const CheckSlipAdminPage({super.key, required this.orderId});

  @override
  State<CheckSlipAdminPage> createState() => _CheckSlipAdminPageState();
}

class _CheckSlipAdminPageState extends State<CheckSlipAdminPage> {
  final supabase = Supabase.instance.client;
  bool _isLoading = true;
  Map<String, dynamic>? _orderData;

  @override
  void initState() {
    super.initState();
    _fetchOrderDetails();
  }

  // ดึงข้อมูล
  Future<void> _fetchOrderDetails() async {
    try {
      final response = await supabase
          .from('orders')
          .select('*, profiles(full_name), cameras(*)') // ดึงข้อมูล cameras มาทั้งหมดเพื่อเอารูปด้วย
          .eq('id', widget.orderId)
          .single();

      setState(() {
        _orderData = response;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching order: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // อนุมัติสลิป
  Future<void> _approveOrder() async {
    setState(() => _isLoading = true);
    try {
      await supabase.from('orders').update({
        'status': 'completed',
        'admin_remark': null,
      }).eq('id', widget.orderId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ อนุมัติการชำระเงินเรียบร้อยแล้ว'), backgroundColor: Colors.green),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint("Error approving: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // ปฏิเสธสลิป
  Future<void> _rejectOrder() async {
    final TextEditingController remarkController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2C),
        title: const Text('ปฏิเสธสลิปชำระเงิน', style: TextStyle(color: Colors.white, fontSize: 18)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('ระบุเหตุผลที่ปฏิเสธ เพื่อให้ลูกค้าแก้ไข:', style: TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 12),
            TextField(
              controller: remarkController,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'เช่น ยอดเงินไม่ตรง, ภาพเบลอ...',
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('ยกเลิก', style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('ยืนยันการปฏิเสธ', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (result == true) {
      setState(() => _isLoading = true);
      try {
        await supabase.from('orders').update({
          'status': 'rejected',
          'admin_remark': remarkController.text.isNotEmpty ? remarkController.text : 'ยอดเงินในสลิปไม่ตรง หรือภาพไม่ชัดเจน',
        }).eq('id', widget.orderId);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('❌ ปฏิเสธสลิปและแจ้งลูกค้าแล้ว'), backgroundColor: Colors.redAccent),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        debugPrint("Error rejecting: $e");
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  // ฟังก์ชันสำหรับปุ่ม "หมายเหตุ" (บันทึกโน้ตภายใน)
  Future<void> _addRemarkOnly() async {
    final TextEditingController remarkController = TextEditingController(text: _orderData?['admin_remark'] ?? '');
    
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C2C2C),
        title: const Text('เพิ่มหมายเหตุ (ภายใน)', style: TextStyle(color: Colors.white, fontSize: 18)),
        content: TextField(
          controller: remarkController,
          style: const TextStyle(color: Colors.white),
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'พิมพ์หมายเหตุที่นี่...',
            hintStyle: const TextStyle(color: Colors.white38),
            filled: true,
            fillColor: const Color(0xFF1E1E1E),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('ยกเลิก', style: TextStyle(color: Colors.grey))),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, remarkController.text),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('บันทึก', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (result != null) {
      try {
        await supabase.from('orders').update({'admin_remark': result}).eq('id', widget.orderId);
        setState(() => _orderData!['admin_remark'] = result);
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('บันทึกหมายเหตุแล้ว')));
      } catch (e) {
        debugPrint("Error saving remark: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF5B5B5B); 
    
    // จัดรูปแบบวันที่
    String formattedDate = "-";
    if (_orderData != null && _orderData!['created_at'] != null) {
      formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.parse(_orderData!['created_at']));
    }

    // จัดรูปแบบ Order ID
    String orderIdText = "ORD-${widget.orderId.toString().padLeft(3, '0')}";

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : _orderData == null
              ? const Center(child: Text("ไม่พบข้อมูลออเดอร์", style: TextStyle(color: Colors.white)))
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- หัวข้อ ---
                      const Text("ตรวจสอบการชำระเงิน", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(orderIdText, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                      const SizedBox(height: 24),

                      // --- 1. การ์ดชื่อลูกค้า & วันที่ ---
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("ชื่อลูกค้า", style: TextStyle(color: Colors.black54, fontSize: 12)),
                                const SizedBox(height: 4),
                                Text(_orderData!['profiles']?['full_name'] ?? "ไม่ระบุชื่อ", style: const TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("วันที่สั่ง", style: TextStyle(color: Colors.black54, fontSize: 12)),
                                const SizedBox(height: 4),
                                Text(formattedDate, style: const TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(width: 20), // เผื่อที่ว่างขวาเล็กน้อยให้สมดุล
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // --- 2. การ์ดสลิปโอนเงิน ---
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("สลิปการโอนเงิน", style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            Container(
                              width: double.infinity,
                              height: 350,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5), // สีพื้นหลังเทาอ่อนๆ กรอบรูป
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: _orderData!['slip_url'] != null
                                    ? InteractiveViewer( // ซูมสลิปได้
                                        child: Image.network(
                                          _orderData!['slip_url'],
                                          fit: BoxFit.contain,
                                          errorBuilder: (context, error, stackTrace) => const Center(child: Text('โหลดภาพไม่สำเร็จ', style: TextStyle(color: Colors.red))),
                                        ),
                                      )
                                    : const Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.image_not_supported_outlined, color: Colors.black26, size: 40),
                                            SizedBox(height: 8),
                                            Text("ไม่มีรูปภาพสลิป", style: TextStyle(color: Colors.black45)),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // --- 3. การ์ดรายการอุปกรณ์ ---
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("รายการอุปกรณ์", style: TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                // รูปรถกล้อง
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    _orderData!['cameras']?['image_url'] ?? '',
                                    width: 60, height: 60, fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(width: 60, height: 60, color: Colors.grey[300], child: const Icon(Icons.camera_alt, color: Colors.black26)),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(_orderData!['cameras']?['name'] ?? "ไม่ระบุอุปกรณ์", style: const TextStyle(color: Colors.black87, fontSize: 14, fontWeight: FontWeight.w600)),
                                      const SizedBox(height: 4),
                                      Text("฿${_orderData!['total_price']}", style: const TextStyle(color: Colors.black54, fontSize: 13)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // --- ปุ่ม Action (ปฏิเสธ / อนุมัติ) ---
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _rejectOrder,
                              icon: const Icon(Icons.cancel_outlined, color: Colors.white, size: 20),
                              label: const Text("ปฏิเสธ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE53935), // แดงตรงปก
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _approveOrder,
                              icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
                              label: const Text("อนุมัติการชำระเงิน", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4CAF50), // เขียวตรงปก
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // --- ปุ่ม หมายเหตุ (เต็มกว้าง) ---
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _addRemarkOnly,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF57C00), // ส้มตรงปก
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("หมายเหตุ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
    );
  }
}