import 'package:app_task/generated/l10n.dart';
import 'package:app_task/src/application/form/form_bloc.dart';
import 'package:app_task/src/application/form/form_event.dart';
import 'package:app_task/src/application/form/form_state.dart';
import 'package:app_task/src/core/app_constants.dart';
import 'package:app_task/src/presentation/core/app_page.dart';
import 'package:app_task/src/presentation/core/base_state.dart';
import 'package:app_task/src/presentation/core/theme/colors.dart';
import 'package:app_task/src/presentation/core/theme/text_styles.dart';
import 'package:app_task/src/presentation/home/home_page.dart';
import 'package:app_task/src/presentation/register/register_page.dart';
import 'package:app_task/src/presentation/widgets/app_button.dart';
import 'package:app_task/src/presentation/widgets/bordered_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      listener: (context, state) {},
      builder: (context, state) {
        return AppPage(
          title: "",
          isBackButtonRequired: false,
          retryOnTap: () {},
          processStateStream: bloc!.stream.map((state) => state.processState),
          child: _getBodyLayout(context, state),
        );
      },
    );
  }

  Widget _getBodyLayout(BuildContext context, FormFillState state) {
    DateTime? selectedDate;
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
            BorderedTextField(
              key: const Key("title"),
              backgroundColor: AppColors.white,
              labelText: 'Title',
              textColor: AppColors.black,
              onTextChanged: (text) {
                //_bloc!.add(EmailChanged(text));
              },
            ),
            const SizedBox(height: 16),
            const Text("Description"),
            const SizedBox(
              height: 10,
            ),
            BorderedTextField(
              key: const Key("description"),
              backgroundColor: AppColors.white,
              labelText: 'Description',
              onTextChanged: (text) {
                //_bloc!.add(PasswordChange(text));
              },
            ),
            const SizedBox(height: 16),
            const Text("Due Date"),
            Padding(
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
                    borderRadius:
                        BorderRadius.circular(Units.kTextFieldBorderRadius),
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
                      selectedDate.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.body1Bold(context)?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.black),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  scrollbarTheme: ScrollbarThemeData(
                    thumbColor: WidgetStateProperty.all(Colors.blueAccent),
                    trackColor: WidgetStateProperty.all(Colors.grey[300]),
                    thickness: WidgetStateProperty.all(6.0),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: state.priorityLevel,
                    hint: Text("Please select the priority"),
                    isExpanded: true,
                    items: PriorityOptions.priorityOptions.map((priority) {
                      return DropdownMenuItem<String>(
                        value: priority,
                        child: Text(priority),
                      );
                    }).toList(),
                    menuMaxHeight: 300,
                    onChanged: (value) {
                      bloc!.add(PriorityChange(value));
                      // setState(() {
                      //   selectedPriority = value;
                      // });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            AppButton(
              onTap: () {
                Navigator.pushNamed(context, HomePage.route);
                //_bloc!.add(LoginButtonTapped());
              },
              label: "Login".toUpperCase(),
              color: AppColors.ashBlue,
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
