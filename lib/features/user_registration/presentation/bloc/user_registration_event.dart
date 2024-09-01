import 'package:equatable/equatable.dart';
import '../../domain/entiities/user_registration.dart';

abstract class UserRegistrationEvent extends Equatable {
  const UserRegistrationEvent();

  @override
  List<Object> get props => [];
}

class SubmitRegistrationEvent extends UserRegistrationEvent {
  final UserRegistration registration;

  const SubmitRegistrationEvent(this.registration);

  @override
  List<Object> get props => [registration];
}

