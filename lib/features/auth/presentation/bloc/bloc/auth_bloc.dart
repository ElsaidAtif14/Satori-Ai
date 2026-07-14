import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_ai/features/auth/domain/repos/auth_repo.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo}) : super(AuthInitial()) {
    
    // 1. Register Event Handler
    on<RegisterWithEmailAndPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await authRepo.createUserWithEmialAndPassword(
        event.email,
        event.password,
        event.name,
      );
      result.fold(
        (failure) => emit(AuthFailure(errorMessage: failure.message)),
        (userEntity) => emit(AuthSuccess(userEntity: userEntity)),
      );
    });

    // 2. Login Event Handler
    on<LoginWithEmailAndPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await authRepo.signInWithEmialAndPassword(
        event.email,
        event.password,
      );
      result.fold(
        (failure) => emit(AuthFailure(errorMessage: failure.message)),
        (userEntity) => emit(AuthSuccess(userEntity: userEntity)),
      );
    });

    // 3. Google Sign In Event Handler
    on<LoginWithGoogleEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await authRepo.signInWithGoogle();
      result.fold(
        (failure) => emit(AuthFailure(errorMessage: failure.message)),
        (userEntity) => emit(AuthSuccess(userEntity: userEntity)),
      );
    });
  }
}