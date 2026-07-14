abstract class AuthEvent {}

class RegisterWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  RegisterWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
    required this.name,
  });
}

class LoginWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  LoginWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });
}

class LoginWithGoogleEvent extends AuthEvent {}