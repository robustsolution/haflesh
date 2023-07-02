import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:the_hafleh/core/models/user_model.dart';
import 'package:the_hafleh/core/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required AuthRepository authenticationRepository})
      : authRepository = authenticationRepository,
        super(AppInitializing()) {
    on<SplashLoaded>((event, emit) async {
      if (authenticationRepository.isLoggedIn()) {
        UserModel user = await authenticationRepository.createOrFindUser();
        emit(Authenticated(user));
      } else {
        emit(UnAuthenticated());
      }
    });

    on<PhoneSignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signInWithPhone(event.phoneNumber);
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<VerifyOTPRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        UserModel user = await authRepository.verifyOTP(event.code);
        emit(Authenticated(user));
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authenticationRepository.logout();
        emit(UnAuthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
    on<MakeForceSignIn>((event, emit) async {
      emit(Authenticated(
          UserModel(uid: "test", provider: "test", isDisabled: false)));
    });
  }
}
