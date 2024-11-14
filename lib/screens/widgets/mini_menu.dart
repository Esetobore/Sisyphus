import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final List<MenuItem> menuItems = [
    MenuItem(title: 'Exchange', onTap: () {}),
    MenuItem(title: 'Wallets', onTap: () {}),
    MenuItem(title: 'Roqqu Hub', onTap: () {}),
    MenuItem(title: 'Log out', onTap: () {}, isLogout: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: menuItems.length,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: Color(0xFF2A2A2A),
            ),
            itemBuilder: (context, index) {
              final item = menuItems[index];
              return _buildMenuItem(item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    return InkWell(
      onTap: item.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Text(
          item.title,
          style: TextStyle(
            color: item.isLogout ? Colors.red : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class MenuItem {
  final String title;
  final VoidCallback onTap;
  final bool isLogout;

  MenuItem({
    required this.title,
    required this.onTap,
    this.isLogout = false,
  });
}
