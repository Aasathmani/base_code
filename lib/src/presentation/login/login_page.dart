import 'package:app_task/src/application/login/login_bloc.dart';
import 'package:app_task/src/application/login/login_event.dart';
import 'package:app_task/src/application/login/login_state.dart';
import 'package:app_task/src/core/app_constants.dart';
import 'package:app_task/src/presentation/core/app_page.dart';
import 'package:app_task/src/presentation/core/base_state.dart';
import 'package:app_task/src/presentation/core/theme/colors.dart';
import 'package:app_task/src/presentation/home/home_page.dart';
import 'package:app_task/src/presentation/register/register_page.dart';
import 'package:app_task/src/presentation/widgets/app_button.dart';
import 'package:app_task/src/presentation/widgets/bordered_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  static const route = "/loginPage";
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage> {
  LoginBloc? _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<LoginBloc>(context);
    _bloc!.message.listen((value) => showMessage(value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loginSuccess == true) {
          Navigator.pushNamed(context, HomePage.route);
        }
      },
      builder: (context, state) {
        return AppPage(
          title: "",
          isBackButtonRequired: false,
          retryOnTap: () {},
          processStateStream: _bloc!.stream.map((state) => state.processState),
          child: _getBodyLayout(context),
        );
      },
    );
  }

  Widget _getBodyLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Center(
              child: SvgPicture.asset(
                AppIcons.kLogoSvg,
                height: 80,
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                "Sign in to continue",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.grey,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text("Email"),
            const SizedBox(
              height: 10,
            ),
            BorderedTextField(
              key: const Key("email"),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(Icons.email_rounded, color: AppColors.black),
              ),
              backgroundColor: AppColors.white,
              labelText: 'Email',
              textColor: AppColors.black,
              onTextChanged: (text) {
                _bloc!.add(EmailChanged(text));
              },
            ),
            const SizedBox(height: 16),
            const Text("Password"),
            const SizedBox(
              height: 10,
            ),
            BorderedTextField(
              key: const Key("password"),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(Icons.lock, color: AppColors.black),
              ),
              backgroundColor: AppColors.white,
              labelText: 'Password',
              onTextChanged: (text) {
                _bloc!.add(PasswordChange(text));
              },
            ),
            const SizedBox(height: 60),
            AppButton(
              onTap: () {
                Navigator.pushNamed(context, HomePage.route);
                //_bloc!.add(LoginButtonTapped());
              },
              label: "Login".toUpperCase(),
              color: AppColors.ashBlue,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(fontSize: 14),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterPage.route);
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
