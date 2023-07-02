// ignore_for_file: implementation_imports, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_hafleh/common/values/colors.dart';
import 'package:the_hafleh/common/values/custom_text_style.dart';
import 'package:the_hafleh/common/utils/logger.dart';
import 'package:the_hafleh/common/widgets/button.dart';
import 'package:the_hafleh/common/widgets/phone_number_input/phone_number_input.dart';
import 'package:the_hafleh/core/blocs/auth/auth_bloc.dart';
import 'package:the_hafleh/view/auth/auth_otp_page.dart';
import 'package:the_hafleh/common/widgets/static_progress_bar.dart';
import 'package:intl_phone_number_input/src/utils/phone_number.dart';
import 'package:intl_phone_number_input/src/utils/selector_config.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();

  static Page<void> page() => MaterialPage<void>(child: SignupPage());
  static Route<void> route() =>
      MaterialPageRoute<void>(builder: (_) => SignupPage());
}

class _SignupPageState extends State<SignupPage> {
  bool isChecked = false;
  final TextEditingController controller = TextEditingController();
  String initialCountry = 'US';
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  String phoneNumber = "";
  bool validated = false;
  bool showError = false;

  void loginWithPhone() {
    // if (!validated) {
    //   return;
    // }
    // if (!isChecked) {
    //   setState(() {
    //     showError = true;
    //   });
    //   return;
    // }

    setState(() {
      showError = false;
    });

    context.read<AuthBloc>().add(PhoneSignInRequested(phoneNumber));
    Navigator.of(context)
        .push(AuthOTPPage.route(phoneNumber: phoneNumber, type: 'signup'));
  }

  void doSocialAuth(String type) async {
    try {
      if (type == 'google') {
        context.read<AuthBloc>().add(GoogleSignInRequested());
      } else {
        context.read<AuthBloc>().add(AppleSignInRequested());
      }
    } catch (e) {
      logger.e("doSocialAuth error $e");
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
                        child: StaticProgressBar(count: 2, current: 1),
                      ),
                      SizedBox(width: 8),
                    ]),
                    const SizedBox(height: 12),
                    SvgPicture.asset(
                      "assets/icons/phone.svg",
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 12),
                    Text('Enter and verify Mobile Phone',
                        style: CustomTextStyle.getTitleStyle()),
                    const SizedBox(height: 34),
                    InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                        setState(() {
                          phoneNumber = number.phoneNumber!;
                        });
                      },
                      onInputValidated: (bool value) {
                        print("validated $value");
                        setState(() {
                          validated = value;
                        });
                      },
                      selectorConfig: const SelectorConfig(
                          setSelectorButtonAsPrefixIcon: true),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      hintText: 'Phone number',
                      textStyle: const TextStyle(fontSize: 16),
                      errorMessage: '*Please enter a valid phone number',
                      selectorTextStyle:
                          const TextStyle(color: ThemeColors.primary),
                      initialValue: number,
                      textFieldController: controller,
                      selectorButtonOnErrorPadding: 0,
                      formatInput: false,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      spaceBetweenSelectorAndTextField: 0,
                      onSaved: (PhoneNumber number) {
                        setState(() {
                          number = number;
                        });
                        print('On Saved: $number');
                      },
                    ),
                  ],
                )),
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
                            loginWithPhone();
                          })),
                  const SizedBox(width: 8),
                ]),
                const SizedBox(height: 16),
              ],
            )));
  }
}
