import 'package:flutter/material.dart';
import 'package:front_end/screens/setting/menu.dart';

class CustomMenuList extends StatelessWidget {
  final List<MenuItem> menuItems;

  const CustomMenuList({super.key, required this.menuItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: List.generate(menuItems.length, (index) {
          final item = menuItems[index];
          bool isLastItem = index == menuItems.length - 1;

          return Column(
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: item.onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(item.icon, color: item.iconColor ?? Colors.grey),
                        const SizedBox(width: 16),
                        Text(item.title, style: const TextStyle(fontSize: 16)),
                        const Spacer(),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (!isLastItem)
                const Divider(
                  color: Color(0xffE5E7EB),
                  thickness: 1.5,
                  indent: 16,
                  endIndent: 16,
                  height: 0,
                ),
            ],
          );
        }),
      ),
    );
  }
}
