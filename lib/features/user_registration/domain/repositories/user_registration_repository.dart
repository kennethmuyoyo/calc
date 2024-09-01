import 'package:dartz/dartz.dart';
import 'package:polynomial_calculator/features/user_registration/domain/entiities/user_registration.dart';
import '../../../../core/error/failure.dart';

abstract class UserRegistrationRepository {
  Future<Either<Failure, void>> submitRegistration(UserRegistration registration);
  Future<Either<Failure, bool>> isLoginTaken(String login);
}