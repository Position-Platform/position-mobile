// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:position/src/core/utils/colors.dart';

class PositionSearchBar extends StatelessWidget {
  const PositionSearchBar({
    super.key,
    required this.openDrawer,
    required this.openSearch,
    required this.labelSearch,
    required this.openProfile,
  });

  final VoidCallback openDrawer;
  final VoidCallback openSearch;
  final VoidCallback openProfile;
  final String labelSearch;

  // Chemins d'accès constants pour les SVG
  static const String _menuIconPath = "assets/images/svg/icon-menu.svg";
  static const String _profileIconPath =
      "assets/images/svg/icon-perm_identity.svg";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surface = theme.colorScheme.surface;

    // Mise en cache des SVG pour éviter les rechargements
    final menuIcon = SvgPicture.asset(
      _menuIconPath,
      height: 20,
      width: 20,
    );

    final profileIcon = SvgPicture.asset(
      _profileIconPath,
      height: 20,
      width: 20,
    );

    return Card(
      color: surface,
      elevation: 10,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: surface,
          border: Border.all(color: surface),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          children: [
            // Menu icon button
            _buildIconButton(
              onTap: openDrawer,
              margin: const EdgeInsets.only(left: 10),
              icon: menuIcon,
            ),

            const SizedBox(width: 10),

            // Search text
            GestureDetector(
              onTap: openSearch,
              behavior: HitTestBehavior.opaque,
              child: Text(
                labelSearch,
                style: theme.textTheme.bodyMedium,
              ),
            ),

            const Spacer(),

            // Divider
            const VerticalDivider(color: grey3),

            // Profile icon button
            _buildIconButton(
              onTap: openProfile,
              margin: const EdgeInsets.only(right: 10),
              icon: profileIcon,
              width: 30,
            ),
          ],
        ),
      ),
    );
  }

  // Factorisation du code pour les boutons d'icônes
  Widget _buildIconButton({
    required VoidCallback onTap,
    required EdgeInsetsGeometry margin,
    required Widget icon,
    double height = 20,
    double width = 20,
  }) {
    return InkWell(
      highlightColor: transparent,
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: margin,
        height: height,
        width: width,
        alignment: Alignment.center,
        child: icon,
      ),
    );
  }
}
