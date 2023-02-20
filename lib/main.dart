import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_map/cubits/search_cubit/search_cubit.dart';
import 'package:test_map/data_models/points_model.dart';
import 'package:test_map/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(model: data),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
