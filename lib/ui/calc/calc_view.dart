import 'package:divide_ai/domain/calc/cubit/calc_cubit.dart';
import 'package:divide_ai/ui/widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalcView extends StatelessWidget {
  const CalcView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.01),
                BlocBuilder<CalcCubit, CalcState>(
                  builder: (context, state) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 16.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 16.0,
                          children: [
                            TextField(
                              autofocus: true,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              decoration: const InputDecoration(
                                label: Text('Valor Total'),
                                hintText: '0,00',
                                border: OutlineInputBorder(),
                                prefixText: 'R\$ ',
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9,.]'),
                                ),
                              ],
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  context.read<CalcCubit>().reset();
                                  return;
                                }
                                final normalizedValue = value.replaceAll(
                                  ',',
                                  '.',
                                );
                                final parsedValue =
                                    double.tryParse(normalizedValue) ?? 0.0;
                                context.read<CalcCubit>().setTotal(parsedValue);
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Valor da gorjeta: ',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black45,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'R\$ ${state.tipAmount.toStringAsFixed(2).replaceAll('.', ',')}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Total da conta: ',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black45,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            'R\$ ${state.totalWithTip.toStringAsFixed(2).replaceAll('.', ',')}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Text('Gorjeta'),
                            SegmentedButton<double>(
                              showSelectedIcon: false,
                              selected: {state.tipPercentage},
                              onSelectionChanged: (Set<double> values) {
                                context.read<CalcCubit>().setTip(values.first);
                              },
                              segments: const [
                                ButtonSegment(value: 0.05, label: Text('5%')),
                                ButtonSegment(value: 0.10, label: Text('10%')),
                                ButtonSegment(value: 0.15, label: Text('15%')),
                                ButtonSegment(value: 0.20, label: Text('20%')),
                                ButtonSegment(value: 0.30, label: Text('30%')),
                                ButtonSegment(value: 0.40, label: Text('40%')),
                              ],
                            ),
                            const Text('Número de pessoas'),
                            SegmentedButton<int>(
                              showSelectedIcon: false,
                              selected: {state.peopleCount},
                              onSelectionChanged: (Set<int> values) {
                                context.read<CalcCubit>().setPeople(
                                  values.first,
                                );
                              },
                              segments: const [
                                ButtonSegment(value: 1, label: Text('1')),
                                ButtonSegment(value: 2, label: Text('2')),
                                ButtonSegment(value: 3, label: Text('3')),
                                ButtonSegment(value: 4, label: Text('4')),
                                ButtonSegment(value: 5, label: Text('5')),
                                ButtonSegment(value: 6, label: Text('6')),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text:
                                        'R\$ ${state.perPersonAmount.toStringAsFixed(2).replaceAll('.', ',')}',
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: ' / por pessoa',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: size.height * 0.01),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
