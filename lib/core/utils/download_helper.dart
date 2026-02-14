import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'download_helper_stub.dart'
    if (dart.library.html) 'download_helper_web.dart'
    as helper;

class DownloadUtils {
  static void downloadResume(String url, String fileName) {
    if (kIsWeb) {
      // On web, use the anchor tag to force download
      // Flutter web assets are actually at assets/assets/...
      String finalUrl = url;
      if (url.startsWith('assets/') && !url.startsWith('assets/assets/')) {
        finalUrl = 'assets/$url';
      }
      helper.downloadFile(finalUrl, fileName);
    } else {
      // On other platforms, launch the URL normally
      launchUrlString(url);
    }
  }
}
