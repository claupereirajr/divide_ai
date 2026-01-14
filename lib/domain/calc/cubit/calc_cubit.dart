import 'package:bloc/bloc.dart';

class CalcState {
  final double billAmount;
  final double tipPercentage;
  final int peopleCount;

  CalcState({
    this.billAmount = 0.0,
    this.tipPercentage = 0.10,
    this.peopleCount = 1,
  });

  double get tipAmount => billAmount * tipPercentage;
  double get totalWithTip => billAmount + tipAmount;
  double get perPersonAmount =>
      peopleCount > 0 ? totalWithTip / peopleCount : 0.0;

  CalcState copyWith({
    double? billAmount,
    double? tipPercentage,
    int? peopleCount,
  }) {
    return CalcState(
      billAmount: billAmount ?? this.billAmount,
      tipPercentage: tipPercentage ?? this.tipPercentage,
      peopleCount: peopleCount ?? this.peopleCount,
    );
  }
}

class CalcCubit extends Cubit<CalcState> {
  CalcCubit() : super(CalcState());

  void setTotal(double total) {
    emit(state.copyWith(billAmount: total));
  }

  void setTip(double tip) {
    emit(state.copyWith(tipPercentage: tip));
  }

  void setPeople(int people) {
    emit(state.copyWith(peopleCount: people));
  }

  void reset() {
    emit(CalcState());
  }

  double getTotal() {
    return state.perPersonAmount;
  }
}
