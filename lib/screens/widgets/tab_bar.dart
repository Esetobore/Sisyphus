// custom_tab_bar.dart
import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final Function(int) onTabChanged; // Callback for tab changes
  final int selectedIndex; // Current selected index

  const CustomTabBar({
    super.key,
    required this.onTabChanged,
    required this.selectedIndex,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildTab('Charts', 0),
          _buildTab('Orderbook', 1),
          _buildTab('Recent trades', 2),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    return GestureDetector(
      onTap: () => widget.onTabChanged(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: widget.selectedIndex == index
                  ? Colors.green
                  : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
        ),
      ),
    );
  }
}
