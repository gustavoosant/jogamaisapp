import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFF182B5C),
      shape: const CircularNotchedRectangle(),
      notchMargin: 4,
      child: SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color:
                    currentIndex == 0 ? const Color(0xFF151B34) : Colors.white,
              ),
              onPressed: () => onTap(0),
            ),
            IconButton(
              icon: Icon(
                Icons.calendar_month_outlined,
                color:
                    currentIndex == 1 ? const Color(0xFF151B34) : Colors.white,
              ),
              onPressed: () => onTap(1),
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: Icon(
                Icons.chat_outlined,
                color:
                    currentIndex == 2 ? const Color(0xFF151B34) : Colors.white,
              ),
              onPressed: () => onTap(2),
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color:
                    currentIndex == 3 ? const Color(0xFF151B34) : Colors.white,
              ),
              onPressed: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}
