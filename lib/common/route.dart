import 'package:flutter/widgets.dart';
import 'package:hafleh/core/blocs/auth/auth_bloc.dart';
import 'package:hafleh/core/blocs/profile/profile_bloc.dart';
import 'package:hafleh/view/auth/signup_page.dart';
import 'package:hafleh/view/invite/invite_friend_page.dart';
import 'package:hafleh/view/splash/splash_page.dart';
import 'package:hafleh/view/welcome/welcome_page.dart';
import 'package:hafleh/view/welcome/welcome_profile_page.dart';

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
  if (state == AuthRouteState.initializing) {
    return [SplashPage.page()];
  } else if (state == AuthRouteState.authenticated) {
    return [InviteFriendPage.page()];
  } else if (state == AuthRouteState.creating) {
    return [WelcomeProfilePage.page()];
  } else {
    return [SignupPage.page(), WelcomePage.page()];
  }
}

AuthRouteState getRouteState(
  AuthState authState,
  ProfileState profileState,
) {
  if (authState is AppInitializing) {
    return AuthRouteState.initializing;
  } else if (authState is Authenticated &&
      (profileState.status == ProfileStatus.success ||
          profileState.status == ProfileStatus.updateLoading)) {
    return AuthRouteState.authenticated;
  } else if (authState is Authenticated &&
      (profileState.status == ProfileStatus.notCreated ||
          profileState.status == ProfileStatus.created ||
          profileState.status == ProfileStatus.createLoading)) {
    return AuthRouteState.creating;
  } else {
    return AuthRouteState.unauthenticated;
  }
}
