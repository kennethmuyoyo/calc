import 'package:dartz/dartz.dart';
import 'package:polynomial_calculator/features/user_registration/domain/entiities/user_registration.dart';
import 'package:polynomial_calculator/features/user_registration/domain/repositories/user_registration_repository.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';

class SubmitUserRegistration implements UseCase<void, UserRegistration> {
  final UserRegistrationRepository repository;

  SubmitUserRegistration(this.repository);

  @override
  Future<Either<Failure, void>> call(UserRegistration params) async {
    return await repository.submitRegistration(params);
  }
}