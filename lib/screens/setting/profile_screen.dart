import 'package:flutter/material.dart';
import 'package:front_end/provider/user_provider.dart';
import 'package:front_end/screens/setting/menu.dart';
import 'package:front_end/screens/survey/result_screen.dart';
import 'package:front_end/widgets/custom_bottom_navigation_bar.dart';
import 'package:front_end/widgets/custom_button.dart';
import 'package:front_end/widgets/custom_header.dart';
import 'package:front_end/widgets/custom_menu_list.dart';
import 'package:provider/provider.dart';
import 'package:front_end/userInfo/users.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.userInfo;
    final menuItems = [
      MenuItem(
        title: '테스트 다시하기',
        icon: Icons.refresh,
        onTap: () {
          Navigator.pushNamed(context, '/survey');
        },
      ),
      MenuItem(
        title: '회원정보 수정',
        icon: Icons.edit,
        onTap: () {
          Navigator.pushNamed(context, '/edit_profile');
        },
      ),
    ];
    return Scaffold(
      appBar: CustomHeader(
        showLogo: false,
        showUserIcon: false,
        showBackButton: true,
        title: "회원정보",
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 450),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user?.name ?? '없음',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  user?.email ?? '없음',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),
                CustomMenuList(menuItems: menuItems),

                const SizedBox(height: 48),
                CustomButton(
                  text: '로그아웃',
                  isFullWidth: true,
                  backgroundColor: Color(0xffd9e8ff),
                  color: Color(0xff1e90ff),
                  onPressed: () async {
                    userProvider.logout();
                    Navigator.pushReplacementNamed(context, '/');
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: '회원탈퇴',
                  isFullWidth: true,
                  backgroundColor: const Color(0xffffffff),
                  color: const Color(0xffff6b6b),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 3),
    );
  }
}
