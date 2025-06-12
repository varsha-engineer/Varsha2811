import 'package:flutter/material.dart';


class FloatingNavBar extends StatefulWidget {
  FloatingNavBar({super.key, this.tabs});
  List<Widget>? tabs = [];

  @override
  State<FloatingNavBar> createState() => _FloatingNavBarState();
}

class _FloatingNavBarState extends State<FloatingNavBar> {
  int _selectedIndex = 0;

  final List<IconData> icons = [
    Icons.home,
    Icons.grid_view,
    Icons.shopping_cart,
    Icons.person,
  ];

  final List<String> labels = [
    'Home',
    'Categories',
    'Cart',
    'Profile',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      body: widget.tabs![_selectedIndex],
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomPaint(
            size: Size(width, 80),
            painter: NavBarPainter(),
          ),
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(icons.length, (index) {
                return index == _selectedIndex
                    ? const SizedBox(width: 70) // leave space for floating icon
                    : _buildNavItem(index);
              }),
            ),
          ),
          // Floating selected icon
          Positioned(
            top: -25,
            left: width / 4 * _selectedIndex + width / 8 - 30,
            child: Column(
              children: [
                Material(
                    elevation: 4,
                    shape: const CircleBorder(),
                    color: Colors.green,
                    child: InkWell(
                      onTap: () => _onItemTapped(_selectedIndex),
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Icon(
                          icons[_selectedIndex],
                          color: Colors.white,
                        ),
                      ),
                    )),
                const SizedBox(height: 5),
                Text(
                  labels[_selectedIndex],
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNavItem(int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icons[index],
            color: Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            labels[index],
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = Colors.white;

    final Path path = Path()
      ..moveTo(0, 20)
      ..quadraticBezierTo(size.width * 0.2, 0, size.width * 0.5, 0)
      ..quadraticBezierTo(size.width * 0.8, 0, size.width, 20)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(NavBarPainter oldDelegate) => false;
}
