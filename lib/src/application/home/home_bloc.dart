import 'package:app_task/src/application/core/base_bloc.dart';
import 'package:app_task/src/application/core/process_state.dart';
import 'package:app_task/src/application/home/home_event.dart';
import 'package:app_task/src/application/home/home_state.dart';
import 'package:app_task/src/domain/home/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;
  HomeBloc({
    required this.homeRepository,
  }) : super(HomeState()) {
    on<Initialize>((event, emit) async {
      await initializeList(event: event, emit: emit);
    });
    on<DeleteIconTapped>((event, emit) async {
      await _deleteIconTapped(event: event, emit: emit);
    });
    add(Initialize());
  }

  Future<void> initializeList({
    required Initialize event,
    required Emitter<HomeState> emit,
  }) async {
    emit(state.copyWith()..processState = ProcessState.busy());

    final result = await homeRepository.getTaskList();
    if (result.isNotEmpty) {
      emit(
        state.copyWith(taskList: result, deleteTaskStatus: false)
          ..processState = ProcessState.completed(),
      );
    } else {
      showMessage("Something wend wrong");
    }
  }

  Future<void> _deleteIconTapped({
    required DeleteIconTapped event,
    required Emitter<HomeState> emit,
  }) async {
    emit(state.copyWith()..processState = ProcessState.busy());

    final result = await homeRepository.getDeleteTask(event.id);
    if (result) {
      showMessage("The task is deleted successfully");
    } else {
      showMessage("Something went wrong ,please try again later");
    }
    emit(state.copyWith()..processState = ProcessState.completed());
  }
}
