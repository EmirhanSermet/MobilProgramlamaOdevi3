import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class UserData {
  String name = '';
  String surname = '';
  String gender = '';
  String university = '';
  String department = '';
  String grade = '';
  String email = '';
  String phone = '';
  String address = '';
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 238, 255),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/logo.jpg'),
            ),
            const SizedBox(width: 10),
            const Text("Emirhan ŞERMET"),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Uygulamaya Hoş Geldiniz!", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(_createRoute(Form1Page(userData: UserData())));
              },
              child: const Text("Başla"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }
}

class Form1Page extends StatefulWidget {
  final UserData userData;
  const Form1Page({super.key, required this.userData});

  @override
  State<Form1Page> createState() => _Form1PageState();
}

class _Form1PageState extends State<Form1Page> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Form 1: Kişisel Bilgiler"), backgroundColor: const Color.fromARGB(255, 0, 238, 255)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Ad")),
            TextField(controller: _surnameController, decoration: const InputDecoration(labelText: "Soyad")),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Cinsiyet"),
              items: ["Erkek", "Kadın", "Diğer"].map((gender) {
                return DropdownMenuItem(value: gender, child: Text(gender));
              }).toList(),
              onChanged: (value) => setState(() => _selectedGender = value),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.userData.name = _nameController.text;
                widget.userData.surname = _surnameController.text;
                widget.userData.gender = _selectedGender ?? '';
                Navigator.of(context).push(_createRoute(Form2Page(userData: widget.userData)));
              },
              child: const Text("İleri"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }
}

class Form2Page extends StatelessWidget {
  final UserData userData;
  const Form2Page({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final _uniController = TextEditingController();
    final _depController = TextEditingController();
    final _classController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Form 2: Eğitim Bilgileri"), backgroundColor: const Color.fromARGB(255, 0, 238, 255)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _uniController, decoration: const InputDecoration(labelText: "Üniversite Adı")),
            TextField(controller: _depController, decoration: const InputDecoration(labelText: "Bölüm")),
            TextField(controller: _classController, decoration: const InputDecoration(labelText: "Sınıf")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                userData.university = _uniController.text;
                userData.department = _depController.text;
                userData.grade = _classController.text;
                Navigator.of(context).push(_createRoute(Form3Page(userData: userData)));
              },
              child: const Text("İleri"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }
}

class Form3Page extends StatelessWidget {
  final UserData userData;
  const Form3Page({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _phoneController = TextEditingController();
    final _addressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Form 3: İletişim Bilgileri"), backgroundColor: const Color.fromARGB(255, 0, 238, 255)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: const InputDecoration(labelText: "E-posta")),
            TextField(controller: _phoneController, decoration: const InputDecoration(labelText: "Telefon Numarası")),
            TextField(controller: _addressController, decoration: const InputDecoration(labelText: "Ev Adresi")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                userData.email = _emailController.text;
                userData.phone = _phoneController.text;
                userData.address = _addressController.text;
                Navigator.of(context).push(_createRoute(ResultPage(userData: userData)));
              },
              child: const Text("Gönder"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }
}

class ResultPage extends StatelessWidget {
  final UserData userData;
  const ResultPage({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Toplu Bilgiler"), backgroundColor: const Color.fromARGB(255, 0, 238, 255)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard("Ad Soyad", "${userData.name} ${userData.surname}"),
          _buildCard("Cinsiyet", userData.gender),
          _buildCard("Üniversite", userData.university),
          _buildCard("Bölüm", userData.department),
          _buildCard("Sınıf", userData.grade),
          _buildCard("E-posta", userData.email),
          _buildCard("Telefon", userData.phone),
          _buildCard("Adres", userData.address),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String content) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(content),
      ),
    );
  }
}

Widget _buildBottomNav(BuildContext context) {
  return BottomAppBar(
    color: const Color.fromARGB(255, 0, 238, 255),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(icon: const Icon(Icons.person), onPressed: () {}),
        IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else {
              exit(0);
            }
          },
        ),
      ],
    ),
  );
}

Route _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
