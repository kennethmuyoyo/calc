import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/user_registration/data/datasources/user_registration_remote_datasource.dart';
import '../../features/user_registration/data/repositories/user_registration_repositoryImpl.dart';
import '../../features/user_registration/domain/repositories/user_registration_repository.dart';
import '../../features/user_registration/domain/usecases/submit_user_registration.dart';
import '../../features/user_registration/presentation/bloc/user_registration_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => UserRegistrationBloc(submitUserRegistration: sl()));

  sl.registerLazySingleton(() => SubmitUserRegistration(sl()));

  sl.registerLazySingleton<UserRegistrationRepository>(
    () => UserRegistrationRepositoryImpl(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<UserRegistrationRemoteDataSource>(
    () => UserRegistrationRemoteDataSourceImpl(firestore: sl()),
  );

  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
