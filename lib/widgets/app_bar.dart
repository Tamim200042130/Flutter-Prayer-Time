import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final bool? isBackButtonEnabled;
  final Widget? backButtonNavigationTo;

  const MyAppBar({
    super.key,
    this.title,
    this.isBackButtonEnabled = true,
    this.backButtonNavigationTo,
  });

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(45);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 45,
      titleSpacing: 0,
      elevation: 0,
      backgroundColor: ColorConstants.primary,
      automaticallyImplyLeading: false,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.isBackButtonEnabled == true)
            Row(
              children: [
                InkWell(
                  onTap: () {
                    if (widget.backButtonNavigationTo == null) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                widget.backButtonNavigationTo!),
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
          Expanded(
            child: widget.title != null
                ? Text(
                    widget.title!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
                : const Text(
                    "Mosque Finder",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
