// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hafleh/common/values/colors.dart';
import 'package:the_hafleh/common/values/custom_text_style.dart';
import 'package:the_hafleh/common/widgets/button.dart';
import 'package:the_hafleh/common/widgets/pin_code_input.dart';
import 'package:the_hafleh/common/widgets/static_progress_bar.dart';
import 'package:the_hafleh/core/blocs/auth/auth_bloc.dart';
import 'package:the_hafleh/core/repositories/auth_repository.dart';
// import 'package:the_hafleh/view/auth/camera_page.dart';
// import 'package:the_hafleh/view/auth/create_account/create_account_page.dart';
import 'package:the_hafleh/view/welcome/welcome_profile_page.dart';

enum OTPState { shouldArrive, sendAgain, didNotGetCode }

class AuthOTPPage extends StatefulWidget {
  String phoneNumber;
  String type;
  AuthOTPPage({required this.phoneNumber, required this.type});

  static Route<void> route({required phoneNumber, required type}) =>
      MaterialPageRoute<void>(
          builder: (_) => AuthOTPPage(phoneNumber: phoneNumber, type: type));

  @override
  _AuthOTPPageState createState() => _AuthOTPPageState();
}

class _AuthOTPPageState extends State<AuthOTPPage> {
  bool isChecked = false;
  TextEditingController controller = TextEditingController(text: "");
  String thisText = "";
  int pinLength = 6;
  bool hasError = false;
  late String errorMessage;
  OTPState step = OTPState.shouldArrive;
  int timeoutCount = 60;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      AuthRepository authRepository = context.read<AuthBloc>().authRepository;
      if (timeoutCount >= 0 && authRepository.codeSent == true) {
        setState(() {
          timeoutCount--;
        });
        if (timeoutCount == 0) {
          setState(() {
            step = OTPState.didNotGetCode;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void countSeconds() {
    context.read<AuthBloc>().add(PhoneSignInRequested(widget.phoneNumber));
    controller.clear();
    setState(() {
      timeoutCount = 60;
      step = OTPState.shouldArrive;
    });
  }

  void onNextProcess(String text) async {
    print("DONE CONTROLLER ${controller.text}");
    AuthRepository authRepository = context.read<AuthBloc>().authRepository;
    try {
      await authRepository.verifyOTP(controller.text);
    } catch (e) {
      setState(() {
        timeoutCount = 0;
        step = OTPState.sendAgain;
      });
      return;
    }

    if (widget.type == 'signin') {
      // ignore: use_build_context_synchronously
      // CommonDialogs.showSimpleDialog(
      //   context,
      //   title: "Extra security with photo",
      //   description: "Take a selfie to verify account",
      //   button1: "Make Selfie",
      //   dismissible: false,
      //   onButton1Pressed: () async {
      //     if (Platform.isAndroid || Platform.isIOS) {
      //       await Navigator.of(context).push(CameraPage.route());
      //     }
      //     ignore: use_build_context_synchronously
      //     CommonDialogs.showSimpleDialog(
      //       context,
      //       title: "Success",
      //       description: "Thanks, your safety verification is complete.",
      //       button1: "Ok",
      //       dismissible: false,
      //       onButton1Pressed: () {
      //         context.read<AuthBloc>().add(MakeForceSignIn());
      //       },
      //     );
      //   },
      //   button2: "Not Now",
      //   onButton2Pressed: () {
      //     context.read<AuthBloc>().add(MakeForceSignIn());
      //   },
      // );
    } else {
      // context.read<AuthBloc>().add(VerifyOTPRequested(controller.text));
      // Navigator.of(context).push(CreateAccountPage.route());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Row(children: const <Widget>[
                      SizedBox(width: 8),
                      Expanded(
                        child: StaticProgressBar(count: 2, current: 2),
                      ),
                      SizedBox(width: 8),
                    ]),
                    const SizedBox(height: 12),
                    SvgPicture.asset(
                      "assets/icons/verify.svg",
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 12),
                    Text('Enter your verification code',
                        style: CustomTextStyle.getTitleStyle()),
                    const SizedBox(height: 12),
                    Text('The code has been sent to your number:',
                        style: CustomTextStyle.getDescStyle(
                            Theme.of(context).colorScheme.onSurface)),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: CustomTextStyle.getDescStyle(
                            Theme.of(context).colorScheme.onSurface),
                        children: <TextSpan>[
                          TextSpan(text: "${widget.phoneNumber} "),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    PinCodeTextField(
                      autofocus: true,
                      controller: controller,
                      hideCharacter: false,
                      highlight: false,
                      defaultBorderColor:
                          Theme.of(context).colorScheme.onSurface,
                      hasTextBorderColor: Theme.of(context).colorScheme.primary,
                      maxLength: pinLength,
                      hasError: hasError,
                      onTextChanged: (text) {
                        setState(() {
                          hasError = false;
                        });
                      },
                      onDone: (text) {
                        onNextProcess(text);
                      },
                      pinBoxHeight: 64,
                      hasUnderline: true,
                      wrapAlignment: WrapAlignment.spaceAround,
                      pinTextStyle: const TextStyle(fontSize: 28.0),
                      pinTextAnimatedSwitcherTransition:
                          ProvidedPinBoxTextAnimation.scalingTransition,
                      pinBoxColor: Colors.transparent,
                      pinTextAnimatedSwitcherDuration:
                          const Duration(milliseconds: 300),
                      // highlightAnimation: true,
                      highlightAnimationBeginColor:
                          Theme.of(context).colorScheme.onSecondary,
                      highlightAnimationEndColor: Colors.white12,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                )),
                // if (step == OTPState.shouldArrive)
                //   textArrivedIn(timeoutCount)
                // else if (step == OTPState.didNotGetCode)
                //   dontGetACode()
                // else
                //   sendAgain()
                Row(children: <Widget>[
                  const SizedBox(width: 8),
                  Expanded(
                      child: Button(
                          title: "BACK",
                          flag: true,
                          outlined: true,
                          onPressed: () {
                            Navigator.of(context).pop();
                          })),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Button(
                          title: "NEXT",
                          flag: true,
                          onPressed: () {
                            Navigator.of(context)
                                .push<void>(WelcomeProfilePage.route());
                            // loginWithPhone();
                          })),
                  const SizedBox(width: 8),
                ]),
                const SizedBox(height: 16),
              ],
            )));
  }

  Widget textArrivedIn(int seconds) {
    return RichText(
      text: TextSpan(
        style: CustomTextStyle.getDescStyle(
            Theme.of(context).colorScheme.onSecondary),
        children: <TextSpan>[
          TextSpan(text: 'Text should arrive within ${seconds}s. '),
        ],
      ),
    );
  }

  Widget sendAgain() {
    TextStyle linkStyle = const TextStyle(decoration: TextDecoration.underline);
    return RichText(
      text: TextSpan(
        style: CustomTextStyle.getDescStyle(
            Theme.of(context).colorScheme.onSecondary),
        children: <TextSpan>[
          const TextSpan(text: 'Wrong code. Please '),
          TextSpan(
              text: 'send again',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('send again');
                  countSeconds();
                  controller.clearComposing();
                }),
        ],
      ),
    );
  }

  Widget dontGetACode() {
    TextStyle linkStyle = const TextStyle(decoration: TextDecoration.underline);
    return RichText(
      text: TextSpan(
        style: CustomTextStyle.getDescStyle(
            Theme.of(context).colorScheme.onSecondary),
        children: <TextSpan>[
          TextSpan(
              text: 'Didn\'t get a code?',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Didnt get a code');
                  countSeconds();
                }),
        ],
      ),
    );
  }

  Widget changePhone() {
    return RichText(
      text: TextSpan(
        style:
            CustomTextStyle.getDescStyle(Theme.of(context).colorScheme.outline),
        children: <TextSpan>[
          TextSpan(text: "${widget.phoneNumber} "),
        ],
      ),
    );
  }
}
