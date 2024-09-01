import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart' as di;
import 'features/user_registration/presentation/pages/user_registration_page.dart';
import 'features/user_registration/presentation/bloc/user_registration_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<UserRegistrationBloc>(
        create: (_) => di.sl<UserRegistrationBloc>(),
        child: const UserRegistrationPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}