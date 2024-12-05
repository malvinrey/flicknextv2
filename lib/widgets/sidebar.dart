import 'package:flutter/material.dart';

class SideBarAnimated extends StatefulWidget {
  final Function(int) onTap;
  final double widthSwitch;
  final String mainLogoImage;
  final List<SideBarItem> sidebarItems;

  const SideBarAnimated({
    Key? key,
    required this.onTap,
    required this.widthSwitch,
    required this.mainLogoImage,
    required this.sidebarItems,
  }) : super(key: key);

  @override
  SideBarAnimatedState createState() => SideBarAnimatedState();
}

class SideBarAnimatedState extends State<SideBarAnimated> {
  bool _isVisible = false;

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _isVisible ? 250 : 0,
      color: Colors.grey,
      child: Column(
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/logo.png', height: 100),
          ),
          // Divider
          Divider(color: Colors.white70),
          // Sidebar Items
          Expanded(
            child: ListView.builder(
              itemCount: widget.sidebarItems.length,
              itemBuilder: (context, index) {
                final item = widget.sidebarItems[index];
                return ListTile(
                  leading: Icon(
                    index == item.selectedIndex ? item.iconSelected : item.iconUnselected,
                    color: Colors.white,
                  ),
                  title: Text(
                    item.text,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    widget.onTap(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SideBarItem {
  final IconData iconSelected;
  final IconData iconUnselected;
  final String text;
  final int selectedIndex;

  SideBarItem({
    required this.iconSelected,
    required this.iconUnselected,
    required this.text,
    this.selectedIndex = 0,
  });
}