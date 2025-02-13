import 'package:app_task/src/application/form/form_state.dart';
import 'package:app_task/src/application/register/register_bloc.dart';
import 'package:app_task/src/application/register/register_event.dart';
import 'package:app_task/src/application/register/register_state.dart';
import 'package:app_task/src/core/app_constants.dart';
import 'package:app_task/src/presentation/core/app_page.dart';
import 'package:app_task/src/presentation/core/base_state.dart';
import 'package:app_task/src/presentation/core/theme/colors.dart';
import 'package:app_task/src/presentation/core/theme/text_styles.dart';
import 'package:app_task/src/presentation/home/home_page.dart';
import 'package:app_task/src/presentation/widgets/app_button.dart';
import 'package:app_task/src/presentation/widgets/bordered_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  static const route = "/registerPage";
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage> {
  RegisterBloc? bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<RegisterBloc>(context);
    bloc!.message.listen((value) => showMessage(value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.registerSuccess == true) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomePage.route,
            (Route<dynamic> route) => false,
          );
        }
      },
      builder: (context, state) {
        return AppPage(
          title: "",
          retryOnTap: () {},
          processStateStream: bloc!.stream.map((state) => state.processState),
          child: _getBodyLayout(context, state),
        );
      },
    );
  }

  Widget _getBodyLayout(BuildContext context, RegisterState state) {
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
                "Create your account",
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
                "Sign up to continue",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.grey,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Full name'),
            const SizedBox(
              height: 10,
            ),
            _nameTextField(context, state),
            const SizedBox(height: 16),
            const Text("Email"),
            const SizedBox(
              height: 10,
            ),
            _emailTextField(context, state),
            const SizedBox(height: 16),
            const Text("Password"),
            const SizedBox(
              height: 10,
            ),
            _passwordTextField(context, state),
            const SizedBox(height: 60),
            _registerButton(
              context,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _nameTextField(BuildContext context, RegisterState state) {
    return BorderedTextField(
      key: const Key("name"),
      prefixIcon: const Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Icon(Icons.face, color: AppColors.black),
      ),
      style: TextStyles.bodyRegular(context),
      backgroundColor: AppColors.white,
      labelText: 'Name',
      onTextChanged: (text) {
        bloc!.add(NameChanged(text));
      },
    );
  }

  Widget _emailTextField(BuildContext context, RegisterState state) {
    return BorderedTextField(
      key: const Key("email"),
      prefixIcon: const Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Icon(Icons.email_rounded, color: AppColors.black),
      ),
      style: TextStyles.bodyRegular(context),
      backgroundColor: AppColors.white,
      labelText: 'Email',
      onTextChanged: (text) {
        bloc!.add(EmailChanged(text));
      },
    );
  }

  Widget _passwordTextField(BuildContext context, RegisterState state) {
    return BorderedTextField(
      key: const Key("password"),
      obscureText: true,
      prefixIcon: const Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Icon(Icons.lock, color: AppColors.black),
      ),
      maxLines: 1,
      backgroundColor: AppColors.white,
      style: TextStyles.bodyRegular(context),
      labelText: 'Password',
      onTextChanged: (text) {
        bloc!.add(PasswordChanged(text));
      },
    );
  }

  Widget _registerButton(BuildContext context) {
    return AppButton(
      onTap: () {
        bloc!.add(RegisterTapped());
      },
      label: "Register".toUpperCase(),
      color: AppColors.ashBlue,
    );
  }
}
