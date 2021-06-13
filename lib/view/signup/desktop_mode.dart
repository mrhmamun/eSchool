import 'package:eschool/view/signup/signup_form.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DesktopSignUpMode extends StatefulWidget {
  @override
  _DesktopSignUpModeState createState() => _DesktopSignUpModeState();
}

class _DesktopSignUpModeState extends State<DesktopSignUpMode> {
  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    return Container(
        color: Color.fromRGBO(224, 245, 255, 1),
        child: Center(
            child: Container(
                height: heightSize * 0.65,
                width: widthSize * 0.65,
                child: Card(
                    elevation: 5,
                    child: Row(children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              child: Align(
                            alignment: Alignment.center,
                            child: kIsWeb
                                ? Image.network(
                                    'assets/assets/images/login-image.png',
                                    height: heightSize * 0.5,
                                    width: widthSize * 0.5,
                                    semanticLabel: 'test')
                                : Image.asset('images/login-image.png',
                                    height: heightSize * 0.5,
                                    width: widthSize * 0.5,
                                    semanticLabel: 'test'),
                          ))),
                      Expanded(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.only(top: 20),
                              color: Color.fromRGBO(41, 187, 255, 1),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    kIsWeb
                                        ? Image.network(
                                            'assets/assets/images/login-form.png',
                                            color: Colors.white,
                                            height: heightSize * 0.1,
                                            width: widthSize * 0.15)
                                        : Image.asset('images/login-form.png',
                                            color: Colors.white,
                                            height: heightSize * 0.1,
                                            width: widthSize * 0.15),
                                    SizedBox(height: 20),
                                    SignUpForm(0, 0, 16, 0.04, 0.01, 0.04, 75,
                                        0.01, 0.007, 0.01, 0.006)
                                  ])))
                    ])))));
  }
}
