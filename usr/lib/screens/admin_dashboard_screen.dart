import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // Mock Data for approval list
  final List<Map<String, dynamic>> _pendingApprovals = [
    {
      'id': 1,
      'user': 'สมชาย ใจดี',
      'type': 'สมัครสมาชิกใหม่',
      'date': '10 ต.ค. 2023',
      'status': 'pending',
      'avatar': 'S',
      'color': Colors.orange,
    },
    {
      'id': 2,
      'user': 'ร้านอาหารป้าไก่',
      'type': 'ลงทะเบียนร้านค้า',
      'date': '11 ต.ค. 2023',
      'status': 'pending',
      'avatar': 'R',
      'color': Colors.green,
    },
    {
      'id': 3,
      'user': 'User #8821',
      'type': 'คำขอรีเซ็ตรหัสผ่าน',
      'date': '12 ต.ค. 2023',
      'status': 'pending',
      'avatar': 'U',
      'color': Colors.blue,
    },
    {
      'id': 4,
      'user': 'เมนูต้มยำกุ้ง',
      'type': 'อนุมัติเมนูใหม่',
      'date': '12 ต.ค. 2023',
      'status': 'pending',
      'avatar': 'M',
      'color': Colors.red,
    },
  ];

  void _approveItem(int id) {
    setState(() {
      _pendingApprovals.removeWhere((item) => item['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('อนุมัติเรียบร้อยแล้ว'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _rejectItem(int id) {
    setState(() {
      _pendingApprovals.removeWhere((item) => item['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ปฏิเสธคำขอเรียบร้อยแล้ว'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color(0xFF1F2937),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF4F46E5),
              child: const Text('A'),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF1F2937),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4F46E5), Color(0xFF06B6D4)],
                ),
              ),
              accountName: Text('Admin User'),
              accountEmail: Text('admin@foodpower.ai'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('A', style: TextStyle(fontSize: 24, color: Color(0xFF4F46E5))),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard, color: Colors.white),
              title: const Text('ภาพรวม (Overview)', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.verified_user, color: Color(0xFF06B6D4)),
              title: const Text('รออนุมัติ (Approvals)', style: TextStyle(color: Color(0xFF06B6D4), fontWeight: FontWeight.bold)),
              tileColor: Colors.white.withOpacity(0.05),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.people, color: Colors.white),
              title: const Text('ผู้ใช้งาน (Users)', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('ออกจากระบบ', style: TextStyle(color: Colors.redAccent)),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'รออนุมัติ',
                    '${_pendingApprovals.length}',
                    Icons.pending_actions,
                    Colors.orange,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    'อนุมัติแล้ว',
                    '128',
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            const Text(
              'รายการรออนุมัติล่าสุด',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // List of Approvals
            Expanded(
              child: _pendingApprovals.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline, size: 64, color: Colors.grey.withOpacity(0.5)),
                          const SizedBox(height: 16),
                          const Text('ไม่มีรายการรออนุมัติ', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _pendingApprovals.length,
                      itemBuilder: (context, index) {
                        final item = _pendingApprovals[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1F2937),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            leading: CircleAvatar(
                              backgroundColor: item['color'].withOpacity(0.2),
                              child: Text(
                                item['avatar'],
                                style: TextStyle(color: item['color'], fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(
                              item['user'],
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(item['type'], style: const TextStyle(color: Colors.white70)),
                                Text(item['date'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.close, color: Colors.redAccent),
                                  onPressed: () => _rejectItem(item['id']),
                                  tooltip: 'ปฏิเสธ',
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF4F46E5), Color(0xFF06B6D4)],
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.check, color: Colors.white),
                                    onPressed: () => _approveItem(item['id']),
                                    tooltip: 'อนุมัติ',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
