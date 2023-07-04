import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hafleh/common/values/colors.dart';
import 'package:hafleh/core/blocs/info/info_bloc.dart';
import 'package:hafleh/core/repositories/info_repository.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:hafleh/common/values/theme.dart';
import 'package:hafleh/common/route.dart';
import 'package:device_preview/device_preview.dart';
import 'package:hafleh/core/blocs/auth/auth_bloc.dart';
import 'package:hafleh/core/blocs/profile/profile_bloc.dart';
import 'package:hafleh/core/repositories/auth_repository.dart';
import 'package:hafleh/core/repositories/profile_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: "the-hafleh-app",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authenticationRepository = AuthRepository();
  final profileRepository = ProfileRepository();
  final infoRepository = InfoRepository();

  runApp(DevicePreview(
    enabled: false,
    builder: (context) => MyApp(
      authenticationRepository: authenticationRepository,
      profileRepository: profileRepository,
      infoRepository: infoRepository,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository _authenticationRepository;
  final ProfileRepository _profileRepository;
  final InfoRepository _infoRepository;

  const MyApp({
    super.key,
    required AuthRepository authenticationRepository,
    required ProfileRepository profileRepository,
    required InfoRepository infoRepository,
  })  : _authenticationRepository = authenticationRepository,
        _profileRepository = profileRepository,
        _infoRepository = infoRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _authenticationRepository,
        child: MultiBlocProvider(providers: [
          BlocProvider<AuthBloc>(
            create: (_) => AuthBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider<ProfileBloc>(
            create: (_) => ProfileBloc(
              profileRepository: _profileRepository,
            ),
          ),
          BlocProvider<InfoBloc>(
            create: (_) => InfoBloc(
              infoRepository: _infoRepository,
            ),
          ),
        ], child: const OverlaySupport.global(child: AppView())));
  }
}

class AppView extends StatelessWidget implements TickerProvider {
  const AppView({super.key});

  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        title: "Hafleh",
        home: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  User? authedUser = FirebaseAuth.instance.currentUser;
                  context
                      .read<ProfileBloc>()
                      .add(ProfileLoadRequested(authedUser!.uid));
                  context
                      .read<InfoBloc>()
                      .add(InfoLoadRequested(authedUser.uid));
                } else if (state is UnAuthenticated) {
                  context.read<ProfileBloc>().add(ProfileSignoutRequested());
                  if (state.error != null && state.error != "") {
                    toast(state.error!);
                  }
                }
              },
            )
          ],
          child: LoaderOverlay(
              useDefaultLoading: false,
              overlayWidget: const Center(
                child: SpinKitCubeGrid(
                  color: ThemeColors.primary,
                  size: 50.0,
                ),
              ),
              child: FlowBuilder<AuthRouteState>(
                state: getRouteState(
                  context.select((AuthBloc bloc) => bloc.state),
                  context.select((ProfileBloc bloc) => bloc.state),
                  context.select((InfoBloc bloc) => bloc.state),
                ),
                onGeneratePages: onGenerateAppViewPages,
              )),
        ));
  }
}
