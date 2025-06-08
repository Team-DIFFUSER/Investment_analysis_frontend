import 'package:flutter/material.dart';
import 'package:front_end/provider/user_provider.dart';
import 'package:provider/provider.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final bool showLogo;
  final String? title;
  final bool showUserIcon;
  final VoidCallback? onPressed;

  CustomHeader({
    super.key,
    this.showBackButton = false,
    this.showLogo = false,
    this.title,
    this.showUserIcon = false,
    this.onPressed,
  });

  final GlobalKey _avatarKey = GlobalKey();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(
      context,
      listen: true,
    );
    return Material(
      elevation: 1,
      shadowColor: Colors.grey.withAlpha((0.2 * 255).round()),
      color: Colors.white,
      child: SafeArea(
        child: Container(
          height: kToolbarHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showBackButton)
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushReplacementNamed(context, '/');
                    }
                  },
                )
              else if (showLogo)
                TextButton(
                  child: Image.asset('images/logo.png', height: 19),
                  onPressed: () {
                    Navigator.pushNamed(context, "/");
                  },
                )
              else
                const SizedBox(width: 24),

              Expanded(
                child: Center(
                  child:
                      title != null
                          ? Text(
                            title!,
                            style: const TextStyle(
                              color: Color(0xff4B5563),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                          : const SizedBox.shrink(),
                ),
              ),

              if (showUserIcon)
                GestureDetector(
                  onTap: () {
                    _showDropDownMenu(context);
                  },
                  child: CircleAvatar(
                    key: _avatarKey,
                    radius: 20,
                    backgroundColor: Color(0xffD9E8FF),
                    child: Icon(
                      Icons.person,
                      color: Color(0xff4B5563),
                      size: 25,
                    ),
                  ),
                )
              else
                const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _showDropDownMenu(BuildContext context) {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;

    final RenderBox targetBox =
        _avatarKey.currentContext!.findRenderObject() as RenderBox;
    final Offset targetPosition = targetBox.localToGlobal(
      Offset.zero,
      ancestor: overlay,
    );
    final Size targetSize = targetBox.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        targetPosition.dx,
        targetPosition.dy + targetSize.height,
        targetPosition.dx + targetSize.width,
        targetPosition.dy,
      ),
      items: [
        PopupMenuItem<String>(
          value: 'profile',
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/profile',
              ModalRoute.withName('/'),
            );
          },
          child: Row(
            children: [
              Icon(Icons.account_circle),
              SizedBox(width: 8),
              Text('Profile'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'settings',
          onTap: () {
            Future.microtask(() {
              Navigator.pushReplacementNamed(context, '/setting');
            });
          },
          child: Row(
            children: [
              Icon(Icons.settings),
              SizedBox(width: 8),
              Text('Settings'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          onTap: () async {
            Future.microtask(() {
              final userProvider = Provider.of<UserProvider>(
                context,
                listen: false,
              );
              userProvider.logout();
            });
          },
          child: Row(
            children: [
              Icon(Icons.exit_to_app),
              SizedBox(width: 8),
              Text('Logout'),
            ],
          ),
        ),
      ],
      color: Color(0xffffffff),
      elevation: 8.0,
    );
  }
}
