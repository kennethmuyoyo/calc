import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entiities/user_registration.dart';
import '../../domain/repositories/user_registration_repository.dart';
import '../datasources/user_registration_remote_datasource.dart';
import '../models/user_registration_model.dart';

class UserRegistrationRepositoryImpl implements UserRegistrationRepository {
  final UserRegistrationRemoteDataSource remoteDataSource;

  UserRegistrationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> submitRegistration(UserRegistration registration) async {
    try {
      final registrationModel = UserRegistrationModel.fromEntity(registration);
      await remoteDataSource.submitRegistration(registrationModel);
      return Right(null);
    } on Exception catch (e) {
      if (e.toString().contains('Login already taken')) {
        return Left(LoginTakenFailure());
      }
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isLoginTaken(String login) async {
    try {
      final isTaken = await remoteDataSource.isLoginTaken(login);
      return Right(isTaken);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}