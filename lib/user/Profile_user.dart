import 'package:flutter/material.dart';
import 'package:project_app/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../login.dart'; // แก้ไข Import ให้ถูกต้องแล้ว

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  final _supabase = Supabase.instance.client;
  bool _isLoading = true;

  // ตัวแปรข้อมูล
  String _username = '';
  String _email = '';
  String _phone = '';
  String _description = '';
  String? _avatarUrl;

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  Future<void> _getProfile() async {
    try {
      final userId = _supabase.auth.currentUser!.id;
      final data = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      if (mounted) {
        setState(() {
          _username = data['username'] ?? 'No Name';
          _email = data['email'] ?? '';
          _phone = data['phone'] ?? '-';
          _description = data['description'] ?? '-';
          _avatarUrl = data['avatar_url'];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _editProfileDialog() async {
    final nameCtrl = TextEditingController(text: _username);
    final phoneCtrl = TextEditingController(text: _phone);
    final descCtrl = TextEditingController(text: _description);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('แก้ไขข้อมูล'),
        content: SingleChildScrollView(
          // เพิ่ม Scroll เผื่อคีย์บอร์ดบัง
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'ชื่อ'),
              ),
              TextField(
                controller: phoneCtrl,
                decoration: const InputDecoration(labelText: 'เบอร์'),
              ),
              TextField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: 'คำอธิบาย'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ยกเลิก'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await _supabase
                    .from('profiles')
                    .update({
                      'username': nameCtrl.text,
                      'phone': phoneCtrl.text,
                      'description': descCtrl.text,
                    })
                    .eq('id', _supabase.auth.currentUser!.id);

                setState(() {
                  _username = nameCtrl.text;
                  _phone = phoneCtrl.text;
                  _description = descCtrl.text;
                });
                if (mounted) Navigator.pop(context);
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Update Error: $e')));
                }
              }
            },
            child: const Text('บันทึก'),
          ),
        ],
      ),
    );
  }

  // --- ฟังก์ชัน Logout ---
  Future<void> _signOut() async {
    try {
      await _supabase.auth.signOut();
      if (mounted) {
        // เด้งไปหน้า Login และล้างหน้าเก่าทิ้ง
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(), // เรียกใช้ Class จาก login.dart
          ),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error logging out: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3A3A3A),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        // Card สีขาวด้านหลัง
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                          padding: const EdgeInsets.fromLTRB(20, 70, 20, 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Text(
                                _username,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // แสดงข้อมูลแบบจัดกึ่งกลาง
                              const Text(
                                "อีเมล",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(_email),
                              const SizedBox(height: 5),
                              const Text(
                                "เบอร์",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(_phone),
                              const SizedBox(height: 5),
                              const Text(
                                "คำอธิบาย",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(_description, textAlign: TextAlign.center),
                              const SizedBox(height: 20),

                              // ปุ่ม Action
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: _editProfileDialog,
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      label: const Text(
                                        "แก้ไขโปรไฟล์",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFFC69C3A,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: ElevatedButton.icon(
                                      onPressed: _signOut,
                                      icon: const Icon(
                                        Icons.logout,
                                        color: Colors.white,
                                      ),
                                      label: const Text(
                                        "ออกจากระบบ",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(
                                          0xFFFF5E5E,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // รูป Profile วงกลมด้านบน
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: _avatarUrl != null
                              ? NetworkImage(_avatarUrl!)
                              : null,
                          child: _avatarUrl == null
                              ? const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
