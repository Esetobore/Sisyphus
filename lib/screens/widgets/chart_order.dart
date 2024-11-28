import 'package:flutter/material.dart';

import 'chart_view.dart';
import 'order_book.dart';

class ChartOrder extends StatefulWidget {
  const ChartOrder({super.key});

  @override
  State<ChartOrder> createState() => _ChartOrderState();
}

class _ChartOrderState extends State<ChartOrder> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          CustomTabBar(
            selectedIndex: selectedTabIndex,
            onTabChanged: (index) {
              setState(() {
                selectedTabIndex = index;
              });
            },
          ),
          // Content based on selected tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildSelectedView(),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedView() {
    switch (selectedTabIndex) {
      case 0:
        return const ChartView();
      case 1:
        return const OrderBookScreen(
          symbol: 'btcusdt',
        );
      case 2:
        return const RecentTradesView();
      default:
        return const SizedBox.shrink();
    }
  }
}

// Custom Tab Bar Widget
class CustomTabBar extends StatelessWidget {
  final Function(int) onTabChanged;
  final int selectedIndex;

  const CustomTabBar({
    super.key,
    required this.onTabChanged,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              _buildTab(context, 'Charts', 0),
              _buildTab(context, 'Order book', 1),
              _buildTab(context, 'Recent trades', 2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTab(BuildContext context, String title, int index) {
    final isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.secondary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class RecentTradesView extends StatelessWidget {
  const RecentTradesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // Add your recent trades content here
        SizedBox(
          height: 350,
          child: Center(child: Text('Recent Trades Content')),
        ),
      ],
    );
  }
}
