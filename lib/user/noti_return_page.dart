import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotiReturnPage extends StatelessWidget {
  final dynamic data;

  const NotiReturnPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // ดึงข้อมูลกล้อง ป้องกัน null
    final camera = data['cameras'] ?? {};
    const bg = Color(0xFF3A3A3A);

    // จัดฟอร์แมตวันที่คืน
    String returnDate = "-";
    if (data['end_date'] != null) {
      try {
        returnDate = DateFormat('dd MMM yyyy').format(DateTime.parse(data['end_date']));
      } catch (e) {
        returnDate = data['end_date'];
      }
    }

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- ช่องค้นหา (Header) ---
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

              // --- หัวข้อการแจ้งเตือน & ปุ่มย้อนกลับ ---
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

              // --- กล่องดำ (รายละเอียดการเตือนคืนของ) ---
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black, // พื้นหลังกล่องเป็นสีดำสนิท
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- ส่วนหัว: แจ้งเตือนวันคืน ---
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.info_outline_rounded, color: Colors.white, size: 28),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text("แจ้งเตือนวันคืนอุปกรณ์", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 4),
                                  Text("วันนี้เป็นวันครบกำหนดคืนอุปกรณ์เช่า", style: TextStyle(color: Colors.white54, fontSize: 12)),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 25),
                        
                        // --- การ์ดสินค้า (สามารถทำ ListView.builder ได้ถ้าเช่าหลายชิ้น) ---
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2C2828), // สีเทาเข้ม
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
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(camera['name'] ?? 'ไม่ระบุชื่อสินค้า', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 6),
                                    const Text("สี: ดำ", style: TextStyle(color: Colors.white70, fontSize: 12)),
                                    const SizedBox(height: 4),
                                    const Text("จำนวน: 1", style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        
                        // --- ข้อมูลเวลาและสถานที่ ---
                        _buildInfoRow(Icons.calendar_month_outlined, "วันครบกำหนดคืน: $returnDate"),
                        const SizedBox(height: 16),
                        _buildInfoRow(Icons.access_time_rounded, "กรุณาคืนก่อนเวลา 18:00 น."),
                        const SizedBox(height: 16),
                        _buildInfoRow(Icons.location_on_outlined, "สถานที่คืน: ร้าน Camera Rental Studio"),
                        
                        const SizedBox(height: 35),
                        
                        // --- แถบสีเหลืองเตือนค่าปรับ ---
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDCD280), // สีเหลืองตามแบบ
                            borderRadius: BorderRadius.circular(30), // ทำเป็นทรงแคปซูล
                          ),
                          child: const Text(
                            "หากคืนอุปกรณ์ล่าช้า อาจมีค่าปรับเพิ่มเติมตามเงื่อนไขการเช่า",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
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

  // ฟังก์ชันช่วยสร้างแถวข้อมูล (ไอคอน + ข้อความ)
  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text, 
            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)
          ),
        ),
      ],
    );
  }
}