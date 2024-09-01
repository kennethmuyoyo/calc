import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_registration_model.dart';

abstract class UserRegistrationRemoteDataSource {
  Future<void> submitRegistration(UserRegistrationModel registration);
  Future<bool> isLoginTaken(String login);
}

class UserRegistrationRemoteDataSourceImpl implements UserRegistrationRemoteDataSource {
  final FirebaseFirestore firestore;

  UserRegistrationRemoteDataSourceImpl({required this.firestore});

  @override
  Future<void> submitRegistration(UserRegistrationModel registration) async {
    try {
      if (await isLoginTaken(registration.login)) {
        throw Exception('Login already taken');
      }
      await firestore.collection('users').doc(registration.login).set(registration.toJson());
    } catch (e) {
      throw Exception('Failed to submit registration: $e');
    }
  }

  @override
  Future<bool> isLoginTaken(String login) async {
    final docSnapshot = await firestore.collection('users').doc(login).get();
    return docSnapshot.exists;
  }
}