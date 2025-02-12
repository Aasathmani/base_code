import 'package:app_task/src/application/register/register_bloc.dart';
import 'package:app_task/src/application/register/register_state.dart';
import 'package:app_task/src/core/app_constants.dart';
import 'package:app_task/src/presentation/core/app_page.dart';
import 'package:app_task/src/presentation/core/base_state.dart';
import 'package:app_task/src/presentation/core/theme/colors.dart';
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
  RegisterBloc? _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {},
      builder: (context, state) {
        return AppPage(
          title: "",
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
            Text('Full name'),
            const SizedBox(height: 10,),
            BorderedTextField(
              key: const Key("name"),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(Icons.face, color: AppColors.black),
              ),
              backgroundColor: AppColors.white,
              labelText: 'Name',
              onTextChanged: (text) {},
            ),
            const SizedBox(height: 16),
            const Text("Email"),
            const SizedBox(height: 10,),
            BorderedTextField(
              key: const Key("email"),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(Icons.email_rounded, color: AppColors.black),
              ),
              backgroundColor: AppColors.white,
              labelText: 'Email',
              onTextChanged: (text) {},
            ),
            const SizedBox(height: 16),
            const Text("Password"),
            const SizedBox(height: 10,),
            BorderedTextField(
              key: const Key("password"),
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Icon(Icons.lock, color: AppColors.black),
              ),
              backgroundColor: AppColors.white,
              labelText: 'Password',
              onTextChanged: (text) {},
            ),
            const SizedBox(height: 60),
            AppButton(
              onTap: () {},
              label: "Register".toUpperCase(),
              color: AppColors.ashBlue,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
