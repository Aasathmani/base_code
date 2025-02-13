import 'package:app_task/src/application/core/base_bloc.dart';
import 'package:app_task/src/application/core/process_state.dart';
import 'package:app_task/src/application/form/form_event.dart';
import 'package:app_task/src/application/form/form_state.dart';
import 'package:app_task/src/core/app_constants.dart';
import 'package:app_task/src/domain/form/form_repository.dart';
import 'package:app_task/src/utils/string_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormFillBloc extends BaseBloc<FormFillEvent, FormFillState> {
  final FormRepository formRepository;
  final String id;
  final String title;
  final String completed;
  FormFillBloc({
    required this.formRepository,
    required this.title,
    required this.id,
    required this.completed,
  }) : super(FormFillState()) {
    on<Initialize>((event, emit) async {
      await userList(event: event, emit: emit);
    });
    on<TitleChanged>((event, emit) {
      emit(state.copyWith(title: event.title));
    });

    on<DescriptionChanged>((event, emit) {
      emit(state.copyWith(description: event.description));
    });

    on<SelectedDate>((event, emit) {
      emit(state.copyWith(dueDate: event.dateTime));
    });

    on<TaskStatus>((event, emit) {
      emit(state.copyWith(taskStatus: event.status));
    });

    on<AssignedUser>((event, emit) {
      emit(state.copyWith(userId: event.userId, userName: event.userName));
    });

    on<PriorityChange>((event, emit) {
      emit(state.copyWith(priorityLevel: event.value));
    });

    on<CreateTaskTapped>((event, emit) async {
      await createTaskTapped(event: event, emit: emit);
    });
    add(Initialize());
  }

  Future<void> createTaskTapped({
    required CreateTaskTapped event,
    required Emitter<FormFillState> emit,
  }) async {
    if (!_isValid(emit)) {
      return;
    }
    emit(state.copyWith()..processState = ProcessState.busy());

    final Map<String, dynamic> responseData = {
      "title": state.title,
      "description": state.description,
      "dueDate": state.dueDate?.toIso8601String(), // ISO 8601 format
      "priority": state.priorityLevel,
      "status": state.taskStatus,
      "assignedUser":
          int.parse(state.userId!), // User ID from User Information API
    };
    if (id == "") {
      final result = await formRepository.getCreateTask(responseData);
      if (result == true) {
        showMessage("Task created successfully");
        emit(
          state.copyWith(createStatus: true)
            ..processState = ProcessState.completed(),
        );
      } else {
        showMessage("The task created failed ,please try again later");
        emit(state.copyWith()..processState = ProcessState.completed());
      }
    } else {
      final result =
          await formRepository.getUpdateTask(responseData, int.parse(id));
      if (result == true) {
        showMessage("Task Updated successfully");
        emit(
          state.copyWith(createStatus: true)
            ..processState = ProcessState.completed(),
        );
      } else {
        showMessage("The task created failed ,please try again later");
        emit(state.copyWith()..processState = ProcessState.completed());
      }
    }
  }

  bool _isValid(Emitter<FormFillState> emit) {
    bool isValid = true;

    if (StringUtils.isNullOrEmpty(state.title)) {
      showMessage("Please enter the title");
      isValid = false;
    } else if (StringUtils.isNullOrEmpty(state.description)) {
      showMessage("Please enter the description");
      isValid = false;
    } else if (StringUtils.isNullOrEmpty(state.dueDate.toString())) {
      showMessage("Please select the due date");
      isValid = false;
    } else if (StringUtils.isNullOrEmpty(state.taskStatus)) {
      showMessage("Please select the task status");
      isValid = false;
    } else if (StringUtils.isNullOrEmpty(state.userId)) {
      showMessage("Please select the assigned user");
      isValid = false;
    } else if (StringUtils.isNullOrEmpty(state.priorityLevel)) {
      showMessage("Please select the select priority");
      isValid = false;
    }

    return isValid;
  }

  Future<void> userList({
    required Initialize event,
    required Emitter<FormFillState> emit,
  }) async {
    String? taskStatus;
    if (completed == "false") {
      taskStatus = PriorityOptions.taskStatus[0];
    } else if (completed == "true") {
      taskStatus = PriorityOptions.taskStatus[2];
    }
    emit(state.copyWith()..processState = ProcessState.completed());
    final result = await formRepository.getUserList();
    if (result!.isNotEmpty) {
      emit(
        state.copyWith(
          userList: result,
          title: title,
          taskStatus: taskStatus,
        )..processState = ProcessState.completed(),
      );
      final userdata = state.userList.firstWhere((user) => id == user!.id);
      emit(state.copyWith(userName: userdata!.firstName, userId: userdata.id));
    } else {
      showMessage("The user List is not getting");
      emit(state.copyWith()..processState = ProcessState.completed());
    }
  }
}
