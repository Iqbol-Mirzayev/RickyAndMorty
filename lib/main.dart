import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricky_and_morty/future/presentation/bloc/person_list_cubit/cubit/person_list_cubit.dart';
import 'package:ricky_and_morty/future/presentation/bloc/search_bloc/search_bloc.dart';

import 'future/presentation/pages/person_screen.dart';
import 'locator_service.dart' as di;
import 'locator_service.dart ';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di. init();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<PersonListCubit>(create: (context)=> sl<PersonListCubit>()),
      BlocProvider<PersonSearchBloc>(create: (context)=> sl<PersonSearchBloc>()),

    ], child: MaterialApp(
      theme: ThemeData.dark().copyWith(
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.grey,

      ),
      home: HomePage(),
    ));
  }
}