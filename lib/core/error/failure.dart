abstract class Failure {}

class ServerFailure extends Failure {}

class LoginTakenFailure extends Failure {
  List<Object?> get props => [];
}