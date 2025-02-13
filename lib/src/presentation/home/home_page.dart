import 'package:app_task/src/application/home/home_bloc.dart';
import 'package:app_task/src/application/home/home_event.dart';
import 'package:app_task/src/application/home/home_state.dart';
import 'package:app_task/src/core/app_constants.dart';
import 'package:app_task/src/domain/auth/auth.dart';
import 'package:app_task/src/domain/database/core/app_database.dart';
import 'package:app_task/src/presentation/core/app_page.dart';
import 'package:app_task/src/presentation/core/base_state.dart';
import 'package:app_task/src/presentation/core/theme/colors.dart';
import 'package:app_task/src/presentation/core/theme/text_styles.dart';
import 'package:app_task/src/presentation/form/form_page.dart';
import 'package:app_task/src/presentation/login/login_page.dart';
import 'package:app_task/src/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const route = "/homeState";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage> {
  HomeBloc? bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = BlocProvider.of<HomeBloc>(context);
    bloc!.message.listen((value) => showMessage(value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.deleteTaskStatus == true) {
          bloc!.add(Initialize());
        }
      },
      builder: (context, state) {
        return AppPage(
          title: "Task List",
          isBackButtonRequired: false,
          retryOnTap: () {},
          processStateStream: bloc!.stream.map((state) => state.processState),
          actions: [
            _addTaskButton(context),
          ],
          leading: Padding(
            padding: const EdgeInsets.only(
              top: Units.kStandardPadding,
              left: 20,
            ),
            child: InkWell(
              onTap: () async {
                await AuthDao().saveToken("");
                Navigator.pushReplacementNamed(context, LoginPage.route);
              },
              child: const Icon(
                Icons.logout,
              ),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: Units.kStandardPadding),
            child: _getBodyLayout(context, state),
          ),
        );
      },
    );
  }

  Widget _addTaskButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Units.kSPadding),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            FormPage.route,
            arguments: FormPageArguments(
              id: "",
              title: "",
              complete: "",
            ),
          );
        },
        child: Text(
          "Add task",
          style:
              TextStyles.body1Bold(context)!.copyWith(color: AppColors.black),
        ),
      ),
    );
  }

  Widget _getBodyLayout(BuildContext context, HomeState state) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: state.taskList.length,
          itemBuilder: (context, index) {
            final item = state.taskList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Units.kStandardPadding,
              ),
              child: Column(
                children: [
                  _itemLayout(context, item!),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _itemLayout(BuildContext context, TaskList item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Units.kSPadding),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            _titleTextWithData(context, item),
            const SizedBox(
              height: 30,
            ),
            _completeStatusWithData(context, item),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _titleTextWithData(BuildContext context, TaskList item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Text("Title: ", style: TextStyles.body1BoldMarkdown(context)),
              Expanded(
                child: Text(
                  item.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              FormPage.route,
              arguments: FormPageArguments(
                id: item.userId,
                title: item.title,
                complete: item.completed.toString(),
              ),
            );
          },
          child: const Icon(
            Icons.edit,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _completeStatusWithData(BuildContext context, TaskList item) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text("Complete : ", style: TextStyles.body1BoldMarkdown(context)),
              Text(item.completed.toString()),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Are you want to delete the task"),
                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _cancelButton(context),
                        _confirmButton(context, item),
                      ],
                    ),
                  ],
                );
              },
            );
            //bloc!.add(DeleteIconTapped(item.id));
          },
          child: const Icon(
            Icons.delete,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _cancelButton(BuildContext context) {
    return AppButton(
      onTap: () {
        Navigator.pop(context);
      },
      label: "no",
      color: AppColors.transparent,
      labelStyle:
          TextStyles.body1Bold(context)!.copyWith(color: AppColors.black),
    );
  }

  Widget _confirmButton(BuildContext context, TaskList item) {
    return AppButton(
      onTap: () {
        bloc!.add(DeleteIconTapped(item.id));
        Navigator.pop(context);
      },
      color: AppColors.ashBlue,
      label: "Confirm",
    );
  }
}

class FormPageArguments {
  String id;
  String title;
  String complete;

  FormPageArguments({
    required this.id,
    required this.title,
    required this.complete,
  });
}
