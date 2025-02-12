import 'package:app_task/src/application/form/form_bloc.dart';
import 'package:app_task/src/application/home/home_bloc.dart';
import 'package:app_task/src/application/login/login_bloc.dart';
import 'package:app_task/src/application/register/register_bloc.dart';
import 'package:app_task/src/presentation/home/home_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_task/src/application/profile/profile_bloc.dart';
import 'package:app_task/src/application/splash/splash_bloc.dart';
import 'package:app_task/src/application/web_view/web_view_bloc.dart';
import 'package:app_task/src/domain/core/repository_provider.dart';
import 'package:app_task/src/presentation/web_view/web_view_page.dart';
import 'package:app_task/src/utils/device_token_helper.dart';
import 'package:app_task/src/utils/file_util.dart';
import 'package:app_task/src/utils/notification_util.dart';

SplashBloc provideSplashBloc() {
  return SplashBloc(
    authRepository: provideAuthRepository(),
    userRepository: provideUserRepository(),
  );
}

ProfileBloc provideProfileBloc() {
  return ProfileBloc();
}

LoginBloc provideLoginBloc() {
  return LoginBloc(
    authRepository: provideAuthRepository(),
    // userRepository: provideUserRepository()
  );
}

RegisterBloc provideRegisterBloc() {
  return RegisterBloc();
}

HomeBloc provideHomeBloc() {
  return HomeBloc(
    homeRepository: provideHomeRepository(),
  );
}

FormFillBloc provideFormFillBloc() {
  return FormFillBloc();
}

WebViewBloc provideWebViewBloc(WebViewArgument argument) {
  return WebViewBloc(
    authRepository: provideAuthRepository(),
    isHeaderRequired: argument.isHeaderRequired,
    url: argument.url,
    title: argument.title,
    successUrl: argument.successUrl,
    alternateSuccessUrl: argument.alternateSuccessUrl,
    failureUrl: argument.failureUrl,
    isBackConfirmationRequired: argument.isBackConfirmationRequired,
    fileUtil: provideFileUtil(),
  );
}

// OtpBloc provideOtpBloc(LoginPageArguments argument) {
//   return OtpBloc(
//     authRepository: provideAuthRepository(),
//     networkValidator: provideNetworkValidator(),
//     email: argument.email,
//     mobileNumber: argument.mobileNumber,
//   );
// }

DeviceTokenHelper provideDeviceTokenHelper() {
  return DeviceTokenHelper(
    deviceTokenRepository: provideDeviceTokenRepository(),
    userRepository: provideUserRepository(),
  );
}

NotificationUtil provideNotificationUtil() {
  return NotificationUtil(
    networkValidator: provideNetworkValidator(),
  );
}

FileUtil provideFileUtil() {
  return FileUtil(
    imagePicker: ImagePicker(),
  );
}
