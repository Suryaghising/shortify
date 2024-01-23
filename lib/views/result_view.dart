import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shortify/models/shortify.dart';
import 'package:shortify/utils/constants.dart';
import 'package:shortify/utils/responsive_text.dart';
import 'package:shortify/utils/util.dart';

class ResultView extends StatelessWidget {
  final Shortify shortify;

  const ResultView({super.key, required this.shortify});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const ResponsiveText(
          kAppName,
          textColor: Colors.white,
          fontSize: 20,
        ),
        backgroundColor: const Color(0xff193586),
        elevation: 0,
      ),
      backgroundColor: const Color(0xff193586),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(kHorizontalMargin * 3),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveText(
                  shortify.shortUrl,
                  fontSize: 20,
                ),
                SizedBox(height: kVerticalMargin),
                QrImageView(
                  data: shortify.shortUrl,
                  version: QrVersions.auto,
                  size: 250,
                  gapless: false,
                  errorStateBuilder: (cxt, err) {
                    return const Center(
                      child: ResponsiveText(
                        kSomethingWentWrong,
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
