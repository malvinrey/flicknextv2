import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Background color for the footer
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800), // Center content with a maximum width
          child: Column(
            mainAxisSize: MainAxisSize.min, // Minimize height to fit content
            children: [
              SizedBox(height: 10), // Padding above "Follow FlickNext on social"
              Text(
                "Follow FlickNext on social",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14, // Font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5), // Spacing between title and icons
              // Social Media Icons Section
              Wrap(
                alignment: WrapAlignment.center, // Center-align icons
                spacing: 16, // Horizontal spacing between icons
                runSpacing: 10, // Vertical spacing between rows (if wrapping happens)
                children: [
                  _buildSocialIcon(FontAwesomeIcons.facebook),
                  _buildSocialIcon(FontAwesomeIcons.twitter),
                  _buildSocialIcon(FontAwesomeIcons.instagram),
                  _buildSocialIcon(FontAwesomeIcons.youtube),
                  _buildSocialIcon(FontAwesomeIcons.tiktok),
                ],
              ),
              SizedBox(height: 5), // Spacing between icons and links

              // Links Section with Padding
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20), // Horizontal padding for links
                child: Wrap(
                  alignment: WrapAlignment.center, // Center-align links
                  spacing: 20, // Spacing between links
                  children: [
                    _buildFooterLink("Help"),
                    _buildFooterLink("Contact"),
                    _buildFooterLink("Privacy Policy"),
                    _buildFooterLink("Terms of Use"),
                  ],
                ),
              ),
              SizedBox(height: 8), // Reduced spacing between links and copyright

              // Copyright Section
              Text(
                "© 2024 FlickNext, Inc.",
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12, // Font size
                ),
              ),
              SizedBox(height: 15), // Final bottom padding
            ],
          ),
        ),
      ),
    );
  }

  // Function to build social media icons
  Widget _buildSocialIcon(IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          print("Icon tapped"); // Handle icon click
        },
        child: Container(
          padding: EdgeInsets.all(8), // Padding around each icon
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.1), // Light background for icons
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20, // Consistent icon size
          ),
        ),
      ),
    );
  }

  // Function to create footer links
  Widget _buildFooterLink(String text) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white, // White color by default
          decoration: TextDecoration.none, // No underline by default
        ),
      ),
    );
  }
}
