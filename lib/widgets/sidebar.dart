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
  bool _isVisible = true; // Sidebar is visible by default  
  int _selectedIndex = 0; // Track the selected index for sidebar items  

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
      left: _isVisible ? 0 : -sidebarWidth,  
      top: 0,  
      bottom: 0,  
      child: AnimatedContainer(  
        duration: const Duration(milliseconds: 300),  
        width: sidebarWidth,  
        color: Colors.blueGrey.withOpacity(0.8), // Sidebar background color  
        child: Column(  
          mainAxisSize: MainAxisSize.max,  
          children: [  
            // Logo Section (centered in the sidebar)  
            Center(  
              child: Image.asset(  
                widget.mainLogoImage,  
                height: 40, // Reduced logo size  
                width: 40,  
              ),  
            ),  
            const Divider(color: Colors.white70),  
            Expanded(  
              child: ListView.builder(  
                itemCount: widget.sidebarItems.length,  
                itemBuilder: (context, index) {  
                  final item = widget.sidebarItems[index];  
                  return GestureDetector(  
                    onTap: () {  
                      setState(() {  
                        _selectedIndex = index; // Update the selected index dynamically  
                      });  
                      widget.onTap(index); // Notify parent widget  
                    },  
                    child: Container(  
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16), // Padding for touch area  
                      child: Row(  
                        children: [  
                          Icon(  
                            _selectedIndex == index  
                                ? item.iconSelected  
                                : item.iconUnselected,  
                            color: Colors.white,  
                            size: 30,  
                          ),  
                          const SizedBox(width: 16), // Space between icon and text  
                          // Removed Text  
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
}  

class SideBarItem {  
  final IconData iconSelected;  
  final IconData iconUnselected;  

  SideBarItem({  
    required this.iconSelected,  
    required this.iconUnselected,  
  });  
}