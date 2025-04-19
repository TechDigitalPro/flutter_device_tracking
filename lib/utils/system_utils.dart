import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

/// Go back to previous screen.
void finishView(BuildContext context, [Object? result]) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context, result);
  } else {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}

/// Go to new screen with provided screen tag.
///
/// ```dart
/// launchNewScreen(context, '/HomePage');
/// ```
Future<T?> launchNewScreen<T>(BuildContext context, String tag) async =>
    Navigator.of(context).pushNamed(tag);

/// Removes all previous screens from the back stack and redirect to new screen with provided screen tag
///
/// ```dart
/// launchNewScreenWithNewTask(context, '/HomePage');
/// ```
Future<T?> launchNewScreenWithNewTask<T>(
        BuildContext context, String tag) async =>
    Navigator.of(context).pushNamedAndRemoveUntil(tag, (r) => false);

/// Change status bar Color and Brightness
Future<void> setStatusBarColor(
  Color statusBarColor, {
  Color? systemNavigationBarColor,
  Brightness? statusBarBrightness,  
  Brightness? statusBarIconBrightness,
  int delayInMilliSeconds = 200,
}) async {
  await Future.delayed(Duration(milliseconds: delayInMilliSeconds));

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      systemNavigationBarColor: systemNavigationBarColor,
      statusBarBrightness: statusBarBrightness,
      statusBarIconBrightness: statusBarIconBrightness ??
          (statusBarColor.isDark() ? Brightness.light : Brightness.dark),
    ),
  );
}

/// This function will show status bar
Future<void> showStatusBar() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
}

/// This function will hide status bar
Future<void> hideStatusBar() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

/// Set orientation to portrait
void setOrientationPortrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}

/// Set orientation to landscape
void setOrientationLandscape() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

/// Returns current PlatformName
String platformName() {
  if (isLinux) return 'Linux';
  if (isWeb) return 'Web';
  if (isMacOS) return 'macOS';
  if (isWindows) return 'Windows';
  if (isAndroid) return 'Android';
  if (isIOS) return 'iOS';
  return '';
}

/// Custom scroll behaviour
Widget Function(BuildContext, Widget?)? scrollBehaviour() {
  return (context, child) {
    return ScrollConfiguration(behavior: SBehavior(), child: child!);
  };
}

/// Custom scroll behaviour widget
class SBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

/// Invoke Native method and get result
Future<T?> invokeNativeMethod<T>(String channel, String method,
    [dynamic arguments]) async {
  var platform = MethodChannel(channel);
  return await platform.invokeMethod<T>(method, arguments);
}

bool isValidEmail(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(p);

  return regExp.hasMatch(email);
}

bool isValidPassword(String password) {
  return password.length >= 6;
}

/// If this url can open external app, it will redirect to this app
bool needToOpenExternalApp(String? url) {
  for (var app in kExternalNonBrowserAppURLs) {
    if (url?.startsWith(app) ?? false) {
      return true;
    }
  }
  for (var app in kExternalAppURLs) {
    if ((url?.startsWith('http') ?? false) && (url?.contains(app) ?? false)) {
      return true;
    }
  }
  return false;
}

String? prepareURL(String? url) {
    if (url == null) {
      return null;
    }

    final uri = Uri.tryParse(url);
    if (uri == null) {
      return null;
    }

    if (!url.startsWith('http') && uri.scheme.isEmpty) {
      return 'https://$url';
    }

    if (url.startsWith('intent://') && url.contains('scheme=')) {
      final intentInfo = url.substring(url.indexOf('scheme='));
      final scheme = intentInfo.substring(
          intentInfo.indexOf('scheme=') + 7, intentInfo.indexOf(';'));
      return url.replaceFirst('intent://', '$scheme://');
    }

    return url;
  }

Future<void> launchURL(
    String? originUrl, {
    LaunchMode? mode,
  }) async {
    var url = prepareURL(originUrl);
    final uri = Uri.tryParse(url ?? '');
    if (mode == null && needToOpenExternalApp(url)) {
      mode = LaunchMode.externalApplication;
    }

    if (mode == LaunchMode.externalNonBrowserApplication &&
        uri != null &&
        !(await canLaunchUrl(uri))) {
      mode = LaunchMode.externalApplication;
    }

    if (url == null ||
        uri == null ||
        !(await launchUrl(uri, mode: mode ?? LaunchMode.platformDefault))) {
      throw 'Could not launch $originUrl';
    }
  }

const kExternalNonBrowserAppURLs = [
  'tel:', // Phone call
  'sms:', // Send SMS
  'smsto:', // Send SMS
  'mailto:', // Send mail
  'skype:', // Skype
  'intent://', // Need to repace with scheme in the url
  'whatsapp://', // Whatsapp
  'instagram://', // Instagram
  'instagram-stories://', // Instagram story
  'twitter://', // Twitter
  'fb://', // Facebook
  'tg://', // Telegram
  'comgooglemaps://', // Google Maps
  'comgooglemapsurl://', // Google Maps URL
];

const kExternalAppURLs = [
  'wa.me', // Whatsapp
  'm.me', // Messenger
  'ig.me', // Instagram
  'instagram.com', // Instagram
  'twitter.com', // Twitter
  'facebook.com', // Facebook
  'youtube.com', // Youbute
  'youtu.be', // Youbute
  't.me', // Telegram
  'play.google.com', // Google play
  'apps.apple.com', // App store
];