import 'package:polynomial_calculator/features/user_registration/domain/entiities/user_registration.dart';

class UserRegistrationModel extends UserRegistration {
  UserRegistrationModel({
    required String login,
    required String password,
    required String polynomial,
    required String derivative,
  }) : super(
          login: login,
          password: password,
          polynomial: polynomial,
          derivative: derivative,
        );

  factory UserRegistrationModel.fromEntity(UserRegistration entity) {
    return UserRegistrationModel(
      login: entity.login,
      password: entity.password,
      polynomial: entity.polynomial,
      derivative: entity.derivative,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
      'polynomial': polynomial,
      'derivative': derivative,
    };
  }
}
