import 'package:flutter/widgets.dart';
import 'package:the_hafleh/core/blocs/auth/auth_bloc.dart';
import 'package:the_hafleh/core/blocs/profile/profile_bloc.dart';
import 'package:the_hafleh/view/auth/signup_page.dart';
import 'package:the_hafleh/view/info/create_info_page.dart';
import 'package:the_hafleh/view/profile/create_profile_page.dart';
import 'package:the_hafleh/view/welcome/welcome_info_page.dart';
import 'package:the_hafleh/view/auth/signin_page.dart';
import 'package:the_hafleh/view/welcome/welcome_done_page.dart';
import 'package:the_hafleh/view/welcome/welcome_page.dart';
import 'package:the_hafleh/view/welcome/welcome_profile_PAGE.dart';

enum AuthRouteState {
  initializing,
  creating,
  authenticated,
  unauthenticated,
}

List<Page<dynamic>> onGenerateAppViewPages(
  AuthRouteState state,
  List<Page<dynamic>> pages,
) {
  return [WelcomePage.page()];
}

AuthRouteState getRouteState(
  AuthState authState,
  ProfileState profileState,
) {
  return AuthRouteState.creating;
}
