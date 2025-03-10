// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:position/src/core/utils/colors.dart';

class PositionSearchBar extends StatefulWidget {
  const PositionSearchBar(
      {super.key,
      required this.openDrawer,
      required this.openSearch,
      required this.labelSearch,
      required this.openProfile});
  final VoidCallback openDrawer;
  final VoidCallback openSearch;
  final VoidCallback openProfile;
  final String labelSearch;

  @override
  State<PositionSearchBar> createState() => _PositionSearchBarState();
}

class _PositionSearchBarState extends State<PositionSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surface,
      elevation: 10,
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(20.0), // Ajustez le rayon selon vos besoins
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            border: Border.all(
              color: Theme.of(context).colorScheme.surface,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        height: 45,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            InkWell(
              highlightColor: transparent,
              onTap: widget.openDrawer,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                height: 20,
                width: 20,
                child: SvgPicture.asset("assets/images/svg/icon-menu.svg"),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              highlightColor: transparent,
              onTap: widget.openSearch,
              child: Text(widget.labelSearch,
                  style: Theme.of(context).textTheme.bodyMedium!),
            ),
            const Spacer(),
            const VerticalDivider(
              color: grey3,
            ),
            InkWell(
              highlightColor: transparent,
              onTap: widget.openProfile,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 10),
                height: 20,
                width: 30,
                child: SvgPicture.asset(
                    "assets/images/svg/icon-perm_identity.svg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
