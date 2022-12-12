import 'package:flutter/material.dart';
import 'package:yabalash_mobile_app/features/auth/presentation/widgets/account_problem_bottom_bar.dart';

import '../widgets/login_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: LoginBody()),
      bottomNavigationBar: AccountProblemBottomBar(),
    );
  }
}
