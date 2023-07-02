part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AppInitializing extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  final UserModel user;

  Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
