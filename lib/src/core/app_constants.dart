import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart' as intl;
import 'package:app_task/config.dart';
import 'package:app_task/src/utils/network_auth_interceptor.dart';
import 'package:app_task/src/utils/network_usage_interceptor.dart';

const androidPlayStoreUrl =
    'https://play.google.com/store/apps/details?id=com.app.task';
const iosAppStoreUrl =
    'https://itunes.apple.com/in/app/thinkpalm-hub/id6446245269';

const int maxFailuresCount = 3;

const whiteListDocumentExtensions = [
  '.pdf',
  '.doc',
  '.docx',
  '.jpg',
  '.jpeg',
  '.png',
  '.txt',
  '.xls',
  '.xlsx',
  '.mp3',
  '.mp4',
  '.mov',
];

const whiteListDocumentMimeTypes = [
  'application/msword',
  'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
  'image/jpeg',
  'image/png',
  'image/jpg',
  'application/pdf',
  'text/plain',
  'audio/',
];

const whiteListDocumentUtiTypes = [
  'public.image',
  'public.jpeg',
  'public.png',
  'com.adobe.pdf',
  'com.microsoft.word.doc',
  'com.microsoft.word.wordml',
];

const whiteListImageExtensions = ['.jpg', '.jpeg', '.png'];

const whiteListImageMimeTypes = [
  'image/jpeg',
  'image/png',
  'image/jpg',
];

const whiteListedAudioMimeTypes = ['audio/*'];

const whiteListAudioExtensions = [
  '.m4a',
  '.mp3',
  '.wav',
  '.wma',
  '.aac',
  'aud',
];

const whiteListVideoExtensions = [
  '.mp4',
];

const whiteListImageUtiTypes = [
  'public.image',
  'public.jpeg',
  'public.png',
];

const whiteListedAudioUtiTypes = [
  'public.audio',
  'public.mp3',
  'com.real.realaudio',
  'public.ulaw-audio',
  'public.au-audio',
  'public.aifc-audio',
  'public.midi-audio',
  'public.downloadable-sound',
  'com.apple.coreaudio-format',
  'public.ac3-audio',
  'com.digidesign.sd2-audio',
  'com.microsoft.thinkhubform-audio',
  'com.soundblaster.soundfont',
];

const whiteListDocumentExtensionsForChat = [
  '.pdf',
  '.xls',
  '.xlsx',
  'doc',
  'docx',
  'aac',
];

const whiteListVideoExtensionsForChat = [
  '.webm',
  '.mkv',
  '.flv',
  '.mp4',
  '.mpg',
];

const whiteListPdfMimeType = [
  'application/pdf',
];

const whiteListPdfUtiType = [
  'com.adobe.pdf',
];

//Fire base dynamic link
const kUriPrefix = '';
const kWebUrl = '';
const kBundleId = 'com.task.app';

///Kb, Mb and Gb in Bytes
const kbInBytes = 1024;
const mbInBytes = 1048576;
const gbInBytes = 1073741824;

class Units {
  Units._();

  static const double _kPaddingUnit = 4.0;
  static const double kXSPadding = _kPaddingUnit;
  static const double kSPadding = 2 * _kPaddingUnit;
  static const double kMPadding = 3 * _kPaddingUnit;
  static const double kStandardPadding = 4 * _kPaddingUnit;
  static const double kLPadding = 5 * _kPaddingUnit;
  static const double kXLPadding = 6 * _kPaddingUnit;
  static const double kXXLPadding = 7 * _kPaddingUnit;
  static const double kXXXLPadding = 8 * _kPaddingUnit;

  static const double kTextFieldBorderRadius = 8;

  static const double kAppBarHeight = 64;
  static const double kAppIconSize = 24;
  static const double kAppIconSizeExtraSmall = 12;
  static const double kAppIconSizeLarge = 32;
  static const double kAppIconSizeMedium = 28;
  static const double kAppIconSizeSmall = 18;
  static const double kButtonBorderRadius = 8;
  static const double kButtonBorderWidth = 1;
  static const double kButtonElevation = 4;
  static const double kButtonHeight = 36;
  static const double kButtonHeightMedium = 40;
  static const double kButtonHeightLarge = 44;
  static const double kButtonHeightExtraSmall = 24;
  static const double kButtonHeightSmall = 32;
  static const double kButtonRadius = 30;
  static const double kButtonWidth = 140;
  static const double kCardBorderRadius = 12;
  static const double kCardBorderRadiusExtraSmall = 6;
  static const double kCardBorderRadiusLarge = 20;
  static const double kCardElevation = 4;
  static const double kContentOffSet = 50;
  static const double kExpandedHeight = 190;
  static const double kLineHeight = 1;
  static const double kLoaderHeight = 24;
  static const double kMinExpandedHeight = 100;
  static const double kMinExpandedWidth = 90;
  static const double kShadowBoxHeight = 60;
  static const double kShowDialogueBoxMaxHeight = 280;
  static const double kShowDialogueBoxMinHeight = 100;
  static const double kTextBoxHeight = 50;
  static const double kTextBoxRadius = 30;
  static const double kVeryMinExpandedHeight = 80;
  static const double kZero = 0;
}

class AppIcons {
  AppIcons._();

  static const String kBgImage = 'assets/images/bg.png';
  static const String kBgLandscape = 'assets/images/bg_landscape.jpg';
  static const String kDownArrow = 'assets/images/ic_down_arrow.svg';
  static const String kLogo = 'assets/images/heads_logo.png';
  static const String kLogoSvg = 'assets/images/logo.svg';
}
class PriorityOptions{
  static List<String> priorityOptions = ["High", "Medium", "Low"];
  static List<String> taskStatus = ["ToDo", "In-Progress", "Done"];
}


class APIEndpoints {
  // AUTH
  static String get _authBaseUrl =>
      Config.appFlavor.identityServerBaseUrl.replaceAll(
        '{tenant_id}',
        Config.appFlavor.tenantID,
      );

  static String get authUrl => '$_authBaseUrl/authorize';

  static String get authTokenUrl => '$_authBaseUrl/token';

  static String get logoutUrl => '$_authBaseUrl/logout';

  static String get logoutSessionUrl => '$_authBaseUrl/logoutsession';

  static String get loginUrl => '$_authBaseUrl/Account/Login';

  static String get changePasswordUrl => '$_authBaseUrl/Manage/ChangePassword';

  static String get userinfo => '$_authBaseUrl/userinfo';
}

class NetworkClient {
  NetworkClient._();

  static final dio.BaseOptions _options = dio.BaseOptions(
    connectTimeout: const Duration(seconds: 50),
    receiveTimeout: const Duration(seconds: 50),
  );

  static dio.Dio? _dio;

  static dio.Dio get dioInstance {
    if (_dio == null) {
      _dio = dio.Dio(_options);
      _dio!.interceptors.add(NetworkUsageInterceptor());
      _dio!.interceptors.add(NetworkAuthInterceptor());
    }
    return _dio!;
  }
}

class DeepLinkType {
  static const String profile = 'profile';
}

final dateFormat = intl.DateFormat("dd-MM-yyyy");
final timeFormat = intl.DateFormat("hh:mm aa");

const String docx = ".docx";
const String xls = ".xls";
