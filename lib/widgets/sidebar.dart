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
  bool _isVisible = true; // Sidebar is visible by default for testing

  // Toggle visibility - not needed for testing but kept for later functionality
  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double sidebarWidth = screenWidth * widget.widthSwitch; // Sidebar width

    return Positioned(
      left: _isVisible ? 0 : -sidebarWidth,  // Sidebar is visible by default
      top: 0,
      bottom: 0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: sidebarWidth,
        color: Colors.blueGrey.withOpacity(0.8), // Sidebar background color
        child: Column(
          children: [
            // Logo Section (centered in the sidebar)
            Center(
              child: Image.asset(
                widget.mainLogoImage,
                height: 100,
                width: 100,
              ),
            ),
            const Divider(color: Colors.white70),

            // Sidebar Items (Only icons centered)
            Expanded(
              child: ListView.builder(
                itemCount: widget.sidebarItems.length,
                itemBuilder: (context, index) {
                  final item = widget.sidebarItems[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10), // Adjust space between items
                    leading: Container(
                      width: double.infinity,  // Take up full width
                      alignment: Alignment.center,  // Center the icon horizontally
                      child: Icon(
                        index == item.selectedIndex
                            ? item.iconSelected
                            : item.iconUnselected,
                        color: Colors.white,
                        size: 30, // Icon size adjusted for better visibility
                      ),
                    ),
                    onTap: () {
                      widget.onTap(index);  // Notify parent widget
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SideBarItem {
  final IconData iconSelected;
  final IconData iconUnselected;
  final int selectedIndex;

  SideBarItem({
    required this.iconSelected,
    required this.iconUnselected,
    this.selectedIndex = 0,  // Default value for selected index
  });
}
