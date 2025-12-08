import 'package:flutter/material.dart';
import '../../../../views/page/colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/social_login_sheet.dart';
import 'register_page.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    void showSocialLogin() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const SocialLoginSheet(),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 5),
                  Column(children: const [Icon(Icons.diamond_outlined, size: 80, color: Colors.white), SizedBox(height: 10), Text('Finegram', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.white, letterSpacing: 2.0))]),
                  const Spacer(flex: 1),
                  const CustomTextField(hintText: "Phone or Email or Username", icon: Icons.email_outlined),
                  const CustomTextField(hintText: "Password", icon: Icons.lock_outline, isPassword: true),
                  const SizedBox(height: 10),
                  
                  PrimaryButton(
                    text: "Login",
                    onPressed: () {
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                    },
                  ),

                  const SizedBox(height: 20),
                  Row(children: [const Expanded(child: Divider(color: Colors.white24)), Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Text("Or login with", style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14))), const Expanded(child: Divider(color: Colors.white24))]),
                  const SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [_socialIconTrigger(Icons.g_mobiledata, Colors.red, showSocialLogin), const SizedBox(width: 20), _socialIconTrigger(Icons.apple, Colors.black, showSocialLogin), const SizedBox(width: 20), _socialIconTrigger(Icons.facebook, Colors.blue, showSocialLogin)]),
                  const Spacer(flex: 3),
                  GestureDetector(onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));}, child: RichText(text: const TextSpan(text: "Don't have an account? ", style: TextStyle(color: Colors.white60), children: [TextSpan(text: "Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]))),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialIconTrigger(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0,5))]), child: Icon(icon, color: color, size: 30)));
  }
}