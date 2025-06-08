import 'package:flutter/material.dart';
import 'package:front_end/widgets/custom_button.dart';
import 'package:front_end/widgets/custom_header.dart';

class LoadDataScreen extends StatefulWidget {
  const LoadDataScreen({super.key});

  @override
  State<LoadDataScreen> createState() => _LoadDataScreenState();
}

class _LoadDataScreenState extends State<LoadDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(
        showLogo: false,
        showUserIcon: false,
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "인증이 완료되었으면\n확인 버튼을 눌러주세요",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "확인",
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
