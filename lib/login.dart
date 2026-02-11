import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'register.dart';
import 'home_admin.dart';
import 'home_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final supabase = Supabase.instance.client;

  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  Future<void> login() async {
    try {
      // 1️⃣ หา email + role จาก username (ยังไม่ login)
      final profile = await supabase
          .from('profiles')
          .select('email, role')
          .eq('username', usernameCtrl.text.trim())
          .single();

      // 2️⃣ login ด้วย email
      final auth = await supabase.auth.signInWithPassword(
        email: profile['email'],
        password: passwordCtrl.text.trim(),
      );

      if (auth.user == null) throw 'login failed';

      final role = profile['role'];

      if (!mounted) return;

      // 3️⃣ แยกสิทธิ
      if (role == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminHome()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const UserHome()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username หรือ Password ไม่ถูกต้อง')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: usernameCtrl,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordCtrl,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text('Login')),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RegisterPage()),
              ),
              child: const Text('สมัครสมาชิก'),
            ),
          ],
        ),
      ),
    );
  }
}
