import 'package:divide_ai/domain/calc/cubit/calc_cubit.dart';
import 'package:divide_ai/ui/calc/calc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcPage extends StatelessWidget {
  const CalcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => CalcCubit(), child: const CalcView());
  }
}
