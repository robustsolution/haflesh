import 'package:firebase_auth/firebase_auth.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_hafleh/common/values/theme.dart';
import 'package:the_hafleh/common/route.dart';
import 'package:device_preview/device_preview.dart';
import 'package:the_hafleh/core/blocs/auth/auth_bloc.dart';
import 'package:the_hafleh/core/blocs/profile/profile_bloc.dart';
import 'package:the_hafleh/core/repositories/auth_repository.dart';
import 'package:the_hafleh/core/repositories/profile_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState, User;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://amxfxxvibhfioakdwstm.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFteGZ4eHZpYmhmaW9ha2R3c3RtIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODA0ODMxMzksImV4cCI6MTk5NjA1OTEzOX0.XjnYRQfZF959bxASsF8j7Wa4G9Upl1S7HIWMGgyQSQ4',
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final authenticationRepository = AuthRepository();
  final profileRepository = ProfileRepository();
  bool kReleaseMode = true;
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(
      authenticationRepository: authenticationRepository,
      profileRepository: profileRepository,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository _authenticationRepository;
  final ProfileRepository _profileRepository;

  const MyApp({
    super.key,
    required AuthRepository authenticationRepository,
    required ProfileRepository profileRepository,
  })  : _authenticationRepository = authenticationRepository,
        _profileRepository = profileRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _authenticationRepository,
        child: MultiBlocProvider(
          providers: [
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
          ],
          child: const AppView(),
        ));
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(),
        title: "Hafleh",
        home: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              User? authedUser = FirebaseAuth.instance.currentUser;
              context
                  .read<ProfileBloc>()
                  .add(ProfileLoadRequested(authedUser!.uid));
            } else if (state is UnAuthenticated) {
              context.read<ProfileBloc>().add(ProfileSignoutRequested());
            }
          },
          child: FlowBuilder<AuthRouteState>(
            state: getRouteState(
              context.select((AuthBloc bloc) => bloc.state),
              context.select((ProfileBloc bloc) => bloc.state),
            ),
            onGeneratePages: onGenerateAppViewPages,
          ),
        ));
  }
}
