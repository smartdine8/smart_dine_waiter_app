import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartdine_waiter/base_state.dart';

class HomeCubit extends Cubit<BaseState> {
  HomeCubit() : super(StateInitial());
  int currentPageIndex = 0;

  void changeItemIndex(int index) {
    currentPageIndex = index;
    emit(StateOnSuccess(currentPageIndex));
  }
}
