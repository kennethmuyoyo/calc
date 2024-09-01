import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:polynomial_calculator/features/user_registration/presentation/bloc/user_registration_event.dart';
import 'package:polynomial_calculator/features/user_registration/presentation/bloc/user_registration_state.dart';
import '../../../../core/error/failure.dart';
import '../../domain/usecases/submit_user_registration.dart';

class UserRegistrationBloc
    extends Bloc<UserRegistrationEvent, UserRegistrationState> {
  final SubmitUserRegistration submitUserRegistration;

  UserRegistrationBloc({required this.submitUserRegistration})
      : super(UserRegistrationInitial()) {
    on<SubmitRegistrationEvent>(_onSubmitRegistration);
  }

  Future<void> _onSubmitRegistration(
    SubmitRegistrationEvent event,
    Emitter<UserRegistrationState> emit,
  ) async {
    emit(UserRegistrationLoading());
    final result = await submitUserRegistration(event.registration);
    result.fold(
      (failure) {
        if (failure is LoginTakenFailure) {
          emit(const UserRegistrationError(
              message:
                  'This login is already taken. Please choose a different one.'));
        } else {
          emit(const UserRegistrationError(
              message: 'Registration failed. Please try again.'));
        }
      },
      (_) {
        emit(UserRegistrationSuccess());
      },
    );
  }
}
