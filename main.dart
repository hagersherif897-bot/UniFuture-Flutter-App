import 'package:flutter/material.dart';

void main() {
  runApp(const UniFutureApp());
}

class UniFutureApp extends StatelessWidget {
  const UniFutureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniFuture',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // قائمة مهام افتراضية كـ To-Do List للـ IT Graduate
  final List<Map<String, dynamic>> _tasks = [
    {'title': 'مراجعة أساسيات لغة Dart', 'isDone': true},
    {'title': 'بناء أول واجهة تطبيق بـ Flutter', 'isDone': false},
    {'title': 'إنشاء حساب احترافي على GitHub', 'isDone': false},
    {'title': 'الدعاء بالتوفيق والنجاح دائماً', 'isDone': true},
  ];

  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add({'title': _taskController.text, 'isDone': false});
        _taskController.clear();
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بوابتك للمستقبل 🚀', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // كارت الترحيب والتحفيز
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.indigo, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('مرحباً بكِ يا مهندسة! 👋', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('النجاح خطوة تبدأ بيقين ودعاء، ثم عمل مستمر وتطوير مستمر للمهارات.', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // قسم مسارات الـ IT
              const Text('مسارات تكنولوجية مقترحة 💻', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
              const SizedBox(height: 12),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildTrackCard('Mobile Dev (Flutter)', Icons.phone_android, Colors.orange),
                    _buildTrackCard('Web Dev (Fullstack)', Icons.web, Colors.green),
                    _buildTrackCard('Software Testing', Icons.bug_report, Colors.red),
                    _buildTrackCard('Data Analysis', Icons.bar_chart, Colors.purple),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // قسم قائمة المهام اليومية
              Row(
                mainAxisAlignment: MainAxisAlignment.between,
                children: [
                  const Text('أهدافي لفترة الانتظار 🎯', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.indigo, size: 28),
                    onPressed: _showAddTaskDialog,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // عرض المهام
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Checkbox(
                        activeColor: Colors.indigo,
                        value: _tasks[index]['isDone'],
                        onChanged: (value) {
                          setState(() {
                            _tasks[index]['isDone'] = value;
                          });
                        },
                      ),
                      title: Text(
                        _tasks[index]['title'],
                        style: TextStyle(
                          decoration: _tasks[index]['isDone'] ? TextDecoration.lineThrough : null,
                          color: _tasks[index]['isDone'] ? Colors.grey : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackCard(String title, IconData icon, Color color) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(13), blurRadius: 6, offset: const Offset(0, 3))],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: color),
          const SizedBox(height: 10),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة هدف جديد'),
        content: TextField(
          controller: _taskController,
          decoration: const InputDecoration(hintText: 'اكتبي المهمة هنا...'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(onPressed: _addTask, child: const Text('إضافة')),
        ],
      ),
    );
  }
}
