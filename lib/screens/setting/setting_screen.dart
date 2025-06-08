import 'package:flutter/material.dart';
import 'package:front_end/provider/user_provider.dart';
import 'package:front_end/screens/setting/menu.dart';
import 'package:front_end/screens/survey/result_screen.dart';
import 'package:front_end/widgets/custom_bottom_navigation_bar.dart';
import 'package:front_end/widgets/custom_button.dart';
import 'package:front_end/widgets/custom_header.dart';
import 'package:front_end/widgets/custom_menu_list.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(
      context,
      listen: true,
    );
    final user = userProvider.userInfo;

    final menuItems = [
      MenuItem(
        title: '테스트 결과보기',
        icon: Icons.note_outlined,
        onTap: () {
          final investInfo = userProvider.investInfo;
          if (investInfo != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ResultScreen(result: investInfo),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("설문 결과가 없습니다. 먼저 설문을 진행해주세요.")),
            );
          }
        },
      ),
      MenuItem(
        title: '테스트 다시하기',
        icon: Icons.refresh,
        onTap: () {
          Navigator.pushNamed(context, '/survey');
        },
      ),
      MenuItem(
        title: '마이데이터 불러오기',
        icon: Icons.arrow_downward,
        onTap: () {
          Navigator.pushNamed(context, '/mydata');
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
        showLogo: true,
        showUserIcon: false,
        showBackButton: false,
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
                const SizedBox(height: 40),
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
                const SizedBox(height: 16),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 3),
    );
  }
}
