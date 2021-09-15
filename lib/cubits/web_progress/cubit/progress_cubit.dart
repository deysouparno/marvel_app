import 'package:bloc/bloc.dart';

part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  ProgressCubit() : super(ProgressState(val: 0));

  void emitProgress(double value) => emit(ProgressState(val: value));
}
