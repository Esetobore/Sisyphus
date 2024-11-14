import 'package:flutter/material.dart';
import 'package:roqquassessment/constants/colors.dart';

class BottomButtons extends StatefulWidget {
  const BottomButtons({super.key});

  @override
  State<BottomButtons> createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  String selectedOrderType = 'Limit'; // Default selected type
  bool? isChecked = false;
  void _showHalfScreenModal(BuildContext context, String action) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.primary,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        maxChildSize: 0.75,
        minChildSize: 0.6,
        builder: (context, scrollController) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 315,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 60),
                                decoration: BoxDecoration(
                                  color: action == "Buy"
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: action == "Buy"
                                      ? Border.all(color: AppColors.kOrange)
                                      : Border.all(color: Colors.transparent),
                                ),
                                child: const Text(
                                  "Buy",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 60),
                                decoration: BoxDecoration(
                                  color: action == "Sell"
                                      ? Theme.of(context).colorScheme.secondary
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: action == "Sell"
                                      ? Border.all(color: AppColors.kOrange)
                                      : Border.all(color: Colors.transparent),
                                ),
                                child: const Text(
                                  "Sell",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: selectedOrderType == 'Limit'
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedOrderType = 'Limit';
                                });
                              },
                              child: Text(
                                "Limit",
                                style: TextStyle(
                                  color: selectedOrderType == 'Limit'
                                      ? AppColors.lightPrimaryColor
                                      : AppColors.kGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: selectedOrderType == 'Market'
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedOrderType = 'Market';
                                });
                              },
                              child: Text(
                                "Market",
                                style: TextStyle(
                                  color: selectedOrderType == 'Market'
                                      ? AppColors.lightPrimaryColor
                                      : AppColors.kGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: selectedOrderType == 'Stop Limit'
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  selectedOrderType = 'Stop Limit';
                                });
                              },
                              child: Text(
                                "Stop Limit",
                                style: TextStyle(
                                  color: selectedOrderType == 'Stop Limit'
                                      ? AppColors.lightPrimaryColor
                                      : AppColors.kGrey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          labelText: selectedOrderType == 'Market'
                              ? "Market Price"
                              : "$selectedOrderType price",
                          labelStyle: const TextStyle(
                            color: AppColors.kGrey,
                            fontSize: 16,
                          ),
                          suffixText: "USD",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.kGrey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.kGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.kGrey),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      // Amount TextField
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Amount",
                          labelStyle: const TextStyle(
                            color: AppColors.kGrey,
                          ),
                          suffixText: "USD",
                          suffixStyle: const TextStyle(
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.kGrey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.kGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.kGrey),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        items: ["Good till cancelled", "Immediate or cancel"]
                            .map((String value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 16,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          labelText: "Type",
                          labelStyle: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.kGrey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.kGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: AppColors.kGrey),
                          ),
                          // Add the info icon
                        ),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.kGrey,
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                              value: isChecked,
                              activeColor: AppColors.kOrange,
                              onChanged: (activeBool) {
                                setState(() {
                                  isChecked = activeBool;
                                });
                              }),
                          const Text("Post Only"),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        //TODO: Make Gradient
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          backgroundColor:
                              action == "Buy" ? Colors.green : Colors.red,
                        ),
                        child: Text("$action BTC"),
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total account value"),
                          Text("0.00 NGN"),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Open Orders"),
                          Text("0.00"),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Available"),
                          Text("0.00"),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.kBlue,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Deposit"),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => _showHalfScreenModal(context, "Buy"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Buy',
                style: TextStyle(color: AppColors.lightPrimaryColor),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () => _showHalfScreenModal(context, "Sell"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Sell',
                style: TextStyle(color: AppColors.lightPrimaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
