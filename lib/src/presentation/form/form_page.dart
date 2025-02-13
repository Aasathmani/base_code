import 'package:app_task/src/application/form/form_bloc.dart';
import 'package:app_task/src/application/form/form_event.dart';
import 'package:app_task/src/application/form/form_state.dart';
import 'package:app_task/src/core/app_constants.dart';
import 'package:app_task/src/domain/database/core/app_database.dart';
import 'package:app_task/src/presentation/core/app_page.dart';
import 'package:app_task/src/presentation/core/base_state.dart';
import 'package:app_task/src/presentation/core/theme/colors.dart';
import 'package:app_task/src/presentation/core/theme/text_styles.dart';
import 'package:app_task/src/presentation/home/home_page.dart';
import 'package:app_task/src/presentation/widgets/app_button.dart';
import 'package:app_task/src/presentation/widgets/bordered_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormPage extends StatefulWidget {
  static const route = "/formPage";
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<FormPage> {
  FormFillBloc? bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<FormFillBloc>(context);
    bloc!.message.listen((value) => showMessage(value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormFillBloc, FormFillState>(
      listener: (context, state) {
        if (state.createStatus == true) {
          Navigator.popAndPushNamed(context, HomePage.route);
        }
      },
      builder: (context, state) {
        return AppPage(
          title: "Form Page",
          retryOnTap: () {},
          processStateStream: bloc!.stream.map((state) => state.processState),
          child: _getBodyLayout(context, state),
        );
      },
    );
  }

  Widget _getBodyLayout(BuildContext context, FormFillState state) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 32),
            const Text("Title"),
            const SizedBox(
              height: 10,
            ),
            _titleTextField(context, state),
            const SizedBox(height: 16),
            const Text("Description"),
            const SizedBox(
              height: 10,
            ),
            _descriptionTextField(context, state),
            const SizedBox(height: 16),
            const Text("Due Date"),
            _dueDatePicker(context, state),
            const SizedBox(
              height: 25,
            ),
            const Text("Select priority"),
            const SizedBox(
              height: 10,
            ),
            _selectPriorityDropDown(context, state),
            const SizedBox(
              height: 25,
            ),
            const Text("Task Status"),
            const SizedBox(
              height: 10,
            ),
            _taskStatusDropDown(context, state),
            const SizedBox(
              height: 25,
            ),
            const Text("Assigned User"),
            const SizedBox(
              height: 10,
            ),
            _assignedUserDropDown(context, state),
            const SizedBox(height: 60),
            AppButton(
              onTap: () {
                bloc!.add(CreateTaskTapped());
              },
              label: bloc!.id == ""
                  ? "Create".toUpperCase()
                  : "Update".toUpperCase(),
              color: AppColors.ashBlue,
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _titleTextField(BuildContext context, FormFillState state) {
    return BorderedTextField(
      key: const Key("title"),
      backgroundColor: AppColors.white,
      labelText: 'Title',
      textColor: AppColors.black,
      maxLines: 2,
      style: TextStyles.bodyRegular(context),
      textStream: bloc!.stream.map((state) => state.title),
      onTextChanged: (text) {
        bloc!.add(TitleChanged(text));
      },
    );
  }

  Widget _descriptionTextField(BuildContext context, FormFillState state) {
    return BorderedTextField(
      key: const Key("description"),
      backgroundColor: AppColors.white,
      labelText: 'Description',
      style: TextStyles.bodyRegular(context),
      onTextChanged: (text) {
        bloc!.add(DescriptionChanged(text));
      },
    );
  }

  Widget _dueDatePicker(BuildContext context, FormFillState state) {
    DateTime? selectedDate;
    return Padding(
      padding: const EdgeInsets.only(top: Units.kStandardPadding),
      child: GestureDetector(
        onTap: () async {
          selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2010),
            lastDate: DateTime(2100),
          );
          bloc!.add(SelectedDate(selectedDate));
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Units.kTextFieldBorderRadius),
            border: Border.all(),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: Units.kStandardPadding,
              bottom: Units.kStandardPadding,
              left: Units.kStandardPadding,
              right: Units.kStandardPadding,
            ),
            child: Text(
              state.dueDate.toString(),
              overflow: TextOverflow.ellipsis,
              style: TextStyles.body1Regular(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectPriorityDropDown(BuildContext context, FormFillState state) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: WidgetStateProperty.all(Colors.blueAccent),
            trackColor: WidgetStateProperty.all(Colors.grey[300]),
            thickness: WidgetStateProperty.all(6.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Units.kSPadding),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: state.priorityLevel,
              hint: const Text("Please select the priority"),
              isExpanded: true,
              items: PriorityOptions.priorityOptions.map((priority) {
                return DropdownMenuItem<String>(
                  value: priority,
                  child: Text(
                    priority,
                    style: TextStyles.body1Regular(context),
                  ),
                );
              }).toList(),
              menuMaxHeight: 300,
              onChanged: (value) {
                bloc!.add(PriorityChange(value));
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _taskStatusDropDown(BuildContext context, FormFillState state) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: WidgetStateProperty.all(Colors.blueAccent),
            trackColor: WidgetStateProperty.all(Colors.grey[300]),
            thickness: WidgetStateProperty.all(6.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Units.kSPadding),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: state.taskStatus,
              hint: const Text("Please select the task status"),
              isExpanded: true,
              items: PriorityOptions.taskStatus.map((priority) {
                return DropdownMenuItem<String>(
                  value: priority,
                  child: Text(
                    priority,
                    style: TextStyles.body1Regular(context),
                  ),
                );
              }).toList(),
              menuMaxHeight: 300,
              onChanged: (value) {
                bloc!.add(TaskStatus(value));
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _assignedUserDropDown(BuildContext context, FormFillState state) {
    final List<UserList?> userList = state.userList;
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: WidgetStateProperty.all(Colors.blueAccent),
            trackColor: WidgetStateProperty.all(Colors.grey[300]),
            thickness: WidgetStateProperty.all(6.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Units.kSPadding),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: state.userId,
              hint: const Text("Please select the assigned user"),
              isExpanded: true,
              items: userList.map((user) {
                return DropdownMenuItem<String>(
                  value: user?.id,
                  child: Text(
                    user!.firstName,
                    style: TextStyles.body1Regular(context),
                  ),
                );
              }).toList(),
              menuMaxHeight: 300,
              onChanged: (value) {
                final selectedAssetGroup = userList.firstWhere(
                  (assetGroup) => assetGroup!.id == value,
                );
                bloc!.add(
                  AssignedUser(
                    userId: selectedAssetGroup!.id,
                    userName: selectedAssetGroup.firstName,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
