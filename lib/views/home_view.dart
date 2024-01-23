import 'package:flutter/material.dart';
import 'package:shortify/controllers/shortify_controller.dart';
import 'package:shortify/enums/response_status.dart';
import 'package:shortify/utils/constants.dart';
import 'package:shortify/utils/responsive_text.dart';
import 'package:shortify/utils/util.dart';
import 'package:shortify/views/result_view.dart';

import '../widgets/custom_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late ShortifyController shortifyController;
  final TextEditingController urlInputController = TextEditingController();
  bool showProgressbar = false;

  @override
  void initState() {
    super.initState();
    shortifyController = ShortifyController();
    shortifyController.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const ResponsiveText(
                    kAppName,
                    fontSize: 24,
                    textColor: kTitleColor,
                    fontWeight: FontWeight.w700,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const ResponsiveText(
                    kDestinationUrl,
                    fontSize: 16,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextField(
                    controller: urlInputController,
                    decoration: const InputDecoration(
                        hintText: kVritTechnologies,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: kHintColor),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        )),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 24),
                  CustomButton(onPressed: showProgressbar? null:  () async {
                    setState(() {
                      showProgressbar = true;
                    });
                    shortifyController
                        .getShortedLink(urlInputController.text.trim())
                        .then((responseStatus) {
                      setState(() {
                        showProgressbar = false;
                      });
                      if (responseStatus is ResponseSuccess) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ResultView(
                                  shortify: responseStatus.data,
                                )));
                      } else if (responseStatus is ResponseFailure) {
                        final snackBar = SnackBar(
                          content: ResponsiveText(
                            responseStatus.message,
                            textColor: Colors.white,
                          ),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                  }, backgroundColor: showProgressbar? Colors.grey: kBackgroundColor,),
                ],
              ),
            ),
            if (showProgressbar)
              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(height * 0.05),
                  decoration:
                      BoxDecoration(color: Colors.grey.withOpacity(0.5)),
                  child: const CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// design reference from https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRIky5-rGidrA0PDTqijL_ritWq6x27B7zkjQ&usqp=CAU