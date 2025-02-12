import 'package:app_task/src/presentation/form/form_page.dart';
import 'package:app_task/src/presentation/home/home_page.dart';
import 'package:app_task/src/presentation/login/login_page.dart';
import 'package:app_task/src/presentation/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_task/src/application/core/bloc_provider.dart';
//import 'package:app_task/src/application/otp/otp_bloc.dart';
import 'package:app_task/src/application/web_view/web_view_bloc.dart';
//import 'package:app_task/src/presentation/otp/otp_page.dart';
//import 'package:app_task/src/presentation/profile/profile_page.dart';
import 'package:app_task/src/presentation/splash/splash_page.dart';
import 'package:app_task/src/presentation/web_view/web_view_page.dart';

final Map<String, Widget Function(BuildContext context)> routes = {
  SplashPage.route: (_) => BlocProvider(
        create: (_) => provideSplashBloc(),
        child: const SplashPage(),
      ),
  LoginPage.route: (_) => BlocProvider(
        create: (_) => provideLoginBloc(),
        child: const LoginPage(),
      ),
  RegisterPage.route: (_) => BlocProvider(
        create: (_) => provideRegisterBloc(),
        child: const RegisterPage(),
      ),
  HomePage.route: (_) => BlocProvider(
        create: (_) => provideHomeBloc(),
        child: const HomePage(),
      ),
  FormPage.route: (_) => BlocProvider(
        create: (_) => provideFormFillBloc(),
        child: const FormPage(),
      ),
};

Route<dynamic>? generatedRoutes(RouteSettings settings) {
  final uri = Uri.parse(settings.name ?? '');
  debugPrint("URI.PATH : ${uri.path}");
  debugPrint("URI.queryParams : ${uri.queryParameters}");
  debugPrint("Settings : ${settings.name}");
  debugPrint("Arguments :  ${settings.arguments ?? "null"}");

  switch (uri.path) {
    case WebViewPage.route:
      if (settings.arguments != null && settings.arguments is WebViewArgument) {
        return _getWebViewRoute(
          settings,
          settings.arguments! as WebViewArgument,
        );
      }
    // case OtpPage.route:
    //   if (settings.arguments != null &&
    //       settings.arguments is LoginPageArguments) {
    //     return _getOtpPageRoute(
    //       settings,
    //       settings.arguments! as LoginPageArguments,
    //     );
    //   }
  }
  return null;
}

MaterialPageRoute _getWebViewRoute(
  RouteSettings settings,
  WebViewArgument argument,
) {
  return MaterialPageRoute(
    builder: (context) => BlocProvider<WebViewBloc>(
      create: (context) => provideWebViewBloc(argument),
      child: const WebViewPage(),
    ),
    settings: settings,
  );
}

// MaterialPageRoute _getOtpPageRoute(
//   RouteSettings settings,
//   LoginPageArguments argument,
// ) {
//   return MaterialPageRoute(
//     builder: (context) => BlocProvider<OtpBloc>(
//       create: (context) => provideOtpBloc(argument),
//       child: const OtpPage(),
//     ),
//     settings: settings,
//   );
// }
