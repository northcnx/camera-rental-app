import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'noti_detail_sheet.dart'; // ดึงหน้าสรุปมาใช้ตอนกดปุ่ม "รายละเอียดการเช่า"

class NotiRejectedPage extends StatefulWidget {
  final dynamic data;
  const NotiRejectedPage({super.key, required this.data});

  @override
  State<NotiRejectedPage> createState() => _NotiRejectedPageState();
}

class _NotiRejectedPageState extends State<NotiRejectedPage> {
  final supabase = Supabase.instance.client;
  final ImagePicker _picker = ImagePicker();
  
  XFile? _selectedImage;
  bool _isUploading = false;

  // ฟังก์ชันเลือกรูปภาพ
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  // ฟังก์ชันส่งสลิปใหม่
  Future<void> _submitNewSlip() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณาแนบรูปสลิปใหม่ก่อนส่ง')),
      );
      return;
    }

    setState(() => _isUploading = true);

    try {
      // 1. อัปโหลดรูปใหม่เข้า Storage (สมมติว่าโฟลเดอร์ชื่อ payment-slips)
      final bytes = await _selectedImage!.readAsBytes();
      final ext = _selectedImage!.name.split('.').last;
      final fileName = 'slip_${DateTime.now().millisecondsSinceEpoch}.$ext';
      
      await supabase.storage.from('payment-slips').uploadBinary(
        fileName, 
        bytes,
        fileOptions: const FileOptions(contentType: 'image/jpeg', upsert: true),
      );
      
      final newSlipUrl = supabase.storage.from('payment-slips').getPublicUrl(fileName);

      // 2. อัปเดตตาราง orders เปลี่ยนสถานะกลับเป็น pending ให้แอดมินตรวจใหม่
      await supabase.from('orders').update({
        'status': 'pending',
        'slip_url': newSlipUrl,
        'admin_remark': null, // ลบหมายเหตุเดิมทิ้ง
      }).eq('id', widget.data['id']);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('ส่งสลิปใหม่เรียบร้อยแล้ว รอร้านค้าตรวจสอบ'), backgroundColor: Colors.green),
        );
        Navigator.pop(context); // เด้งกลับไปหน้าการแจ้งเตือนหลัก
      }
    } catch (e) {
      debugPrint("Upload Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('เกิดข้อผิดพลาด: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFF3A3A3A);
    final data = widget.data;
    
    // ดึงหมายเหตุจากแอดมิน ถ้าไม่มีให้ใช้ข้อความ Default
    final String rejectReason = data['admin_remark'] ?? "ยอดเงินในสลิปไม่ตรงกับยอดที่ต้องชำระ หรือภาพสลิปไม่ชัดเจน";
    final String orderTime = DateFormat('dd MMM yyyy เวลา HH:mm น.').format(DateTime.parse(data['created_at']));

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
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: Colors.black54),
                    SizedBox(width: 8),
                    Expanded(child: Text("ค้นหาการแจ้งเตือน...", style: TextStyle(color: Colors.black45, fontSize: 13))),
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
                      onTap: () => Navigator.pop(context),
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

              // --- กล่องดำ (รายละเอียดการปฏิเสธสลิป) ---
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black, 
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- ส่วนหัว: แจ้งเตือนสลิปผิด ---
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.error_outline_rounded, color: Colors.white, size: 28),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("สลิปการชำระเงินไม่ถูกต้อง", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text("ร้านค้าไม่สามารถยืนยันการชำระเงินของคุณได้", style: TextStyle(color: Colors.white54, fontSize: 11)),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        
                        // --- ข้อมูลสลิปเดิม (กล่องสีเทาเข้ม) ---
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF332D2D), // สีเทาอมน้ำตาลนิดๆ ตามรูป
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Column(
                            children: [
                              _buildDetailRow(Icons.image_outlined, "สลิปที่อัปโหลด: slip_${data['id'].toString().substring(0, 6)}.png"),
                              const SizedBox(height: 16),
                              _buildDetailRow(Icons.access_time_rounded, "วันที่อัปโหลด: $orderTime"),
                              const SizedBox(height: 16),
                              _buildDetailRow(Icons.credit_card_rounded, "ยอดที่ต้องชำระ: ${data['total_price']} บาท"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // --- กล่องเหตุผล (สีแดง) ---
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE57373), // สีแดงอ่อน
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                const WidgetSpan(child: Icon(Icons.close_rounded, color: Colors.redAccent, size: 16), alignment: PlaceholderAlignment.middle),
                                const TextSpan(text: " เหตุผล: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                                TextSpan(text: rejectReason, style: const TextStyle(color: Colors.white, fontSize: 12, height: 1.4)),
                              ]
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // --- แนบสลิปใหม่ (กล่องเทาเข้ม) ---
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF332D2D),
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("แนบสลิปใหม่", style: TextStyle(color: Colors.white, fontSize: 12)),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  // ปุ่ม Choose File จำลองให้เหมือนใน UI 
                                  InkWell(
                                    onTap: _pickImage,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text("Choose File", style: TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      _selectedImage != null ? _selectedImage!.name : "No file chosen", 
                                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // --- คำแนะนำ (กล่องขาว) ---
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Text(
                            "กรุณาอัปโหลดสลิปที่ชัดเจนและยอดเงินตรงกับรายการเช่า\nหลังจากส่งแล้ว ร้านค้าจะตรวจสอบอีกครั้ง",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black87, fontSize: 11, fontWeight: FontWeight.bold, height: 1.5),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // --- ปุ่ม Action 2 ปุ่ม ---
                        Row(
                          children: [
                            // ปุ่มรายละเอียดการเช่า (สีขาว)
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // กดแล้วเปิดหน้า NotiDetailSheet ขึ้นมาทับ
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    builder: (context) => NotiDetailSheet(data: data),
                                  );
                                },
                                icon: const Icon(Icons.remove_red_eye_outlined, color: Colors.black, size: 16),
                                label: const Text("รายละเอียดการเช่า", style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // ปุ่มส่งแบบสลิปใหม่ (สีแดง)
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _isUploading ? null : _submitNewSlip,
                                icon: _isUploading 
                                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                  : const Icon(Icons.upload_file_rounded, color: Colors.white, size: 16),
                                label: Text(_isUploading ? "กำลังส่ง..." : "ส่งแบบสลิปใหม่", style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD32F2F), // สีแดงเข้ม
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(width: 12),
        Expanded(child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12))),
      ],
    );
  }
}